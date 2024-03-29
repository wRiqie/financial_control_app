import 'dart:io';

import '../../core/values/constants.dart';
import '../repository/backup_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseService {
  final BackupRepository backupRepository;

  DatabaseService({required this.backupRepository});

  Directory get directory =>
      Directory('/storage/emulated/0/.${Constants.dbBackupFolder}');

  Future<bool> checkPermissions() async {
    var permissionStorageStatus = await Permission.storage.status;
    if (permissionStorageStatus.isDenied) {
      permissionStorageStatus = await Permission.storage.request();
      if (permissionStorageStatus.isDenied) {
        return false;
      }
    }
    var permissionManageStatus = await Permission.manageExternalStorage.status;
    if (permissionManageStatus.isDenied) {
      permissionManageStatus = await Permission.manageExternalStorage.request();
      if (permissionManageStatus.isDenied) {
        return false;
      }
    }
    return true;
  }

  Future<bool> exportDatabase() async {
    if (!(await checkPermissions())) {
      return false;
    }
    final dbBackup = await backupRepository.generateBackup();
    if (dbBackup != null) {
      if (!(await directory.exists())) {
        await directory.create();
      }
      final file = File('${directory.path}/.${Constants.dbName}');
      await file.writeAsString(dbBackup);
    }
    return true;
  }

  Future<bool> importDatabase() async {
    if (!(await checkPermissions())) {
      return false;
    }
    try {
      final file = File('${directory.path}/.${Constants.dbName}');
      final fileStr = await file.readAsString();
      await backupRepository.clearAllTables();
      final restored =
          await backupRepository.restoreBackup(fileStr);

      return restored;
    } catch (e) {
      return false;
    }
  }
}
