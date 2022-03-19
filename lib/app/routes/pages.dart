import 'package:financial_control_app/app/modules/dashboard/dashboard_binding.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_page.dart';
import 'package:financial_control_app/app/modules/home/home_binding.dart';
import 'package:financial_control_app/app/modules/home/home_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding()
    ),
  ];
}
