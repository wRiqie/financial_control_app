import '../models/month_model.dart';
import '../provider/database_provider.dart';

class MonthRepository {
  final _table = DatabaseProvider.monthTable;
  final DatabaseProvider db;

  MonthRepository(this.db);

  Future<int> saveMonth(MonthModel month) =>
      db.save(data: month, table: _table);

  Future<List<MonthModel>> getMonths() => db.getMonths();

  Future<MonthModel?> getMonthByDate(String date, {bool onlySelected = true}) =>
      db.getMonthByDate(date, onlySelected);

  Future<List<MonthModel>> getLastMonths({bool onlySelected = true}) =>
      db.getLastMonths(onlySelected);

  Future<String?> getLastMonthDate() => db.getLastMonthDate();
}
