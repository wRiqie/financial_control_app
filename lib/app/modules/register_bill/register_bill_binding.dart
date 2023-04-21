import '../../data/provider/database_provider.dart';
import '../../data/repository/bill_repository.dart';
import '../../data/repository/category_month_repository.dart';
import '../../data/repository/month_repository.dart';
import '../../data/services/snackbar_service.dart';
import 'register_bill_controller.dart';
import 'package:get/get.dart';

class RegisterBillBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillRepository>(() => BillRepository(DatabaseProvider.db));
    Get.lazyPut<MonthRepository>(() => MonthRepository(DatabaseProvider.db));
    Get.lazyPut<CategoryMonthRepository>(() => CategoryMonthRepository(DatabaseProvider.db));
    Get.lazyPut<SnackbarService>(() => SnackbarService());

    Get.lazyPut<RegisterBillController>(
      () => RegisterBillController(
        Get.find(),
        Get.find(),
        snackService: Get.find(),
      ),
    );
  }
}
