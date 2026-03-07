import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';

class ExampleMerger implements StagingMerger {
  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required int indexId,
  }) async {

    final maxSentenceId = await targetDb.exampleDao.maxExampleSentenceId();
    final maxExampleId = await targetDb.exampleDao.maxExampleId();
    final maxAudioId = await targetDb.exampleDao.maxExampleAudioTableId();
    final maxTermId = await targetDb.termDao.maxTermId();

    try {
      // 1. Languages
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO language_code_table (language_code)
          SELECT DISTINCT language_code FROM $workerAlias.example_staging_table
      ''');

      // 2. Sentences (Main Data)
      await targetDb.customStatement('''
        INSERT INTO example_sentence_table (id, example_sentence)
          SELECT $maxSentenceId + local_id, example_sentence
          FROM $workerAlias.example_staging_table
          ORDER BY local_id
      ''');

      // 3. FTS Tokens
      await targetDb.customStatement('''
        INSERT INTO fts_example_tokens (rowid, example_sentence)
          SELECT $maxSentenceId + local_id, example_sentence
          FROM $workerAlias.example_staging_table
          ORDER BY local_id
      ''');

      // 4. Examples
      await targetDb.customStatement('''
        INSERT INTO example_table (id, index_id, group_id, example_sentence_id, language_code_id)
          SELECT 
            $maxExampleId + e.local_id, 
            $indexId, 
            e.group_id, 
            $maxSentenceId + e.local_id, 
            l.id
          FROM $workerAlias.example_staging_table AS e
            INNER JOIN language_code_table AS l ON l.language_code = e.language_code
          ORDER BY e.local_id
      ''');

      // 5. Audios
      await targetDb.customStatement('''
        INSERT INTO example_audio_table (id, path, name)
            SELECT $maxAudioId + a.local_id, a.path, a.name
            FROM $workerAlias.example_audio_staging_table AS a
            ORDER BY a.local_id
      ''');

      // 6. Audio Link
      await targetDb.customStatement('''
        INSERT INTO example_table_x_example_audio_table (example_id, audio_id)
            SELECT $maxExampleId + a.example_local_id, $maxAudioId + a.local_id
            FROM $workerAlias.example_audio_staging_table AS a
      ''');

      // 7. Terms
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO term_table (term, term_normalized)
            SELECT DISTINCT term, term FROM $workerAlias.example_term_staging_table
      ''');
      await targetDb.customStatement('''
        INSERT INTO fts_terms(rowid, term, term_normalized)
        SELECT id, term, term_normalized FROM term_table WHERE id > $maxTermId
      ''');
      await targetDb.customStatement('''
        INSERT INTO example_sentence_table_x_term_table (example_sentence_id, term_id)
            SELECT $maxSentenceId + s.example_local_id, t.id
            FROM $workerAlias.example_term_staging_table AS s
                INNER JOIN term_table AS t ON t.term = s.term
      ''');

      // 8. Tags (Generate dummy tags for any missing definitions, then link)
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

      // 9. Stats - The Grand Finale
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
        INSERT OR IGNORE INTO stat_table (stat_name_id, stat_display_name_id, value, display_value)
            SELECT DISTINCT n1.id, n2.id, s.stat_value, s.display_value
            FROM $workerAlias.example_stat_staging_table s
                INNER JOIN stat_name_table n1 ON n1.name = s.stat_name
                LEFT JOIN stat_name_table n2 ON n2.name = s.display_name
            UNION
            SELECT DISTINCT n1.id, n2.id, a.stat_value, a.display_value
            FROM $workerAlias.example_audio_stat_staging_table a
                INNER JOIN stat_name_table n1 ON n1.name = a.stat_name
                LEFT JOIN stat_name_table n2 ON n2.name = a.display_name
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