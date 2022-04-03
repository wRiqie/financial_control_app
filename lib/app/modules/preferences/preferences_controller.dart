import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreferencesController extends GetxController {
  final box = GetStorage(Constants.storageName);
  final args = Get.arguments;
  bool copyBills = false;
  Month? month;

  toogleCopyBills(bool value) {
    copyBills = value;
    update();
  }

  void changeBalance() {
    Get.toNamed(Routes.changeBalance, arguments: {'month': month});
  }

  @override
  void onInit() {
    super.onInit();
    toogleCopyBills(box.read(Constants.copyBills));
    month = args['month'];
  }
}
