import 'dart:convert' as convert;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:financial_control_app/app/core/values/categories.dart';

import '../../core/values/constants.dart';
import '../enums/bill_status_enum.dart';
import '../models/bill.dart';
import '../models/category.dart';
import '../models/category_month.dart';
import '../models/month.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final db = DatabaseProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, Constants.dbName);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        await _createTables(db);
      },
      onCreate: (Database db, int version) async {
        await _createTables(db);
        await _insertBaseCategories(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    await db.execute(_createTableMonth);
    await db.execute(_createTableBill);
    await db.execute(_createTableCategory);
    await db.execute(_createTableCategoryMonth);
  }

  // Backup
  Future<List<String>> _getTables() async {
    final db = await database;
    if (db != null) {
      final tableNames = (await db
              .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
          .map((row) => row['name'] as String)
          .toList(growable: false);
      return tableNames;
    }
    return [];
  }

  Future<String?> generateBackup({bool isEncrypted = true}) async {
    final db = await database;
    if (db != null) {
      List data = [];
      List<Map<String, dynamic>> listMaps = [];
      final tables = await _getTables();

      for (var i = 0; i < tables.length; i++) {
        listMaps = await db.query(tables[i]);

        data.add(listMaps);
      }

      List backups = [tables, data];
      String json = convert.jsonEncode(backups);
      if (isEncrypted) {
        var key = encrypt.Key.fromUtf8(Constants.secretKey);
        var iv = encrypt.IV.fromLength(16);
        var encrypter = encrypt.Encrypter(encrypt.AES(key));
        var encrypted = encrypter.encrypt(json, iv: iv);

        return encrypted.base64;
      }
      return json;
    }
    return null;
  }

  Future<bool> restoreBackup(String backup, {bool isEncrypted = true}) async {
    final db = await database;

    if (db != null) {
      Batch batch = db.batch();

      var key = encrypt.Key.fromUtf8(Constants.secretKey);
      var iv = encrypt.IV.fromLength(16);
      var encrypter = encrypt.Encrypter(encrypt.AES(key));

      List json = convert.jsonDecode(
          isEncrypted ? encrypter.decrypt64(backup, iv: iv) : backup);

      try {
        for (var i = 0; i < json[0].length; i++) {
          for (var k = 0; k < json[1][i].length; k++) {
            batch.insert(json[0][i], json[1][i][k]);
          }
        }

        await batch.commit(continueOnError: true, noResult: true);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future clearAllTables() async {
    try {
      var db = await database;
      final tables = await _getTables();
      if (db != null) {
        for (String table in tables) {
          await db.delete(table);
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  // Generic
  Future<int> save({required dynamic data, required String table}) async {
    final db = await database;
    if (db != null) {
      var res = await db.insert(
        table,
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    }
    return 0;
  }

  Future<void> saveAll(
      {required List<dynamic> datas, required String table}) async {
    final db = await database;
    if (db != null) {
      await Future.forEach<dynamic>(datas, (data) async {
        await db.insert(
          table,
          data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    }
  }

  // Bill
  static const billTable = 'bill';
  static const _billId = 'id';
  static const _billCategoryId = 'categoryId';
  static const _billTitle = 'title';
  static const _billValue = 'value';
  static const _billPortion = 'portion';
  static const _billMaxPortion = 'maxPortion';
  static const _billDueDate = 'dueDate';
  static const _billStatus = 'status';
  static const _billDate = 'date';

  static const _createTableBill = """
    CREATE TABLE IF NOT EXISTS $billTable(
      $_billId TEXT NOT NULL PRIMARY KEY,
      $_billCategoryId INTEGER,
      $_billTitle TEXT,
      $_billValue REAL,
      $_billPortion INTEGER,
      $_billMaxPortion INTEGER,
      $_billDueDate INTEGER,
      $_billStatus INTEGER,
      $_billDate TEXT
    );
  """;

  Future<List<Bill>> getBillsByDate(String date) async {
    final db = await database;
    if (db != null) {
      var res = await db.query(
        billTable,
        where: '$_billDate = ?',
        whereArgs: [date],
      );
      return res.isNotEmpty ? res.map((e) => Bill.fromMap(e)).toList() : [];
    }
    return [];
  }

  Future<List<Bill>> getBillsByCategoryIdAndDate(
      int categoryId, String date) async {
    final db = await database;
    if (db != null) {
      var res = await db.query(
        billTable,
        where: '$_billCategoryId = ? AND $_billDate = ?',
        whereArgs: [categoryId, date],
      );
      return res.isNotEmpty ? res.map((e) => Bill.fromMap(e)).toList() : [];
    }
    return [];
  }

  Future<int> deleteBillById(String id) async {
    final db = await database;
    if (db != null) {
      var res = await db.delete(
        billTable,
        where: '$_billId = ?',
        whereArgs: [id],
      );
      return res;
    }
    return 0;
  }

  Future<int> deleteBillsByCategoryIdAndDate(
      int categoryId, String date) async {
    final db = await database;
    if (db != null) {
      var res = await db.delete(
        billTable,
        where: '$_billCategoryId = ? AND $_billDate = ?',
        whereArgs: [categoryId, date],
      );
      return res;
    }
    return 0;
  }

  Future<int> deleteBillsByIds(List<Bill> bills) async {
    final db = await database;
    if (db != null) {
      var res = await db.delete(
        billTable,
        where: '$_billId IN (${splitBillsList(bills)})',
      );
      return res;
    }
    return 0;
  }

  String splitBillsList(List<Bill> bills) {
    final splittedList = StringBuffer();
    for (var bill in bills) {
      splittedList
          .write(bills.last != bill ? "'${bill.id}', " : "'${bill.id}'");
    }
    return splittedList.toString();
  }

  Future<num> getBillsTotalPriceOfMonthCategory(
      int categoryId, String date) async {
    final db = await database;
    if (db != null) {
      var res = await db.rawQuery("""
            SELECT SUM($_billValue) AS total FROM $billTable
            WHERE $_billCategoryId = ? AND $_billDate = ?
          """, [categoryId, date]);
      num? total = res.isNotEmpty ? res.first['total'] as num? : 0.0;
      return total ?? 0.0;
    }
    return 0.0;
  }

  // Month
  static const monthTable = 'month';
  static const _monthDate = 'date';
  static const _monthTotalPrice = 'totalPrice';
  static const _monthBalance = 'balance';

  static const _createTableMonth = """
    CREATE TABLE IF NOT EXISTS $monthTable(
      $_monthDate TEXT NOT NULL PRIMARY KEY,
      $_monthTotalPrice REAL,
      $_monthBalance REAL
    );
  """;

  // void test() async {
  //   final db = await database;
  //   if (db != null) {
  //     final sql = StringBuffer();

  //     sql.write(" SELECT *");
  //     // sql.write(" COALESCE(SUM(B.$_billValue), 0.0) AS RESULT ");
  //     sql.write(" FROM $billTable B ");
  //     sql.write(" INNER JOIN $categoryTable C ");
  //     sql.write(" ON B.$_billCategoryId = C.$_categoryId ");
  //     // sql.write(" WHERE B.$_billDate = '06-23' ");
  //     // sql.write(" AND C.$_categorySelected = 1 ");
  //     sql.write(
  //         " AND $_billStatus IN (${EBillStatus.overdue.id}, ${EBillStatus.pendent.id})");

  //     // sql.write(" SELECT SUM($_billValue) FROM $billTable ");
  //     // sql.write(
  //     //     " WHERE $_billStatus IN (${EBillStatus.overdue.id}, ${EBillStatus.pendent.id}) ");

  //     final teste = await db.rawQuery(
  //       sql.toString(),
  //       // ['${EBillStatus.overdue.id}, ${EBillStatus.pendent.id}']
  //     );
  //     print(teste);
  //   }
  // }

  Future<List<Month>> getMonths() async {
    final db = await database;
    if (db != null) {
      var res = await db.query(monthTable);
      return res.isNotEmpty ? res.map((e) => Month.fromMap(e)).toList() : [];
    }
    return [];
  }

  Future<Month?> getMonthByDate(String date, bool onlySelected) async {
    final db = await database;
    if (db != null) {
      var res = await db.query(
        monthTable,
        where: '$_monthDate = ?',
        whereArgs: [date],
      );
      final month = res.isNotEmpty ? Month.fromMap(res.first) : null;
      if (month != null) {
        month.totalPrice = await getMonthTotalPrice(date, onlySelected);
        month.totalUnpaid =
            await getMonthTotalPrice(date, onlySelected, onlyUnpaid: true);
      }
      return month;
    }
    return null;
  }

  Future<String?> getLastMonthDate() async {
    final db = await database;
    if (db != null) {
      final sql = StringBuffer();
      sql.write(" SELECT MAX($_monthDate) as monthDate ");
      sql.write(" FROM $monthTable ");
      var res = await db.rawQuery(sql.toString());
      return res.isNotEmpty ? res.first['monthDate'].toString() : null;
    }
    return null;
  }

  Future<List<Month>> getLastMonths(bool onlySelected) async {
    const int limit = 6;
    final db = await database;
    if (db != null) {
      var res = await db.query(
        monthTable,
        orderBy: '$_monthDate DESC',
        limit: limit,
      );

      List<Month> months =
          res.isNotEmpty ? res.map((e) => Month.fromMap(e)).toList() : [];
      for (var month in months) {
        month.totalPrice = await getMonthTotalPrice(month.date, onlySelected);
        month.totalUnpaid = await getMonthTotalPrice(month.date, onlySelected,
            onlyUnpaid: true);
      }
      return months;
    }
    return [];
  }

  Future<num> getMonthTotalPrice(String date, bool onlySelected,
      {bool onlyUnpaid = false}) async {
    final db = await database;
    if (db != null) {
      final sql = StringBuffer();
      sql.write(" SELECT ");
      sql.write(" COALESCE(SUM(B.$_billValue), 0.0) AS RESULT ");
      sql.write(" FROM $billTable B ");
      sql.write(" INNER JOIN $categoryTable C ");
      sql.write(" ON B.$_billCategoryId = C.$_categoryId ");
      sql.write(" WHERE B.$_billDate = ? ");
      sql.write(" AND C.$_categorySelected = ? ");
      if (onlyUnpaid) {
        sql.write(
            " AND $_billStatus IN (${EBillStatus.overdue.id}, ${EBillStatus.pendent.id})");
      }

      var res = await db.rawQuery(sql.toString(), [
        date,
        onlySelected ? 1 : 0,
      ]);

      return res.isNotEmpty ? res.first['RESULT'] as num : 0.0;
    }
    return 0.0;
  }

  // Category
  static const categoryTable = 'category';
  static const _categoryId = 'id';
  static const _categoryName = 'name';
  static const _categoryTranslateName = 'translateName';
  static const _categorySelected = 'selected';
  static const _categoryColor = 'color';
  static const _categoryIconCodePoint = 'iconCodePoint';
  static const _categorySortOrder = 'sortOrder';

  static const _createTableCategory = """
    CREATE TABLE IF NOT EXISTS $categoryTable(
      $_categoryId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $_categoryName TEXT,
      $_categoryTranslateName TEXT,
      $_categorySelected INTEGER,
      $_categoryColor INTEGER,
      $_categoryIconCodePoint INTEGER,
      $_categorySortOrder INTEGER
    );
  """;

  Future<void> _insertBaseCategories(Database db) async {
    final sql = StringBuffer();
    for (var category in Categories.baseValues) {
      sql.clear();

      sql.write(" INSERT INTO $categoryTable ");
      sql.write(" ($_categoryTranslateName, ");
      sql.write(" $_categorySelected, ");
      sql.write(" $_categoryColor, ");
      sql.write(" $_categoryIconCodePoint, ");
      sql.write(" $_categorySortOrder) ");
      sql.write(" SELECT '${category.translateName}', ");
      sql.write(" ${category.selected}, ");
      sql.write(" ${category.color}, ");
      sql.write(" ${category.iconCodePoint}, ");
      sql.write(" COALESCE(MAX($_categorySortOrder), -1) + 1 ");
      sql.write(" FROM $categoryTable ");

      await db.rawInsert(sql.toString());
    }
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    if (db != null) {
      var res = await db.query(categoryTable);
      return res.isNotEmpty ? res.map((e) => Category.fromMap(e)).toList() : [];
    }
    return [];
  }

  Future<List<Category>> getSelectedCategories() async {
    final db = await database;
    if (db != null) {
      var res = await db.query(
        categoryTable,
        where: '$_categorySelected = ?',
        whereArgs: [1],
      );
      return res.isNotEmpty ? res.map((e) => Category.fromMap(e)).toList() : [];
    }
    return [];
  }

  // Category Month
  static const categoryMonthTable = 'categoryMonth';
  static const _categoryMonthId = 'categoryMonthId';
  static const _categoryMonthCategoryId = 'categoryId';
  static const _categoryMonthMonth = 'month';
  static const _categoryMonthValue = 'value';

  static const _createTableCategoryMonth = """
    CREATE TABLE IF NOT EXISTS $categoryMonthTable(
      $_categoryMonthId INTEGER NOT NULL PRIMARY KEY,
      $_categoryMonthCategoryId INTEGER,
      $_categoryMonthMonth TEXT,
      $_categoryMonthValue REAL
    );
  """;

  Future<List<CategoryMonth>> getCategoryMonthsByCategoryIdAndMonth(
      int categoryId, String month) async {
    final db = await database;
    if (db != null) {
      var res = await db.query(
        categoryMonthTable,
        where: '$_categoryMonthCategoryId = ? AND $_categoryMonthMonth = ?',
        whereArgs: [categoryId, month],
      );
      return res.isNotEmpty
          ? res.map((e) => CategoryMonth.fromMap(e)).toList()
          : [];
    }
    return [];
  }

  // Future<int> deleteCategoryMonth(String) async {}
}
