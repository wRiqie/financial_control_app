import '../../data/services/local_auth_service.dart';
import '../../routes/middlewares/auth_middleware.dart';
import '../../routes/pages.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxnBool result = RxnBool();
  final LocalAuthService service;

  AuthController(this.service);

  void authenticate() {
    if (result.value == true) {
      return;
    }
    service.authenticate().then((value) {
      if (value) {
        result.value = true;
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          authenticated = true;
          Get.offAndToNamed(Routes.dashboard);
        });
      } else {
        result.value = false;
        Future.delayed(const Duration(milliseconds: 600)).then(
          (value) => result.value = null,
        );
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    authenticate();
  }
}
