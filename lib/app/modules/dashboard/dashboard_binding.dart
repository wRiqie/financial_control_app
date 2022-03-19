import 'package:financial_control_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
