import 'package:financial_control_app/app/modules/change_balance/change_balace_binding.dart';
import 'package:financial_control_app/app/modules/change_balance/change_balance_page.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_binding.dart';
import 'package:financial_control_app/app/modules/dashboard/dashboard_page.dart';
import 'package:financial_control_app/app/modules/home/home_binding.dart';
import 'package:financial_control_app/app/modules/home/home_page.dart';
import 'package:financial_control_app/app/modules/preferences/preferences_binding.dart';
import 'package:financial_control_app/app/modules/preferences/preferences_page.dart';
import 'package:financial_control_app/app/modules/register_bill/register_bill_binding.dart';
import 'package:financial_control_app/app/modules/register_bill/register_bill_page.dart';
import 'package:financial_control_app/app/modules/select_categories/select_categories_binding.dart';
import 'package:financial_control_app/app/modules/select_categories/select_categories_page.dart';
import 'package:financial_control_app/app/modules/splash/splash_binding.dart';
import 'package:financial_control_app/app/modules/splash/splash_page.dart';
import 'package:financial_control_app/app/modules/statistics/statistics_binding.dart';
import 'package:financial_control_app/app/modules/statistics/statistics_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding()
    ),
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
    GetPage(
      name: Routes.statistics,
      page: () => const StatisticsPage(),
      binding: StatisticsBinding()
    ),
    GetPage(
      name: Routes.registerBill,
      page: () => const RegisterBillPage(),
      binding: RegisterBillBinding()
    ),
    GetPage(
      name: Routes.preferences,
      page: () => const PreferencesPage(),
      binding: PreferencesBinding()
    ),
    GetPage(
      name: Routes.changeBalance,
      page: () => const ChangeBalancePage(),
      binding: ChangeBalanceBinding()
    ),
    GetPage(
      name: Routes.selectCategories,
      page: () => const SelectCategoriesPage(),
      binding: SelectCategoriesBinding()
    ),
  ];
}
