import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/staging_merger.dart';



class TermBankV3Merger implements StagingMerger {
  @override
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
    required bool addJsonDefs,
  }) async {
    
    final maxTermBankId = (await targetDb.termBankV3Dao.maxTermBankV3Id());
    final maxJsonId = addJsonDefs ? (await targetDb.termBankV3Dao.maxTermBankV3DefinitionJsonId()) : 0;

    // 1. Insert Strings
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
        SELECT 
          $maxJsonId + local_id,
          original_json
        FROM $workerAlias.staging_term_table
        WHERE original_json IS NOT NULL
      ''');
    }

    // 2. Main Table
    await targetDb.customStatement('''
      INSERT INTO term_bank_v3_table (
        id, index_id, term_id, reading_id, popularity, sequence_number, definition_order, definition_json_id
      )
      SELECT 
        $maxTermBankId + s.local_id,
        $indexId,
        tt.id, 
        rt.id,
        s.popularity,
        s.sequence_number,
        '[]', 
        ${addJsonDefs ? 'CASE WHEN s.original_json IS NOT NULL THEN $maxJsonId + s.local_id ELSE NULL END' : 'NULL'}
      FROM $workerAlias.staging_term_table s
      INNER JOIN term_table tt ON tt.term = s.term
      INNER JOIN reading_table rt ON rt.reading = s.reading
    ''');

    // 3. Junction Tables
    await targetDb.customStatement('''
      INSERT INTO term_bank_v3_x_definition_table (term_bank_id, definition_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        d.id
      FROM $workerAlias.staging_definition_table s
      JOIN definition_table d ON d.definition = s.definition
    ''');

    await targetDb.customStatement('''
      INSERT INTO term_bank_v3_x_tag_bank_table (term_bank_id, tag_bank_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        t.id
      FROM $workerAlias.staging_tag_table s
      JOIN tag_bank_v3_table t ON t.name = s.tag_name AND t.index_id = $indexId
      WHERE s.is_definition_tag = 0
    ''');
    
    await targetDb.customStatement('''
      INSERT INTO term_bank_v3_x_definition_tag_table (term_bank_id, definition_tag_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        t.id
      FROM $workerAlias.staging_tag_table s
      JOIN tag_bank_v3_table t ON t.name = s.tag_name AND t.index_id = $indexId
      WHERE s.is_definition_tag = 1
    ''');

    await targetDb.customStatement('''
      INSERT INTO term_bank_v3_x_rule_identifier_table (term_bank_id, rule_identifier_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        r.id
      FROM $workerAlias.staging_rule_table s
      JOIN term_bank_v3_rule_identifier_table r ON r.rule_identifier = s.rule_id
    ''');
  }
}