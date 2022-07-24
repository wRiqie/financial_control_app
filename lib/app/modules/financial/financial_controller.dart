import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/data/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FinancialController extends GetxController {
  final box = GetStorage(Constants.storageName);

  @override
  void onInit() {
    super.onInit();
    appTheme.isDark = box.read(Constants.darkTheme) ?? true;
    appTheme.addListener(() {
      box.write(Constants.darkTheme, appTheme.isDark);
      update();
    });
  }
}
