import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';

class MonthRepository {
  final _table = DatabaseProvider.monthTable;
  final DatabaseProvider db;

  MonthRepository(this.db);

  Future<int> saveMonth(Month month)
    => db.save(data: month, table: _table);

  Future<Month?> getMonthByDate(String date)
    => db.getMonthByDate(date);

  Future<List<Month>> getLastMonths()
    => db.getLastMonths();
}