import '../../data/provider/database_provider.dart';
import '../../data/repository/month_repository.dart';
import 'change_balance_controller.dart';
import 'package:get/get.dart';

class ChangeBalanceBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ChangeBalanceController>(() => ChangeBalanceController(MonthRepository(DatabaseProvider.db)));
  }
}