import 'package:dakanji_db_core/database/dakanji_db.dart';



Future optimizeDbAfterImport(DaKanjiDB db) async {

  // Optimize db
  await db.customStatement('VACUUM;');
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

}