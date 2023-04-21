import '../models/bill.dart';
import '../provider/database_provider.dart';

class BillRepository {
  final _table = DatabaseProvider.billTable;
  final DatabaseProvider db;

  BillRepository(this.db);

  Future<int> saveBill(Bill bill)
    => db.save(data: bill, table: _table);

  Future<void> saveAllBills(List<Bill> bills)
    => db.saveAll(datas: bills, table: _table);

  Future<List<Bill>> getBillsByDate(String date)
    => db.getBillsByDate(date);

  Future<List<Bill>> getBillsByCategoryIdAndDate(int categoryId, String date)
    => db.getBillsByCategoryIdAndDate(categoryId, date);

  Future<int> deleteBillById(String id)
    => db.deleteBillById(id);

  Future<int> deleteBillsByCategoryIdAndDate(int categoryId, String date)
    => db.deleteBillsByCategoryIdAndDate(categoryId, date);

  Future<void> deleteBillsByIds(List<Bill> bills)
    => db.deleteBillsByIds(bills);
  
  Future<num> getBillsTotalPriceOfMonthCategory(int categoryId, String date)
    => db.getBillsTotalPriceOfMonthCategory(categoryId, date);
}
