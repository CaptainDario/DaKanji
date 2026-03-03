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

  /// Utility function to perform garbage collection on shared tables after a
  /// dictionary deletion, using Drift's generated table names.
  Future<void> garbageCollectSharedTables(DaDb db) async {
    
    // --- Store Generated Table Names for SQL String Interpolation ---
    final term = db.termTable.actualTableName;
    final termBank = db.termBankV3Table.actualTableName;
    final termMeta = db.termMetaBankV3Table.actualTableName;
    final audioTerm = db.audioTableXTermTable.actualTableName;
    
    final reading = db.readingTable.actualTableName;
    final audio = db.audioTable.actualTableName;
    final kanjiOnyomi = db.kanjiBankV3XOnyomiReadingTable.actualTableName;
    final kanjiKunyomi = db.kanjiBankV3XKunyomiReadingTable.actualTableName;
    
    final kanji = db.kanjiTable.actualTableName;
    final kanjiBank = db.kanjiBankV3Table.actualTableName;
    final kanjiMeta = db.kanjiMetaBankV3Table.actualTableName;
    final kanjiVg = db.kanjiVGTable.actualTableName; 
    final radicalKanji = db.radicalXKanjiRelationsTable.actualTableName;
    
    final def = db.definitionTable.actualTableName;
    final kanjiDef = db.kanjiBankV3XDefinitionTable.actualTableName;
    final termDef = db.termBankV3XDefinitionTable.actualTableName;
    
    final termJson = db.termBankV3DefinitionJsonTable.actualTableName;
    
    final rule = db.termBankV3RuleIdentifierTable.actualTableName;
    final termRule = db.termBankV3XRuleIdentifierTable.actualTableName;
    
    final termMetaType = db.termMetaBankV3TypeTable.actualTableName;
    final kanjiMetaType = db.kanjiMetaBankV3TypeTable.actualTableName;
    
    final pitch = db.termMetaBankV3PitchTable.actualTableName;
    final termPitch = db.termMetaBankV3XPitchTable.actualTableName;
    
    final ipa = db.termMetaBankV3IpaTable.actualTableName;
    final termIpa = db.termMetaBankV3XIpaTable.actualTableName;
    
    final media = db.mediaTable.actualTableName;
    
    final exSentence = db.exampleSentenceTable.actualTableName;
    final exTable = db.exampleTable.actualTableName;
    
    final exAudio = db.exampleAudioTable.actualTableName;
    final exTableAudio = db.exampleTableXExampleAudioTable.actualTableName;
    
    final langCode = db.languageCodeTable.actualTableName;
    
    final stat = db.statTable.actualTableName;
    final exStat = db.exampleTableXStatTable.actualTableName;
    final exAudioStat = db.exampleAudioTableXStatTable.actualTableName;
    
    final statName = db.statNameTable.actualTableName;


    // --- Execute Deletions ---
    final queries = [

      // 1. Delete tokens (contentless FTS table string is hardcoded since Drift doesn't always expose a standard getter for them)
      '''DELETE FROM fts_tokens 
          WHERE rowid IN (
            SELECT id FROM $term 
            WHERE NOT EXISTS (SELECT 1 FROM $termBank WHERE term_id = $term.id) 
            AND NOT EXISTS (SELECT 1 FROM $termMeta WHERE term_id = $term.id));''',

      // 2. Delete unreferenced Terms 
      '''DELETE FROM $term 
        WHERE NOT EXISTS (SELECT 1 FROM $termBank WHERE term_id = $term.id) 
        AND NOT EXISTS (SELECT 1 FROM $termMeta WHERE term_id = $term.id)
        AND NOT EXISTS (SELECT 1 FROM $audioTerm WHERE term_id = $term.id);''',
      
      // 3. Delete unreferenced Readings 
      '''DELETE FROM $reading 
        WHERE NOT EXISTS (SELECT 1 FROM $termBank WHERE reading_id = $reading.id) 
        AND NOT EXISTS (SELECT 1 FROM $termMeta WHERE reading_id = $reading.id) 
        AND NOT EXISTS (SELECT 1 FROM $audio WHERE reading_id = $reading.id) 
        AND NOT EXISTS (SELECT 1 FROM $kanjiOnyomi WHERE onyomi_reading_id = $reading.id) 
        AND NOT EXISTS (SELECT 1 FROM $kanjiKunyomi WHERE kunyomi_reading_id = $reading.id);''',
      
      // 4. Delete unreferenced Kanjis
      '''DELETE FROM $kanji 
        WHERE NOT EXISTS (SELECT 1 FROM $kanjiBank WHERE kanji_id = $kanji.id) 
        AND NOT EXISTS (SELECT 1 FROM $kanjiMeta WHERE kanji_id = $kanji.id) 
        AND NOT EXISTS (SELECT 1 FROM $kanjiVg WHERE kanji_id = $kanji.id) 
        AND NOT EXISTS (SELECT 1 FROM $radicalKanji WHERE kanji_id = $kanji.id);''',
      
      // 5. Delete unreferenced Definitions
      '''DELETE FROM $def 
        WHERE NOT EXISTS (SELECT 1 FROM $kanjiDef WHERE definition_id = $def.id) 
        AND NOT EXISTS (SELECT 1 FROM $termDef WHERE definition_id = $def.id);''',
      
      // 6. Delete unreferenced Structured Content JSON
      '''DELETE FROM $termJson 
        WHERE NOT EXISTS (SELECT 1 FROM $termBank WHERE definition_json_id = $termJson.id);''',
      
      // 7. Delete unreferenced Rule Identifiers
      '''DELETE FROM $rule 
        WHERE NOT EXISTS (SELECT 1 FROM $termRule WHERE rule_identifier_id = $rule.id);''',
      
      // 8. Delete unreferenced Term Meta Type metadata
      '''DELETE FROM $termMetaType 
        WHERE NOT EXISTS (SELECT 1 FROM $termMeta WHERE type_id = $termMetaType.id);''',
      
      // 9. Delete unreferenced Kanji Meta Type metadata
      '''DELETE FROM $kanjiMetaType 
        WHERE NOT EXISTS (SELECT 1 FROM $kanjiMeta WHERE type_id = $kanjiMetaType.id);''',
      
      // 10. Delete unreferenced Pitch entries
      '''DELETE FROM $pitch 
        WHERE NOT EXISTS (SELECT 1 FROM $termPitch WHERE pitch_id = $pitch.id);''',
      
      // 11. Delete unreferenced IPA entries
      '''DELETE FROM $ipa 
        WHERE NOT EXISTS (SELECT 1 FROM $termIpa WHERE ipa_id = $ipa.id);''',

      // 12. Delete unreferenced Audios (Media)
      '''DELETE FROM $media 
         WHERE NOT EXISTS (SELECT 1 FROM $audio WHERE media_id = $media.id);''',

      // 13. Delete unreferenced Example FTS Tokens
      '''DELETE FROM fts_example_tokens 
         WHERE rowid NOT IN (SELECT example_sentence_id FROM $exTable);''',

      // 14. Delete unreferenced Example Sentences
      '''DELETE FROM $exSentence 
         WHERE NOT EXISTS (SELECT 1 FROM $exTable WHERE example_sentence_id = $exSentence.id);''',

      // 15. Delete unreferenced Example Audios
      '''DELETE FROM $exAudio 
         WHERE NOT EXISTS (SELECT 1 FROM $exTableAudio WHERE audio_id = $exAudio.id);''',

      // 16. Delete unreferenced Language Codes
      '''DELETE FROM $langCode 
         WHERE NOT EXISTS (SELECT 1 FROM $exTable WHERE language_code_id = $langCode.id);''',

      // 17. Delete unreferenced Stat Combinations
      '''DELETE FROM $stat 
         WHERE NOT EXISTS (SELECT 1 FROM $exStat WHERE stat_table_id = $stat.id)
         AND NOT EXISTS (SELECT 1 FROM $exAudioStat WHERE stat_table_id = $stat.id);''',

      // 18. Delete unreferenced Stat Names
      '''DELETE FROM $statName 
         WHERE NOT EXISTS (SELECT 1 FROM $stat WHERE stat_name_id = $statName.id);''',
    ];

    for (final query in queries) {
      await db.customStatement(query);
    }
  }
}