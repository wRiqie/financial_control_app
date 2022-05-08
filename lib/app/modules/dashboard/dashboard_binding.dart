import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:financial_control_app/app/modules/statistics/statistics_controller.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());

    Get.lazyPut<CategoryRepository>(
        () => CategoryRepository(DatabaseProvider.db));
    Get.lazyPut<MonthRepository>(() => MonthRepository(DatabaseProvider.db));
    Get.lazyPut<BillRepository>(() => BillRepository(DatabaseProvider.db));
    Get.put<HomeController>(HomeController(Get.find(), Get.find(), Get.find()));

    Get.put<StatisticsController>(StatisticsController());
  }
}
