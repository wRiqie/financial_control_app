import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/values/constants.dart';
import '../../data/services/theme_service.dart';

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
