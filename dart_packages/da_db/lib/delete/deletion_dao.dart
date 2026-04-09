import 'dart:async';

import "package:da_db/database/da_db.dart";
import 'package:da_db/parsing/util/db_optimization.dart';
import "package:drift/drift.dart";

part 'deletion_dao.g.dart';

@DriftAccessor()
class DeletionDao extends DatabaseAccessor<DaDb> with _$DeletionDaoMixin {
  
  DeletionDao(super.db);

  Future deleteIndex(int indexId) async {
    // Start a transaction to ensure all deletions are atomic
    await db.transaction(() async {
      // Delete a Dictionary (Index)
      await (db.delete(db.indexTable)
        ..where((tbl) => tbl.id.equals(indexId)))
        .go();
    });
  }

  Stream<String> deleteDictionary(int indexId) {
    final StreamController<String> progress = StreamController<String>();

    Future(() async {
      try {
        progress.add("Starting deletion");

        await db.transaction(() async {
          progress.add("Removing dictionary...");
          await deleteIndex(indexId);

          progress.add("Cleaning up leftover data...");
          await garbageCollectSharedTables(db);
        });

        progress.add("Optimizing database...");
        await optimizeDbAfterDelete(db);

        progress.add("Dictionary deletion complete.");
      }
      catch (e, stackTrace) {
        progress.addError(e, stackTrace);
      }
      finally {
        await progress.close();
      }
    });

    return progress.stream;
  }

