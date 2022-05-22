import 'package:financial_control_app/app/data/repository/backup_repository.dart';
import 'package:financial_control_app/app/data/services/database_service.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/modules/preferences/preferences_controller.dart';
import 'package:get/get.dart';

class PreferencesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BackupRepository>(() => BackupRepository());
    Get.lazyPut<DatabaseService>(
        () => DatabaseService(backupRepository: Get.find()));
    Get.lazyPut<SnackbarService>(() => SnackbarService());
    Get.lazyPut<PreferencesController>(
        () => PreferencesController(Get.find(), snackService: Get.find()));
  }
}
