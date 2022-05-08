import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:financial_control_app/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryRepository(DatabaseProvider.db));
    Get.put<SplashController>(SplashController(Get.find()));
  }
}
