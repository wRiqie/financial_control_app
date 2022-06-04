import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';

class MonthRepository {
  final _table = DatabaseProvider.monthTable;
  final DatabaseProvider db;

  MonthRepository(this.db);

  Future<int> saveMonth(Month month)
    => db.save(data: month, table: _table);

  Future<Month?> getMonthByDate(String date, {bool onlySelected = true})
    => db.getMonthByDate(date, onlySelected);

  Future<List<Month>> getLastMonths({bool onlySelected = true})
    => db.getLastMonths(onlySelected);
}