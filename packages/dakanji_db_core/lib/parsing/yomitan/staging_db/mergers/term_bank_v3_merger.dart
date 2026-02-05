import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/staging_merger.dart';



class TermMerger implements StagingMerger {
  @override
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
    required bool addJsonDefs,
  }) async {
    
    // 1. Fast Exit
    final countResult = await targetDb.customSelect(
      'SELECT count(*) as c FROM $workerAlias.staging_term_table'
    ).getSingle();
    
    if ((countResult.data['c'] as int) == 0) return;

    // 2. Setup IDs
    final maxTermBankId = (await targetDb.termBankV3Dao.maxTermBankV3Id());
    final maxJsonId = addJsonDefs ? (await targetDb.termBankV3Dao.maxTermBankV3DefinitionJsonId()) : 0;

    // 3. PERFORMANCE: Disable Foreign Keys & Sync for this bulk operation
    await targetDb.customStatement('PRAGMA foreign_keys = OFF;');
    
    try {
      // 4. Insert Unique Strings (Terms, Readings, etc.)
      // Note: Ensure 'term_table' has an INDEX on 'term' in your Drift definition!
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO term_table (term, term_normalized, term_tokens, term_tokens_normalized)
        SELECT DISTINCT term, term_normalized, term_tokens, term_tokens_normalized 
        FROM $workerAlias.staging_term_table
      ''');

      await targetDb.customStatement('''
        INSERT OR IGNORE INTO reading_table (reading, reading_normalized)
        SELECT DISTINCT reading, reading_normalized 
        FROM $workerAlias.staging_term_table
      ''');

      await targetDb.customStatement('''
        INSERT OR IGNORE INTO definition_table (definition)
        SELECT DISTINCT definition 
        FROM $workerAlias.staging_definition_table
      ''');
      
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO tag_bank_v3_table (index_id, name, category, sorting_order, notes, score)
        SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
        FROM $workerAlias.staging_tag_table
      ''');

      await targetDb.customStatement('''
        INSERT OR IGNORE INTO term_bank_v3_rule_identifier_table (rule_identifier)
        SELECT DISTINCT rule_id 
        FROM $workerAlias.staging_rule_table
      ''');

      if (addJsonDefs) {
        await targetDb.customStatement('''
          INSERT INTO term_bank_v3_definition_json_table (id, definition_json)
          SELECT $maxJsonId + local_id, original_json
          FROM $workerAlias.staging_term_table
          WHERE original_json IS NOT NULL
        ''');
      }

      // 5. OPTIMIZATION: Use JOIN instead of Subqueries
      // This changes O(N * log M) lookups into a single O(N + M) Hash Join.
      // Much faster for large datasets.
      await targetDb.customStatement('''
        INSERT INTO term_bank_v3_table (
          id, index_id, term_id, reading_id, popularity, sequence_number, definition_order, definition_json_id
        )
        SELECT 
          $maxTermBankId + s.local_id,
          $indexId,
          tt.id, -- Retrieved via JOIN
          rt.id, -- Retrieved via JOIN
          s.popularity,
          s.sequence_number,
          '[]', 
          ${addJsonDefs ? 'CASE WHEN s.original_json IS NOT NULL THEN $maxJsonId + s.local_id ELSE NULL END' : 'NULL'}
        FROM $workerAlias.staging_term_table s
        INNER JOIN term_table tt ON tt.term = s.term
        INNER JOIN reading_table rt ON rt.reading = s.reading
      ''');

      // 6. Link Relations (Definitions)
      await targetDb.customStatement('''
        INSERT INTO term_bank_v3_x_definition_table (term_bank_id, definition_id)
        SELECT 
          $maxTermBankId + s.term_local_id,
          d.id
        FROM $workerAlias.staging_definition_table s
        INNER JOIN definition_table d ON d.definition = s.definition
      ''');

      // 7. Link Relations (Tags)
      await targetDb.customStatement('''
        INSERT INTO term_bank_v3_x_tag_bank_table (term_bank_id, tag_bank_id)
        SELECT 
          $maxTermBankId + s.term_local_id,
          t.id
        FROM $workerAlias.staging_tag_table s
        INNER JOIN tag_bank_v3_table t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.is_definition_tag = 0
      ''');
      
      // Link Definition Tags
      await targetDb.customStatement('''
        INSERT INTO term_bank_v3_x_definition_tag_table (term_bank_id, definition_tag_id)
        SELECT 
          $maxTermBankId + s.term_local_id,
          t.id
        FROM $workerAlias.staging_tag_table s
        INNER JOIN tag_bank_v3_table t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.is_definition_tag = 1
      ''');

      // Link Rules
      await targetDb.customStatement('''
        INSERT INTO term_bank_v3_x_rule_identifier_table (term_bank_id, rule_identifier_id)
        SELECT 
          $maxTermBankId + s.term_local_id,
          r.id
        FROM $workerAlias.staging_rule_table s
        INNER JOIN term_bank_v3_rule_identifier_table r ON r.rule_identifier = s.rule_id
      ''');

    } finally {
      // Re-enable Foreign Keys
      await targetDb.customStatement('PRAGMA foreign_keys = ON;');
    }
  }
}