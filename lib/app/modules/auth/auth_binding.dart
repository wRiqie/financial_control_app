import '../../data/services/local_auth_service.dart';
import 'auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalAuthService>(() => LocalAuthService());
    Get.put<AuthController>(AuthController(Get.find()));
  }
}