  /// Utility function to perform garbage collection on shared tables.
  /// Uses a TEMP table to reliably bulk-sync FTS External Content tables.
  /// Automatically cleans up both trigram and unicode FTS indexes.
  Future<void> garbageCollectSharedTables(DaDb db) async {
    // 0. Setup temp table to store the text columns to feed directly back to FTS.
    await db.customStatement('CREATE TEMP TABLE IF NOT EXISTS fts_garbage (id INTEGER PRIMARY KEY, t1 TEXT, t2 TEXT);');

    // --- 1. TERMS & FTS TABLES ---
    await db.customStatement('DELETE FROM fts_garbage;');
    await db.customStatement('''
      INSERT INTO fts_garbage (id, t1, t2)
      SELECT id, term, term_normalized FROM ${db.termTable.actualTableName} 
      WHERE NOT EXISTS (SELECT 1 FROM ${db.termBankV3Table.actualTableName} WHERE term_id = ${db.termTable.actualTableName}.id) 
      AND NOT EXISTS (SELECT 1 FROM ${db.termMetaBankV3Table.actualTableName} WHERE term_id = ${db.termTable.actualTableName}.id)
      AND NOT EXISTS (SELECT 1 FROM ${db.audioTableXTermTable.actualTableName} WHERE term_id = ${db.termTable.actualTableName}.id);
    ''');

    await db.customStatement('''
      INSERT INTO fts_terms(fts_terms, rowid, term, term_normalized)
      SELECT 'delete', id, t1, t2 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_terms_docsize);
    ''');
    
    await db.customStatement('''
      INSERT INTO fts_terms_unicode(fts_terms_unicode, rowid, term, term_normalized)
      SELECT 'delete', id, t1, t2 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_terms_unicode_docsize);
    ''');
    
    // Cleanup actual term rows
    await db.customStatement('DELETE FROM ${db.termTable.actualTableName} WHERE id IN (SELECT id FROM fts_garbage);');

    // --- 2. READINGS & FTS TABLES ---
    await db.customStatement('DELETE FROM fts_garbage;');
    await db.customStatement('''
      INSERT INTO fts_garbage (id, t1, t2)
      SELECT id, reading, reading_normalized FROM ${db.readingTable.actualTableName} 
      WHERE NOT EXISTS (SELECT 1 FROM ${db.termBankV3Table.actualTableName} WHERE reading_id = ${db.readingTable.actualTableName}.id) 
      AND NOT EXISTS (SELECT 1 FROM ${db.termMetaBankV3Table.actualTableName} WHERE reading_id = ${db.readingTable.actualTableName}.id) 
      AND NOT EXISTS (SELECT 1 FROM ${db.audioTable.actualTableName} WHERE reading_id = ${db.readingTable.actualTableName}.id) 
      AND NOT EXISTS (SELECT 1 FROM ${db.kanjiBankV3XOnyomiReadingTable.actualTableName} WHERE onyomi_reading_id = ${db.readingTable.actualTableName}.id) 
      AND NOT EXISTS (SELECT 1 FROM ${db.kanjiBankV3XKunyomiReadingTable.actualTableName} WHERE kunyomi_reading_id = ${db.readingTable.actualTableName}.id);
    ''');

    await db.customStatement('''
      INSERT INTO fts_readings(fts_readings, rowid, reading, reading_normalized)
      SELECT 'delete', id, t1, t2 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_readings_docsize);
    ''');
    
    await db.customStatement('''
      INSERT INTO fts_readings_unicode(fts_readings_unicode, rowid, reading, reading_normalized)
      SELECT 'delete', id, t1, t2 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_readings_unicode_docsize);
    ''');

    await db.customStatement('DELETE FROM ${db.readingTable.actualTableName} WHERE id IN (SELECT id FROM fts_garbage);');

    // --- 3. DEFINITIONS & FTS TABLES ---
    await db.customStatement('DELETE FROM fts_garbage;');
    await db.customStatement('''
      INSERT INTO fts_garbage (id, t1)
      SELECT id, definition FROM ${db.definitionTable.actualTableName} 
      WHERE NOT EXISTS (SELECT 1 FROM ${db.kanjiBankV3XDefinitionTable.actualTableName} WHERE definition_id = ${db.definitionTable.actualTableName}.id) 
      AND NOT EXISTS (SELECT 1 FROM ${db.termBankV3XDefinitionTable.actualTableName} WHERE definition_id = ${db.definitionTable.actualTableName}.id);
    ''');

    await db.customStatement('''
      INSERT INTO fts_definitions(fts_definitions, rowid, definition)
      SELECT 'delete', id, t1 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_definitions_docsize);
    ''');
    
    await db.customStatement('''
      INSERT INTO fts_definitions_unicode(fts_definitions_unicode, rowid, definition)
      SELECT 'delete', id, t1 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_definitions_unicode_docsize);
    ''');

    await db.customStatement('DELETE FROM ${db.definitionTable.actualTableName} WHERE id IN (SELECT id FROM fts_garbage);');

    // --- 4. EXAMPLES & FTS TABLES ---
    await db.customStatement('DELETE FROM fts_garbage;');
    
    // Find orphaned example sentences and store their exact text
    await db.customStatement('''
      INSERT INTO fts_garbage (id, t1, t2)
      SELECT id, example_sentence, example_sentence_tokenized 
      FROM ${db.exampleSentenceTable.actualTableName} 
      WHERE NOT EXISTS (SELECT 1 FROM ${db.exampleTable.actualTableName} WHERE example_sentence_id = ${db.exampleSentenceTable.actualTableName}.id);
    ''');

    // 1. Standard FTS Table
    await db.customStatement('''
      INSERT INTO fts_example_sentence(fts_example_sentence, rowid, example_sentence)
      SELECT 'delete', id, t1 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_example_sentence_docsize);
    ''');
    
    // 2. Tokenized FTS Table (MUST check for NULLs)
    await db.customStatement('''
      INSERT INTO fts_example_sentence_tokenized(fts_example_sentence_tokenized, rowid, example_sentence_tokenized)
      SELECT 'delete', id, t2 FROM fts_garbage 
      WHERE t2 IS NOT NULL 
      AND id IN (SELECT rowid FROM fts_example_sentence_tokenized_docsize);
    ''');
    
    // 3. Unicode FTS Table
    await db.customStatement('''
      INSERT INTO fts_example_sentence_unicode(fts_example_sentence_unicode, rowid, example_sentence)
      SELECT 'delete', id, t1 FROM fts_garbage 
      WHERE id IN (SELECT rowid FROM fts_example_sentence_unicode_docsize);
    ''');

    // Finally, delete the base rows
    await db.customStatement('DELETE FROM ${db.exampleSentenceTable.actualTableName} WHERE id IN (SELECT id FROM fts_garbage);');

    // Drop temp table
    await db.customStatement('DROP TABLE fts_garbage;');

    // --- 4. REMAINING ORPHAN LOGIC ---
    final remainingQueries = [
      // 4. Delete unreferenced Kanjis
      '''DELETE FROM ${db.kanjiTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.kanjiBankV3Table.actualTableName} WHERE kanji_id = ${db.kanjiTable.actualTableName}.id) 
        AND NOT EXISTS (SELECT 1 FROM ${db.kanjiMetaBankV3Table.actualTableName} WHERE kanji_id = ${db.kanjiTable.actualTableName}.id) 
        AND NOT EXISTS (SELECT 1 FROM ${db.kanjiVGTable.actualTableName} WHERE kanji_id = ${db.kanjiTable.actualTableName}.id) 
        AND NOT EXISTS (SELECT 1 FROM ${db.radicalXKanjiRelationsTable.actualTableName} WHERE kanji_id = ${db.kanjiTable.actualTableName}.id);''',
      
      // 5. Delete unreferenced Structured Content JSON
      '''DELETE FROM ${db.termBankV3DefinitionJsonTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.termBankV3Table.actualTableName} WHERE definition_json_id = ${db.termBankV3DefinitionJsonTable.actualTableName}.id);''',
      
      // 6. Delete unreferenced Rule Identifiers
      '''DELETE FROM ${db.termBankV3RuleIdentifierTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.termBankV3XRuleIdentifierTable.actualTableName} WHERE rule_identifier_id = ${db.termBankV3RuleIdentifierTable.actualTableName}.id);''',
      
      // 7. Delete unreferenced Term Meta Type metadata
      '''DELETE FROM ${db.termMetaBankV3TypeTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.termMetaBankV3Table.actualTableName} WHERE type_id = ${db.termMetaBankV3TypeTable.actualTableName}.id);''',
      
      // 8. Delete unreferenced Kanji Meta Type metadata
      '''DELETE FROM ${db.kanjiMetaBankV3TypeTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.kanjiMetaBankV3Table.actualTableName} WHERE type_id = ${db.kanjiMetaBankV3TypeTable.actualTableName}.id);''',
      
      // 9. Delete unreferenced Pitch entries
      '''DELETE FROM ${db.termMetaBankV3PitchTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.termMetaBankV3XPitchTable.actualTableName} WHERE pitch_id = ${db.termMetaBankV3PitchTable.actualTableName}.id);''',
      
      // 10. Delete unreferenced IPA entries
      '''DELETE FROM ${db.termMetaBankV3IpaTable.actualTableName} 
        WHERE NOT EXISTS (SELECT 1 FROM ${db.termMetaBankV3XIpaTable.actualTableName} WHERE ipa_id = ${db.termMetaBankV3IpaTable.actualTableName}.id);''',

      // 11. Delete unreferenced Audios (Media)
      '''DELETE FROM ${db.mediaTable.actualTableName} 
         WHERE NOT EXISTS (SELECT 1 FROM ${db.audioTable.actualTableName} WHERE media_id = ${db.mediaTable.actualTableName}.id);''',

      // 12. Delete unreferenced Example Audios
      '''DELETE FROM ${db.exampleAudioTable.actualTableName} 
         WHERE NOT EXISTS (SELECT 1 FROM ${db.exampleTableXExampleAudioTable.actualTableName} WHERE audio_id = ${db.exampleAudioTable.actualTableName}.id);''',

      // 13. Delete unreferenced Stat Combinations
      '''DELETE FROM ${db.statTable.actualTableName} 
         WHERE NOT EXISTS (SELECT 1 FROM ${db.exampleTableXStatTable.actualTableName} WHERE stat_table_id = ${db.statTable.actualTableName}.id)
         AND NOT EXISTS (SELECT 1 FROM ${db.exampleAudioTableXStatTable.actualTableName} WHERE stat_table_id = ${db.statTable.actualTableName}.id);''',

      // 14. Delete unreferenced Stat Names
      '''DELETE FROM ${db.statNameTable.actualTableName} 
         WHERE NOT EXISTS (SELECT 1 FROM ${db.statTable.actualTableName} WHERE stat_name_id = ${db.statNameTable.actualTableName}.id);''',
    ];

    for (final query in remainingQueries) {
      await db.customStatement(query);
    }
  }
}