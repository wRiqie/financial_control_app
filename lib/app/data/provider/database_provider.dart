import 'package:financial_control_app/app/data/models/bill.dart';
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
    String path = join(databasePath, 'finances.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        await db.execute(_createTableMonth);
        await db.execute(_createTableBill);
      },
      onCreate: (Database db, int version) async {
        await db.execute(_createTableMonth);
        await db.execute(_createTableBill);
      },
    );
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
        await db.insert(table, data.toMap());
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

  // Month
  static const monthTable = 'month';
  static const _monthDate = 'date';
  static const _monthTotalPrice = 'totalPrice';
  static const _monthPricePaid = 'pricePaid';

  static const _createTableMonth = """
    CREATE TABLE IF NOT EXISTS $monthTable(
      $_monthDate TEXT NOT NULL PRIMARY KEY,
      $_monthTotalPrice REAL,
      $_monthPricePaid REAL
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
}
