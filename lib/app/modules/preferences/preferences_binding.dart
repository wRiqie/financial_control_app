import 'package:financial_control_app/app/modules/preferences/preferences_controller.dart';
import 'package:get/get.dart';

class PreferencesBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PreferencesController>(() => PreferencesController());
  }
}