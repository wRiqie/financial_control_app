import 'package:get/get.dart';

import 'travels_controller.dart';

class TravelsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelsController>(() => TravelsController());
  }
}
