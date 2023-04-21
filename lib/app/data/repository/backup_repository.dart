import '../provider/database_provider.dart';

class BackupRepository {
  final db = DatabaseProvider.db;

  Future<String?> generateBackup()
    => db.generateBackup();

  Future<bool> restoreBackup(String backup)
    => db.restoreBackup(backup);

  Future<void> clearAllTables()
    => db.clearAllTables();
}