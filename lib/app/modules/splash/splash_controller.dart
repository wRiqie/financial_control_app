import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/data/enums/category_enum.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:financial_control_app/app/routes/pages.dart';
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
      final categories =
          ECategory.values.map((e) => Category(id: e.id)).toList();
      await categoryRepository.saveCategories(categories);
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
