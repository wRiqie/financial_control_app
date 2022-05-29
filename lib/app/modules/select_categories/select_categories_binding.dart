import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/modules/select_categories/select_categories_controller.dart';
import 'package:get/get.dart';

class SelectCategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryRepository>(
        () => CategoryRepository(DatabaseProvider.db));
    Get.lazyPut<SnackbarService>(
        () => SnackbarService());
    Get.lazyPut<SelectCategoriesController>(
        () => SelectCategoriesController(Get.find(), snackService: Get.find()));
  }
}
