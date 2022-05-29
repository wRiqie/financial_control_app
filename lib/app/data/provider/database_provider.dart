import 'dart:convert' as convert;
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/models/category_month.dart';
import 'package:financial_control_app/app/data/models/month.dart';
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
        await db.execute(_createTableMonth);
        await db.execute(_createTableBill);
        await db.execute(_createTableCategory);
        await db.execute(_createTableCategoryMonth);
      },
      onCreate: (Database db, int version) async {
        await db.execute(_createTableMonth);
        await db.execute(_createTableBill);
        await db.execute(_createTableCategory);
        await db.execute(_createTableCategoryMonth);
      },
    );
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
    } catch (e) {
      print(e);
    }
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

  Future<Month?> getMonthByDate(String date) async {
    final db = await database;
    if (db != null) {
      var res = await db.query(
        monthTable,
        where: '$_monthDate = ?',
        whereArgs: [date],
      );
      return res.isNotEmpty ? Month.fromMap(res.first) : null;
    }
    return null;
  }

  Future<List<Month>> getLastMonths() async {
    const int limit = 6;
    final db = await database;
    if (db != null) {
      var res = await db.query(
        monthTable,
        orderBy: '$_monthDate DESC',
        limit: limit,
      );
      return res.isNotEmpty ? res.map((e) => Month.fromMap(e)).toList() : [];
    }
    return [];
  }

  // Category
  static const categoryTable = 'category';
  static const _categoryId = 'id';
  static const _categorySelected = 'selected';

  static const _createTableCategory = """
    CREATE TABLE IF NOT EXISTS $categoryTable(
      $_categoryId INTEGER NOT NULL PRIMARY KEY,
      $_categorySelected INTEGER
    );
  """;

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
      var res = await db.query(categoryTable,
          where: '$_categorySelected = ?', whereArgs: [1]);
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
}
