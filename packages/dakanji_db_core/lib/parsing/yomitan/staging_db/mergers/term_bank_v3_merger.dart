import 'package:dakanji_db_core/database/dakanji_db.dart';

import 'staging_merger.dart'; // Ensure this matches your file structure

class TermBankV3Merger implements StagingMerger {
  final bool addJsonDefs;

  TermBankV3Merger({required this.addJsonDefs});

  @override
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
  }) async {
    
    final maxTermBankId = (await targetDb.termBankV3Dao.maxTermBankV3Id());
    final maxJsonId = addJsonDefs ? (await targetDb.termBankV3Dao.maxTermBankV3DefinitionJsonId()) : 0;

    // --- 1. Insert Unique Strings ---

    // Term Table
    await targetDb.customStatement('''
      INSERT OR IGNORE INTO ${targetDb.termTable.actualTableName} (term, term_normalized, term_tokens, term_tokens_normalized)
      SELECT DISTINCT term, term_normalized, term_tokens, term_tokens_normalized 
      FROM $workerAlias.staging_term_table
    ''');

    // Reading Table
    await targetDb.customStatement('''
      INSERT OR IGNORE INTO ${targetDb.readingTable.actualTableName} (reading, reading_normalized)
      SELECT DISTINCT reading, reading_normalized 
      FROM $workerAlias.staging_term_table
    ''');

    // Definition Table
    await targetDb.customStatement('''
      INSERT OR IGNORE INTO ${targetDb.definitionTable.actualTableName} (definition)
      SELECT DISTINCT definition 
      FROM $workerAlias.staging_definition_table
    ''');
    
    // Tag Bank Table
    await targetDb.customStatement('''
      INSERT OR IGNORE INTO ${targetDb.tagBankV3Table.actualTableName} (index_id, name, category, sorting_order, notes, score)
      SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
      FROM $workerAlias.staging_tag_table
    ''');

    // Rule Identifier Table
    await targetDb.customStatement('''
      INSERT OR IGNORE INTO ${targetDb.termBankV3RuleIdentifierTable.actualTableName} (rule_identifier)
      SELECT DISTINCT rule_id 
      FROM $workerAlias.staging_rule_table
    ''');

    // JSON Definitions (Optional)
    if (addJsonDefs) {
      await targetDb.customStatement('''
        INSERT INTO ${targetDb.termBankV3DefinitionJsonTable.actualTableName} (id, definition_json)
        SELECT 
          $maxJsonId + local_id,
          original_json
        FROM $workerAlias.staging_term_table
        WHERE original_json IS NOT NULL
      ''');
    }

    // --- 2. Main Term Bank Table ---
    
    await targetDb.customStatement('''
      INSERT INTO ${targetDb.termBankV3Table.actualTableName} (
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
      INNER JOIN ${targetDb.termTable.actualTableName} tt ON tt.term = s.term
      INNER JOIN ${targetDb.readingTable.actualTableName} rt ON rt.reading = s.reading
    ''');

    // --- 3. Junction Tables ---

    // Terms <-> Definitions
    await targetDb.customStatement('''
      INSERT INTO ${targetDb.termBankV3XDefinitionTable.actualTableName} (term_bank_id, definition_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        d.id
      FROM $workerAlias.staging_definition_table s
      JOIN ${targetDb.definitionTable.actualTableName} d ON d.definition = s.definition
    ''');

    // Terms <-> Tags (General Tags)
    await targetDb.customStatement('''
      INSERT INTO ${targetDb.termBankV3XTagBankTable.actualTableName} (term_bank_id, tag_bank_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        t.id
      FROM $workerAlias.staging_tag_table s
      JOIN ${targetDb.tagBankV3Table.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
      WHERE s.is_definition_tag = 0
    ''');
    
    // Terms <-> Definition Tags
    await targetDb.customStatement('''
      INSERT INTO ${targetDb.termBankV3XDefinitionTagTable.actualTableName} (term_bank_id, definition_tag_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        t.id
      FROM $workerAlias.staging_tag_table s
      JOIN ${targetDb.tagBankV3Table.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
      WHERE s.is_definition_tag = 1
    ''');

    // Terms <-> Rules
    await targetDb.customStatement('''
      INSERT INTO ${targetDb.termBankV3XRuleIdentifierTable.actualTableName} (term_bank_id, rule_identifier_id)
      SELECT 
        $maxTermBankId + s.term_local_id,
        r.id
      FROM $workerAlias.staging_rule_table s
      JOIN ${targetDb.termBankV3RuleIdentifierTable.actualTableName} r ON r.rule_identifier = s.rule_id
    ''');
  }
}