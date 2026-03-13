import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';
import 'package:language_processing/language_processing.dart';

class ExampleMerger implements StagingMerger {
  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required YomitanIndex index,
    required int indexId,
  }) async {

    final bool isSourceSpaceLang = usesSpaceSeparation(index.sourceLanguage);
    
    final String ftsSentenceTable = isSourceSpaceLang 
        ? "fts_example_sentence_unicode" : "fts_example_sentence";
    final String ftsTokenizedTable = "fts_example_sentence_tokenized";

    final maxSentenceId = await targetDb.exampleDao.maxExampleSentenceId();
    final maxExampleId = await targetDb.exampleDao.maxExampleId();
    final maxAudioId = await targetDb.exampleDao.maxExampleAudioTableId();

    try {
      // 1. Sentences (Main Data)
      await targetDb.customStatement('''
        INSERT INTO example_sentence_table (id, example_sentence, example_sentence_tokenized)
          SELECT $maxSentenceId + local_id, example_sentence, example_sentence_tokenized
          FROM $workerAlias.example_staging_table
          ORDER BY local_id
      ''');

      // 2. FTS Tokens
      await targetDb.customStatement('''
        INSERT INTO $ftsSentenceTable (rowid, example_sentence)
          SELECT $maxSentenceId + local_id, example_sentence
          FROM $workerAlias.example_staging_table
          ORDER BY local_id
      ''');
      await targetDb.customStatement('''
        INSERT INTO $ftsTokenizedTable (rowid, example_sentence_tokenized)
          SELECT $maxSentenceId + local_id, example_sentence_tokenized
          FROM $workerAlias.example_staging_table
          WHERE example_sentence_tokenized IS NOT NULL
          ORDER BY local_id
      ''');

      // 3. Examples
      await targetDb.customStatement('''
        INSERT INTO example_table (id, index_id, group_id, example_sentence_id)
          SELECT 
            $maxExampleId + e.local_id, 
            $indexId, 
            e.group_id, 
            $maxSentenceId + e.local_id
          FROM $workerAlias.example_staging_table AS e
          ORDER BY e.local_id
      ''');

      // 4. Audios
      await targetDb.customStatement('''
        INSERT INTO example_audio_table (id, path, name)
          SELECT $maxAudioId + a.local_id, a.path, a.name
          FROM $workerAlias.example_audio_staging_table AS a
          ORDER BY a.local_id
      ''');

      // 5. Audio Link
      await targetDb.customStatement('''
        INSERT INTO example_table_x_example_audio_table (example_id, audio_id)
          SELECT $maxExampleId + a.example_local_id, $maxAudioId + a.local_id
          FROM $workerAlias.example_audio_staging_table AS a
      ''');

      // 6. Tags (Generate dummy tags for any missing definitions, then link)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO tag_bank_v3_table (index_id, name, category, sorting_order, notes, score)
          SELECT DISTINCT $indexId, tag_name, 'tag', 0, '', 0 FROM $workerAlias.example_tag_staging_table
          UNION
          SELECT DISTINCT $indexId, tag_name, 'tag', 0, '', 0 FROM $workerAlias.example_audio_tag_staging_table
      ''');

      await targetDb.customStatement('''
        INSERT INTO example_table_x_tag_bank_table (example_id, tag_bank_id)
          SELECT $maxExampleId + s.example_local_id, t.id
          FROM $workerAlias.example_tag_staging_table AS s
            INNER JOIN tag_bank_v3_table AS t ON t.name = s.tag_name AND t.index_id = $indexId
      ''');

      await targetDb.customStatement('''
        INSERT INTO example_audio_table_x_tag_bank_table (audio_id, tag_bank_id)
          SELECT $maxAudioId + a.audio_local_id, t.id
          FROM $workerAlias.example_audio_tag_staging_table AS a
            INNER JOIN tag_bank_v3_table AS t ON t.name = a.tag_name AND t.index_id = $indexId
      ''');

      // 7. Stats - The Grand Finale
      // First, pool all unique stat names and display names
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO stat_name_table (name)
          SELECT DISTINCT stat_name FROM $workerAlias.example_stat_staging_table WHERE stat_name IS NOT NULL
          UNION
          SELECT DISTINCT display_name FROM $workerAlias.example_stat_staging_table WHERE display_name IS NOT NULL
          UNION
          SELECT DISTINCT stat_name FROM $workerAlias.example_audio_stat_staging_table WHERE stat_name IS NOT NULL
          UNION
          SELECT DISTINCT display_name FROM $workerAlias.example_audio_stat_staging_table WHERE display_name IS NOT NULL
      ''');

      // Second, generate the unique Stat combinations
      await targetDb.customStatement('''
        INSERT INTO stat_table (stat_name_id, stat_display_name_id, value, display_value)
          SELECT n1.id, n2.id, s.stat_value, s.display_value
          FROM $workerAlias.example_stat_staging_table s
            INNER JOIN stat_name_table n1 ON n1.name = s.stat_name
            LEFT JOIN stat_name_table n2 ON n2.name = s.display_name
          UNION
          SELECT n1.id, n2.id, a.stat_value, a.display_value
          FROM $workerAlias.example_audio_stat_staging_table a
            INNER JOIN stat_name_table n1 ON n1.name = a.stat_name
            LEFT JOIN stat_name_table n2 ON n2.name = a.display_name
          EXCEPT
          SELECT stat_name_id, stat_display_name_id, value, display_value 
          FROM stat_table
      ''');
      // Third, Link Example Stats
      await targetDb.customStatement('''
        INSERT INTO example_table_x_stat_table (example_id, stat_table_id)
          SELECT $maxExampleId + s.example_local_id, sb.id
          FROM $workerAlias.example_stat_staging_table s
            INNER JOIN stat_name_table n1 ON n1.name = s.stat_name
            LEFT JOIN stat_name_table n2 ON n2.name = s.display_name
            INNER JOIN stat_table sb ON 
              sb.stat_name_id = n1.id 
              AND sb.stat_display_name_id IS n2.id
              AND sb.value IS s.stat_value
              AND sb.display_value IS s.display_value
      ''');

      // Fourth, Link Audio Stats
      await targetDb.customStatement('''
        INSERT INTO example_audio_table_x_stat_table (audio_id, stat_table_id)
          SELECT $maxAudioId + a.audio_local_id, sb.id
          FROM $workerAlias.example_audio_stat_staging_table a
            INNER JOIN stat_name_table n1 ON n1.name = a.stat_name
            LEFT JOIN stat_name_table n2 ON n2.name = a.display_name
            INNER JOIN stat_table sb ON 
              sb.stat_name_id = n1.id 
              AND sb.stat_display_name_id IS n2.id
              AND sb.value IS a.stat_value
              AND sb.display_value IS a.display_value
      ''');

    } catch (e) {
      print("Error during ExampleBank merge: $e");
      rethrow;
    }
  }
}