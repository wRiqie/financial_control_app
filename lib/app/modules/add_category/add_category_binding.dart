import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:get/get.dart';

import 'add_category_controller.dart';

class AddCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryController>(
        () => AddCategoryController(CategoryRepository(DatabaseProvider.db)));
  }
}
