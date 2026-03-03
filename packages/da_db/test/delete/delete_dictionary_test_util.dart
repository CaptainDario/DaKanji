import 'package:da_db/data/dictionary_types.dart';
import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/unified_staging_parser.dart';
import 'package:test/test.dart';



/// Imports a dictionary from a zip path
Future<void> importDictionary(DaDb db, String zipPath, DictionaryTypes t) async {

  final stream = await parseDaDbDataSource(
    dataSourcePath: zipPath,
    db: db,
    isDefaultDictionary: false,
  );
  await for (final message in stream) {
    print("  -> $message");
  }
}

/// Executes the deletion stream and prints progress
Future<void> runDeletion(DaDb db, int indexId) async {
  final stream = db.deletionDao.deleteDictionary(indexId);
  await for (final message in stream) {
    print("  -> $message");
  }
}

/// A highly strict, dynamic assertion that ensures EVERY defined table in the DB is empty.
Future<void> assertAbsoluteDatabaseEmptiness(DaDb db) async {
  // db.allTables contains every table defined in your Drift schema!
  for (final table in db.allTables) {
    print(table.actualTableName);
    final tableName = table.actualTableName;
    
    int count = 0;
    
    try {
      // First try standard COUNT(*) which works for 99% of tables
      final result = await db.customSelect('SELECT COUNT(*) as c FROM $tableName').getSingle();
      count = result.read<int>('c');
    }
    catch (e) {
      // Fallback for strict contentless FTS5 tables which sometimes require explicit rowid counting
      final result = await db.customSelect('SELECT COUNT(rowid) as c FROM $tableName').getSingle();
      count = result.read<int>('c');
    }

    // The assertion! If any table fails, the reason will tell you EXACTLY which one it was.
    expect(
      count, 
      equals(0), 
      reason: "FAIL: Table '$tableName' is NOT empty! It left behind $count orphaned rows."
    );
  }
}