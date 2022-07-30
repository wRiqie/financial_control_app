import 'package:financial_control_app/app/data/services/local_auth_service.dart';
import 'package:financial_control_app/app/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalAuthService>(() => LocalAuthService());
    Get.put<AuthController>(AuthController(Get.find()));
  }
}
