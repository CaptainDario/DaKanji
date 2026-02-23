import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';



Future optimizeDbAfterImport(GeneratedDatabase db) async {
  
  // update fts indexes
  await db.customStatement("INSERT INTO fts_terms(fts_terms) VALUES('rebuild')");
  await db.customStatement("INSERT INTO fts_readings(fts_readings) VALUES('rebuild')");
  await db.customStatement("INSERT INTO fts_definitions(fts_definitions) VALUES('rebuild')");

  // optimize fts tables
  await db.customStatement("INSERT INTO fts_tokens(fts_tokens) VALUES('optimize');");

  //  optimize statistics for query planner
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

}

Future optimizeTargetDbForMerge(DaKanjiDB db) async {
  
  // Disable synchronous mode for faster inserts
  await db.customStatement('PRAGMA synchronous = OFF;');
  // 256MB Cache
  await db.customStatement('PRAGMA cache_size = -256000;');  
  // RAM for temp tables/sorts
  await db.customStatement('PRAGMA temp_store = MEMORY;');
  // Disable Foreign Keys (Speed - Trusts worker data structure)
  await db.customStatement('PRAGMA foreign_keys = OFF;');
  // Memory map the file (Safe for 64-bit systems)
  await db.customStatement('PRAGMA mmap_size = 30000000000;');
}

Future<void> restoreTargetDbAfterMerge(DaKanjiDB db) async {
  // Re-enable safety: Ensure data is actually flushed to disk
  await db.customStatement('PRAGMA synchronous = NORMAL;');
  
  // Re-enable Foreign Keys
  await db.customStatement('PRAGMA foreign_keys = ON;');

  // Shrink the cache back to a sane default (e.g., 20MB)
  // This frees up system RAM for the rest of the app
  await db.customStatement('PRAGMA cache_size = -20000;');

  // Let temp tables go back to disk if needed
  await db.customStatement('PRAGMA temp_store = DEFAULT;');
  
  // Reset mmap if
  await db.customStatement('PRAGMA mmap_size = 0;');
}

Future optimizeStagingDbForRawInsert(StagingDatabase db) async {
  // 1. Memory-Only Journaling
  // Since this is a temporary file, if it crashes, you'll just delete it.
  // This is significantly faster than the default WAL or Delete modes.
  await db.customStatement('PRAGMA journal_mode = MEMORY;');

  // 2. Turn off Disk Sync
  // Tells SQLite not to wait for the disk to confirm writes.
  await db.customStatement('PRAGMA synchronous = OFF;');

  // 3. Huge Cache
  // This keeps the B-Tree index pages for the staging table in RAM.
  await db.customStatement('PRAGMA cache_size = -256000;');

  // 4. Memory Storage for Temp tables
  await db.customStatement('PRAGMA temp_store = MEMORY;');
  
  // 5. Locking Mode
  // If this is a dedicated worker process, EXCLUSIVE prevents 
  // SQLite from constantly checking for other file locks.
  await db.customStatement('PRAGMA locking_mode = EXCLUSIVE;');
}

Future optimizeDbAfterDelete(DaKanjiDB db) async {
  // 1. Optimize FTS5 Tables
  await db.customStatement("INSERT INTO fts_terms(fts_terms) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_readings(fts_readings) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_definitions(fts_definitions) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_tokens(fts_tokens) VALUES('optimize');");

  // 2. Update Query Planner Statistics
  await db.customStatement("ANALYZE;");

  // 3. Reclaim Space
  await db.customStatement("VACUUM;");
}