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
  // db.allTables contains every table defined in your Drift schema
  for (final table in db.allTables) {
    final tableName = table.actualTableName;
    int count = 0;
    
    if (tableName.startsWith('fts_')) {
      // The _docsize shadow table holds exactly 1 row per indexed document.
      final res = await db.customSelect('SELECT COUNT(*) as c FROM ${tableName}_docsize').getSingle();
      count = res.read<int>('c');
    } else {
      // Standard table check
      final res = await db.customSelect('SELECT COUNT(*) as c FROM $tableName').getSingle();
      count = res.read<int>('c');
    }

    // The assertion! 
    expect(
      count, 
      equals(0), 
      reason: "FAIL: Table '$tableName' is NOT empty! It left behind $count orphaned rows."
    );
  }
}