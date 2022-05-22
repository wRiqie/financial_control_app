import 'dart:io';

import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseService {
  Future<Directory> get pathToCopy => getApplicationDocumentsDirectory();

  Future<File?> getDb() async {
    final dbFolder = await getDownloadsDirectory();
    final sourceDb = File('$dbFolder/${Constants.dbName}');

    var permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      permissionStatus = await Permission.storage.request();
      if (permissionStatus.isDenied) {
        print('Permission Denied');
        return null;
      }
    }
    return sourceDb;
  }

  Future<bool> exportDatabase() async {
    final sourceDb = await getDb();
    if (sourceDb != null) {
      final copyTo = await pathToCopy;
      await sourceDb.copy('${copyTo.path}/${Constants.dbName}');
      print('Saved on ${copyTo.path}/${Constants.dbName}');
      return true;
    }
    return false;
  }

  Future<void> importDatabase() async {
    final path = await pathToCopy;
    
  }
}
