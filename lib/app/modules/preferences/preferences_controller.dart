import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/services/database_service.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreferencesController extends GetxController {
  final DatabaseService backupDbService;
  final SnackbarService snackService;
  final box = GetStorage(Constants.storageName);
  final args = Get.arguments;
  bool copyBills = false;
  Month? month;

  PreferencesController(this.backupDbService, {required this.snackService});

  toogleCopyBills(bool value) {
    copyBills = value;
    update();
  }

  void changeBalance() {
    Get.toNamed(Routes.changeBalance, arguments: {'month': month});
  }

  void exportDb() async {
    final exported = await backupDbService.exportDatabase();
    Get.back();
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
    toogleCopyBills(box.read(Constants.copyBills));
    month = args['month'];
  }
}
