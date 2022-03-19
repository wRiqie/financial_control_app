import 'package:financial_control_app/app/modules/home/home_page.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final index = 0.obs;
  final pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  changePage(int i) {
    index.value = i;
  }
}