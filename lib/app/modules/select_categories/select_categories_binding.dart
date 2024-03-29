import 'package:financial_control_app/app/data/repository/bill_repository.dart';

import '../../data/provider/database_provider.dart';
import '../../data/repository/category_repository.dart';
import 'select_categories_controller.dart';
import 'package:get/get.dart';

class SelectCategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryRepository>(
        () => CategoryRepository(DatabaseProvider.db));
    Get.lazyPut<BillRepository>(() => BillRepository(DatabaseProvider.db));
    Get.lazyPut<SelectCategoriesController>(
        () => SelectCategoriesController(Get.find(), Get.find()));
  }
}
