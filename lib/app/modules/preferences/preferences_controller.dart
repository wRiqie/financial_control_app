import '../../core/values/constants.dart';
import '../../data/models/month.dart';
import '../../data/services/database_service.dart';
import '../../data/services/local_auth_service.dart';
import '../../data/services/snackbar_service.dart';
import '../../data/services/theme_service.dart';
import '../../global/widgets/confirm_dialog.dart';
import '../../routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreferencesController extends GetxController {
  final DatabaseService backupDbService;
  final SnackbarService snackService;
  final LocalAuthService localAuthService;
  final box = GetStorage(Constants.storageName);
  final args = Get.arguments;
  bool copyBills = false;
  bool biometryEnabled = false;
  Month? month;

  PreferencesController(this.backupDbService,
      {required this.snackService, required this.localAuthService});

  void toggleCopyBills(bool? value) async {
    copyBills = value ?? true;
    await box.write(Constants.copyBills, copyBills);
    update();
  }

  void changeBalance() {
    Get.toNamed(Routes.changeBalance, arguments: {'month': month});
  }

  void chooseCategories() {
    Get.toNamed(Routes.selectCategories);
  }

  void toggleTheme(bool value) {
    appTheme.changeTheme();
    Future.delayed(const Duration(milliseconds: 100)).then(
      (value) => update(),
    );
  }

  void toggleBiometry(bool? value) async {
    final isCompatible =
        await localAuthService.checkDeviceCompatility(localAuthService.auth);
    if (isCompatible) {
      biometryEnabled = value ?? false;
      await box.write(Constants.biometryEnabled, biometryEnabled);
      update();
    } else {
      Get.dialog(
        ConfirmDialog(
          body:
              'biometryError'.tr,
          icon: Icon(
            Icons.fingerprint,
            color: Get.theme.colorScheme.primary,
          ),
          isInfoDialog: true,
        ),
      );
    }
  }

  void exportDb() async {
    final exported = await backupDbService.exportDatabase();
    if (!exported) {
      snackService.showSnackbar(
        title: 'Erro',
        subtitle: 'Não foi possível exportar os dados',
        backgroundColor: Get.theme.colorScheme.error,
      );
      return;
    }
    snackService.showSnackbar(
      title: 'success'.tr,
      subtitle: 'successfullySaved'.tr,
    );
  }

  void importDb() async {
    final imported = await backupDbService.importDatabase();
    if (!imported) {
      snackService.showSnackbar(
        title: 'Erro',
        subtitle: 'Não foi possível importar os dados',
        backgroundColor: Get.theme.colorScheme.error,
      );
      return;
    }
    Get.offAllNamed(Routes.dashboard);
    snackService.showSnackbar(
      title: 'success'.tr,
      subtitle: 'successfullySaved'.tr,
    );
  }

  @override
  void onInit() {
    super.onInit();
    toggleCopyBills(box.read(Constants.copyBills));
    toggleBiometry(box.read(Constants.biometryEnabled));
    month = args['month'];
  }
}
