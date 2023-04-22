import '../../core/values/constants.dart';
import '../../data/repository/category_repository.dart';
import '../../routes/pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final CategoryRepository categoryRepository;
  final box = GetStorage(Constants.storageName);

  SplashController(this.categoryRepository);

  handleWait() {
    Future.delayed(const Duration(seconds: 3)).then((value) => handleDone());
  }

  handleDone() async {
    bool? copyBills = box.read(Constants.copyBills);
    if (copyBills == null) {
      await box.write(Constants.copyBills, true);
    }

    bool? firstTimeOpen = box.read(Constants.firstTimeOpen);

    if (firstTimeOpen != null && firstTimeOpen == false) {
      Get.offAndToNamed(Routes.dashboard);
      return;
    } else {
      box.write(Constants.firstTimeOpen, true);
      Get.offAndToNamed(
        Routes.changeBalance,
        arguments: {'firstTime': true},
      );
      return;
    }
  }

  @override
  void onInit() {
    super.onInit();
    handleWait();
  }
}
