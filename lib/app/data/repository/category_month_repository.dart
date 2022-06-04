import 'package:financial_control_app/app/data/models/category_month.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';

class CategoryMonthRepository {
  final _table = DatabaseProvider.categoryMonthTable;
  final DatabaseProvider db;

  CategoryMonthRepository(this.db);

  Future<int> saveCategoryMonth(CategoryMonth categoryMonth)
    => db.save(data: categoryMonth, table: _table);

  // Future<int> deleteCategoryMonth(String id)
  //   => db.

  Future<List<CategoryMonth>> getCategoryMonthsByCategoryIdAndMonth(int categoryId, String month)
    => db.getCategoryMonthsByCategoryIdAndMonth(categoryId, month);
}