import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/staging_db.dart';
import 'package:drift/drift.dart';



Future optimizeDbAfterImport(GeneratedDatabase db) async {
  
  // optimize fts tables (trigram)
  await db.customStatement("INSERT INTO fts_terms(fts_terms) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_readings(fts_readings) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_definitions(fts_definitions) VALUES('optimize');");  
  await db.customStatement("INSERT INTO fts_example_sentence(fts_example_sentence) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_example_sentence_tokenized(fts_example_sentence_tokenized) VALUES('optimize');");

  // optimize fts tables (unicode)
  await db.customStatement("INSERT INTO fts_terms_unicode(fts_terms_unicode) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_readings_unicode(fts_readings_unicode) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_definitions_unicode(fts_definitions_unicode) VALUES('optimize');");  
  await db.customStatement("INSERT INTO fts_example_sentence_unicode(fts_example_sentence_unicode) VALUES('optimize');");

  //  optimize statistics for query planner
  await db.customStatement('ANALYZE;');

  // commit all changes to DB
  await db.customStatement("PRAGMA wal_checkpoint(TRUNCATE);");

}

Future optimizeTargetDbForMerge(DaDb db) async {
  
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

Future<void> restoreTargetDbAfterMerge(DaDb db) async {
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

}

Future optimizeDbAfterDelete(DaDb db) async {

  // 1. Optimize FTS5 Tables (trigram)
  await db.customStatement("INSERT INTO fts_terms(fts_terms) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_readings(fts_readings) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_definitions(fts_definitions) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_example_sentence(fts_example_sentence) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_example_sentence_tokenized(fts_example_sentence_tokenized) VALUES('optimize');");

  // Optimize FTS5 Tables (unicode)
  await db.customStatement("INSERT INTO fts_terms_unicode(fts_terms_unicode) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_readings_unicode(fts_readings_unicode) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_definitions_unicode(fts_definitions_unicode) VALUES('optimize');");
  await db.customStatement("INSERT INTO fts_example_sentence_unicode(fts_example_sentence_unicode) VALUES('optimize');");

  // 2. Reclaim Space
  await db.customStatement("VACUUM;");

  // 3. Update Query Planner Statistics
  await db.customStatement("ANALYZE;");
}