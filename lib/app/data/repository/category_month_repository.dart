import '../models/category_month_model.dart';
import '../provider/database_provider.dart';

class CategoryMonthRepository {
  final _table = DatabaseProvider.categoryMonthTable;
  final DatabaseProvider db;

  CategoryMonthRepository(this.db);

  Future<int> saveCategoryMonth(CategoryMonthModel categoryMonth) =>
      db.save(data: categoryMonth, table: _table);

  // Future<int> deleteCategoryMonth(String id)
  //   => db.

  Future<List<CategoryMonthModel>> getCategoryMonthsByCategoryIdAndMonth(
          int categoryId, String month) =>
      db.getCategoryMonthsByCategoryIdAndMonth(categoryId, month);
}
