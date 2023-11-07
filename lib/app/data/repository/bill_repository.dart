import '../models/bill_model.dart';
import '../provider/database_provider.dart';

class BillRepository {
  final _table = DatabaseProvider.billTable;
  final DatabaseProvider db;

  BillRepository(this.db);

  Future<int> saveBill(BillModel bill) => db.save(data: bill, table: _table);

  Future<void> saveAllBills(List<BillModel> bills) =>
      db.saveAll(datas: bills, table: _table);

  Future<List<BillModel>> getBillsByDate(String date) =>
      db.getBillsByDate(date);

  Future<List<BillModel>> getBillsByCategoryIdAndDate(
          int categoryId, String date) =>
      db.getBillsByCategoryIdAndDate(categoryId, date);

  Future<int> deleteBillById(String id) => db.deleteBillById(id);

  Future<int> deleteBillsByCategoryIdAndDate(int categoryId, String date) =>
      db.deleteBillsByCategoryIdAndDate(categoryId, date);

  Future<int> deleteBillsByCategoryId(int categoryId) =>
      db.deleteBillsByCategoryId(categoryId);

  Future<void> deleteBillsByIds(List<BillModel> bills) =>
      db.deleteBillsByIds(bills);

  Future<num> getBillsTotalPriceOfMonthCategory(int categoryId, String date) =>
      db.getBillsTotalPriceOfMonthCategory(categoryId, date);
}
