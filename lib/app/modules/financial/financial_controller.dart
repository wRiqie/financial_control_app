import 'package:financial_control_app/app/data/services/theme_service.dart';
import 'package:get/get.dart';

class FinancialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    appTheme.addListener(() {
      update();
    });
  }
}
