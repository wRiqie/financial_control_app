import '../models/category_model.dart';
import '../provider/database_provider.dart';

class CategoryRepository {
  final _table = DatabaseProvider.categoryTable;
  final DatabaseProvider db;

  CategoryRepository(this.db);

  Future<int> saveCategory(CategoryModel category) =>
      db.save(data: category, table: _table);

  Future<void> saveCategories(List<CategoryModel> categories) =>
      db.saveAll(datas: categories, table: _table);

  Future<int> deleteCategory(int id) => db.deleteCategoryById(id);

  Future<List<CategoryModel>> getAllCategories() => db.getAllCategories();

  Future<List<CategoryModel>> getSelectedCategories() =>
      db.getSelectedCategories();
}
