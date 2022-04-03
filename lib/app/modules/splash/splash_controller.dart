import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage(Constants.storageName);

  handleWait(){
    Future.delayed(const Duration(seconds: 3)).then((value) => handleDone());
  }

  handleDone() async {
    bool? copyBills = box.read(Constants.copyBills);
    if(copyBills == null){
      await box.write(Constants.copyBills, true);
    }
    Get.offAndToNamed(Routes.dashboard);
  }

  @override
  void onInit() {
    super.onInit();
    handleWait();
  }
}