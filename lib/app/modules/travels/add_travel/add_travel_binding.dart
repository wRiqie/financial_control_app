import 'package:get/get.dart';

import 'add_travel_controller.dart';

class AddTravelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTravelController>(() => AddTravelController());
  }
}
