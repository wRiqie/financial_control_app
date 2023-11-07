import '../../data/repository/backup_repository.dart';
import '../../data/services/database_service.dart';
import '../../data/services/local_auth_service.dart';
import 'preferences_controller.dart';
import 'package:get/get.dart';

class PreferencesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BackupRepository>(() => BackupRepository());
    Get.lazyPut<DatabaseService>(
        () => DatabaseService(backupRepository: Get.find()));
    Get.lazyPut<LocalAuthService>(() => LocalAuthService());
    Get.lazyPut<PreferencesController>(
        () => PreferencesController(Get.find(), localAuthService: Get.find()));
  }
}
