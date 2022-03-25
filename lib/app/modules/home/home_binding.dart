import 'package:financial_control_app/app/data/services/bill_service.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillService>(() => BillService());
  }
}
