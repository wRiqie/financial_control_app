import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/modules/register_bill/register_bill_controller.dart';
import 'package:get/get.dart';

class RegisterBillBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillRepository>(() => BillRepository(DatabaseProvider.db));
    Get.lazyPut<MonthRepository>(() => MonthRepository(DatabaseProvider.db));
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
