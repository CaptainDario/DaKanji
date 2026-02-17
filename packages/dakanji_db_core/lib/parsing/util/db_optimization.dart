import 'package:dakanji_db_core/database/dakanji_db.dart';



Future optimizeDbAfterImport(DaKanjiDB db) async {
  
  // update fts indexes
  await db.customStatement("INSERT INTO fts_terms(fts_terms) VALUES('rebuild')");
  await db.customStatement("INSERT INTO fts_readings(fts_readings) VALUES('rebuild')");
  await db.customStatement("INSERT INTO fts_definitions(fts_definitions) VALUES('rebuild')");

  // optimize fts tables
  await db.customStatement("INSERT INTO fts_terms(fts_terms) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_readings(fts_readings) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_definitions(fts_definitions) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_tokens(fts_tokens) VALUES('optimize');");

  // Optimize db size
  //await db.customStatement('VACUUM;');

  //  optimize statistics for query planner
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

}