import 'package:financial_control_app/app/data/provider/database_provider.dart';

class BackupRepository {
  final db = DatabaseProvider.db;

  Future<String?> generateBackup()
    => db.generateBackup();

  Future<void> restoreBackup(String backup)
    => db.restoreBackup(backup);

  Future<void> clearAllTables()
    => db.clearAllTables();
}