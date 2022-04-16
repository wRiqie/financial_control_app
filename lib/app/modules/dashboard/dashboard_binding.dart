import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:financial_control_app/app/modules/statistics/statistics_controller.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.put<HomeController>(HomeController(MonthRepository(DatabaseProvider.db),
        BillRepository(DatabaseProvider.db)));
    Get.lazyPut<StatisticsController>(() => StatisticsController(),
        fenix: true);
  }
}
