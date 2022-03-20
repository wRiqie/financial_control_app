import 'package:financial_control_app/app/modules/register_bill/register_bill_controller.dart';
import 'package:get/get.dart';

class RegisterBillBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<RegisterBillController>(() => RegisterBillController());
  }
}