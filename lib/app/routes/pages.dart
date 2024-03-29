import 'package:financial_control_app/app/modules/add_category/add_category_binding.dart';
import 'package:financial_control_app/app/modules/add_category/add_category_page.dart';
import 'package:financial_control_app/app/modules/travels/add_travel/add_travel_binding.dart';
import 'package:financial_control_app/app/modules/travels/add_travel/add_travel_page.dart';
import 'package:financial_control_app/app/modules/travels/travels_binding.dart';
import 'package:financial_control_app/app/modules/travels/travels_page.dart';

import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_page.dart';
import '../modules/change_balance/change_balace_binding.dart';
import '../modules/change_balance/change_balance_page.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/preferences/preferences_binding.dart';
import '../modules/preferences/preferences_page.dart';
import '../modules/register_bill/register_bill_binding.dart';
import '../modules/register_bill/register_bill_page.dart';
import '../modules/select_categories/select_categories_binding.dart';
import '../modules/select_categories/select_categories_page.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';
import '../modules/statistics/statistics_binding.dart';
import '../modules/statistics/statistics_page.dart';
import 'middlewares/auth_middleware.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.statistics,
        page: () => const StatisticsPage(),
        binding: StatisticsBinding()),
    GetPage(
        name: Routes.registerBill,
        page: () => const RegisterBillPage(),
        binding: RegisterBillBinding()),
    GetPage(
        name: Routes.preferences,
        page: () => const PreferencesPage(),
        binding: PreferencesBinding()),
    GetPage(
        name: Routes.changeBalance,
        page: () => const ChangeBalancePage(),
        binding: ChangeBalanceBinding()),
    GetPage(
        name: Routes.selectCategories,
        page: () => const SelectCategoriesPage(),
        binding: SelectCategoriesBinding()),
    GetPage(
        name: Routes.auth,
        page: () => const AuthPage(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.addCategory,
        page: () => const AddCategoryPage(),
        binding: AddCategoryBinding()),
    GetPage(
        name: Routes.travels,
        page: () => const TravelsPage(),
        binding: TravelsBinding()),
    GetPage(
        name: Routes.addTravel,
        page: () => const AddTravelPage(),
        binding: AddTravelBinding()),
  ];
}
