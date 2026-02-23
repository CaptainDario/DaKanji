import 'dart:async';

import "package:da_db/database/da_db.dart";
import 'package:da_db/delete/index_delete.dart';
import 'package:da_db/parsing/util/db_optimization.dart';
import "package:drift/drift.dart";

part 'deletion_dao.g.dart';

// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor()
class DeletionDao extends DatabaseAccessor<DaDb> with _$DeletionDaoMixin {
  
  DeletionDao(super.db);

  /// Deletes a Yomitan dictionary and all its specific data.
  /// 
  /// Dictionary-specific data (TermBank, KanjiBank, Tags, etc.) is removed 
  /// automatically via 'ON DELETE CASCADE' on the Index entry. 
  /// **Unused** shared data (Term, Reading, Kanji, etc.) is cleaned up
  /// afterwards.
  Stream<String> deleteDictionary(int indexId) {
    final StreamController<String> progress = StreamController<String>();

    Future(() async {
      try {
        progress.add("Starting deletion");

        await db.transaction(() async {
          // 1. Delete the Index entry
          progress.add("Removing dictionary...");
          await deleteIndex(db, indexId);

          // 2. Perform Garbage Collection on shared tables
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

  /// Utility function to perform garbage collection on shared tables after a
  /// dictionary deletion.
  Future<void> garbageCollectSharedTables(DaDb db) async {

    final queries = [

      // 1. Delete tokens (contentless)
      '''DELETE FROM fts_tokens 
          WHERE rowid IN (
            SELECT id FROM term_table 
            WHERE NOT EXISTS (SELECT 1 FROM term_bank_v3_table WHERE term_id = term_table.id) 
            AND NOT EXISTS (SELECT 1 FROM term_meta_bank_v3_table WHERE term_id = term_table.id));''',

      // 2. Delete unreferenced Terms 
      '''DELETE FROM term_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_bank_v3_table WHERE term_id = term_table.id) 
        AND NOT EXISTS (SELECT 1 FROM term_meta_bank_v3_table WHERE term_id = term_table.id)
        AND NOT EXISTS (SELECT 1 FROM audio_table_x_term_table WHERE term_id = term_table.id);''',
      
      // 3. Delete unreferenced Readings 
      '''DELETE FROM reading_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_bank_v3_table WHERE reading_id = reading_table.id) 
        AND NOT EXISTS (SELECT 1 FROM term_meta_bank_v3_table WHERE reading_id = reading_table.id) 
        AND NOT EXISTS (SELECT 1 FROM audio_table WHERE reading_id = reading_table.id) 
        AND NOT EXISTS (SELECT 1 FROM kanji_bank_v3_x_onyomi_reading_table WHERE onyomi_reading_id = reading_table.id) 
        AND NOT EXISTS (SELECT 1 FROM kanji_bank_v3_x_kunyomi_reading_table WHERE kunyomi_reading_id = reading_table.id);''',
      
      // 4. Delete unreferenced Kanjis
      '''DELETE FROM kanji_table 
        WHERE NOT EXISTS (SELECT 1 FROM kanji_bank_v3_table WHERE kanji_id = kanji_table.id) 
        AND NOT EXISTS (SELECT 1 FROM kanji_meta_bank_v3_table WHERE kanji_id = kanji_table.id) 
        AND NOT EXISTS (SELECT 1 FROM kanji_v_g_table WHERE kanji_id = kanji_table.id) 
        AND NOT EXISTS (SELECT 1 FROM radical_x_kanji_relations_table WHERE kanji_id = kanji_table.id);''',
      
      // 5. Delete unreferenced Definitions
      '''DELETE FROM definition_table 
        WHERE NOT EXISTS (SELECT 1 FROM kanji_bank_v3_x_definition_table WHERE definition_id = definition_table.id) 
        AND NOT EXISTS (SELECT 1 FROM term_bank_v3_x_definition_table WHERE definition_id = definition_table.id);''',
      
      // 6. Delete unreferenced Structured Content JSON
      '''DELETE FROM term_bank_v3_definition_json_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_bank_v3_table WHERE definition_json_id = term_bank_v3_definition_json_table.id);''',
      
      // 7. Delete unreferenced Rule Identifiers
      '''DELETE FROM term_bank_v3_rule_identifier_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_bank_v3_x_rule_identifier_table WHERE rule_identifier_id = term_bank_v3_rule_identifier_table.id);''',
      
      // 8. Delete unreferenced Term Meta Type metadata
      '''DELETE FROM term_meta_bank_v3_type_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_meta_bank_v3_table WHERE type_id = term_meta_bank_v3_type_table.id);''',
      
      // 9. Delete unreferenced Kanji Meta Type metadata
      '''DELETE FROM kanji_meta_bank_v3_type_table 
        WHERE NOT EXISTS (SELECT 1 FROM kanji_meta_bank_v3_table WHERE type_id = kanji_meta_bank_v3_type_table.id);''',
      
      // 10. Delete unreferenced Pitch entries
      '''DELETE FROM term_meta_bank_v3_pitch_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_meta_bank_v3_x_pitch_table WHERE pitch_id = term_meta_bank_v3_pitch_table.id);''',
      
      // 11. Delete unreferenced IPA entries
      '''DELETE FROM term_meta_bank_v3_ipa_table 
        WHERE NOT EXISTS (SELECT 1 FROM term_meta_bank_v3_x_ipa_table WHERE ipa_id = term_meta_bank_v3_ipa_table.id);''',
      
      // 12. Delete unreferenced Language Codes
      '''DELETE FROM language_code_table 
        WHERE NOT EXISTS (SELECT 1 FROM example_translation_table WHERE language_code_id = language_code_table.id);''',

      // 13. Delete unreferenced Example Translations
      '''DELETE FROM example_translation_table 
        WHERE NOT EXISTS (SELECT 1 FROM example_table_x_example_translation_table WHERE translation_id = example_translation_table.id);''',

      // 14. --- Audios ---
      '''DELETE FROM media_table 
         WHERE NOT EXISTS (SELECT 1 FROM audio_table WHERE media_id = media_table.id);''',

      // 15. --- Examples ---
      '''DELETE FROM example_table 
         WHERE NOT EXISTS (SELECT 1 FROM example_table_x_example_translation_table WHERE example_id = example_table.id);'''
    ];

    // Removed the nested transaction here! We just execute the queries directly.
    for (final query in queries) {
      await db.customStatement(query);
    }
  }
}