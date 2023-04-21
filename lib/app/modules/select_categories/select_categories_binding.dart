import '../../data/provider/database_provider.dart';
import '../../data/repository/category_repository.dart';
import '../../data/services/snackbar_service.dart';
import 'select_categories_controller.dart';
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
