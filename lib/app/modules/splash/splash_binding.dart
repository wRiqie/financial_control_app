import '../../data/provider/database_provider.dart';
import '../../data/repository/category_repository.dart';
import 'splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryRepository(DatabaseProvider.db));
    Get.put<SplashController>(SplashController(Get.find()));
  }
}
