import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/modules/change_balance/change_balance_controller.dart';
import 'package:get/get.dart';

class ChangeBalanceBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ChangeBalanceController>(() => ChangeBalanceController(MonthRepository(DatabaseProvider.db)));
  }
}