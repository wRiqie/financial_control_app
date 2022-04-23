import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';

class CategoryRepository {
  final _table = DatabaseProvider.categoryTable; 
  final DatabaseProvider db;

  CategoryRepository(this.db);

  Future<void> saveCategories(List<Category> categories)
    => db.saveAll(datas: categories, table: _table);

  Future<List<Category>> getAllCategories() 
    => db.getAllCategories();

  Future<List<Category>> getSelectedCategories()
    => db.getSelectedCategories();
}
