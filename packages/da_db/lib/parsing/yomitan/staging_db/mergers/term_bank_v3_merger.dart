// Dart imports:
import 'package:da_db/database/da_db.dart';

import '../../../staging_db/mergers/staging_merger.dart';

class TermBankV3Merger implements StagingMerger {

  TermBankV3Merger();

  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required int indexId,
  }) async {

    final maxTermBankId = (await targetDb.termBankV3Dao.maxTermBankV3Id());

    try {
      final tTerm = targetDb.termTable;
      final tReading = targetDb.readingTable;
      final tDef = targetDb.definitionTable;
      final tTag = targetDb.tagBankV3Table;
      final tRule = targetDb.termBankV3RuleIdentifierTable;
      final tJson = targetDb.termBankV3DefinitionJsonTable;
      final tMain = targetDb.termBankV3Table;

      final tjDef = targetDb.termBankV3XDefinitionTable;
      final tjTag = targetDb.termBankV3XTagBankTable;
      final tjDefTag = targetDb.termBankV3XDefinitionTagTable;
      final tjRule = targetDb.termBankV3XRuleIdentifierTable;

      // --- Insert Basic Strings (Terms, Readings, Defs) ---
      
      // Terms (Unique)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTerm.actualTableName} (${tTerm.term.name}, ${tTerm.termNormalized.name})
        SELECT DISTINCT term, term_normalized
        FROM $workerAlias.term_staging_table
      ''');

      // FTS Tokens (Contentless, only insertif tokens != term)
      await targetDb.customStatement('''
        INSERT INTO fts_tokens(rowid, tokens, tokens_normalized)
        SELECT DISTINCT t.${tTerm.id.name}, s.term_tokens, s.term_tokens_normalized
        FROM $workerAlias.term_staging_table s
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = s.term
        WHERE 
          s.term_tokens IS NOT NULL 
          AND s.term_tokens != s.term  -- <--- The Filter
          AND NOT EXISTS (SELECT 1 FROM fts_tokens WHERE rowid = t.${tTerm.id.name})
      ''');

      // Readings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (${tReading.reading.name}, ${tReading.readingNormalized.name})
        SELECT DISTINCT reading, reading_normalized 
        FROM $workerAlias.term_staging_table
      ''');

      // Definitions (Simple)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tDef.actualTableName} (${tDef.definition.name})
        SELECT DISTINCT definition 
        FROM $workerAlias.term_definition_staging_table
      ''');
      
      // Tags
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTag.actualTableName} (${tTag.indexId.name}, ${tTag.name.name}, ${tTag.category.name}, ${tTag.sortingOrder.name}, ${tTag.notes.name}, ${tTag.score.name})
        SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
        FROM $workerAlias.term_tag_staging_table s
        WHERE NOT EXISTS (
          SELECT 1 FROM ${tTag.actualTableName} t 
          WHERE t.name = s.tag_name AND t.index_id = $indexId
        )
      ''');

      // Rules
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tRule.actualTableName} (${tRule.ruleIdentifier.name})
        SELECT DISTINCT rule_id 
        FROM $workerAlias.term_rule_staging_table
      ''');

      // --- JSON Deduplication ---
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tJson.actualTableName} (${tJson.definitionJsonHash.name}, ${tJson.definitionJson.name})
        SELECT definition_json_hash, original_json
        FROM $workerAlias.term_staging_table 
        WHERE original_json IS NOT NULL 
        GROUP BY definition_json_hash
      ''');

      // --- Main Insert with Linking ---
      // join Staging -> Final using the HASH (Fast Index Lookup)
      await targetDb.customStatement('''
        INSERT INTO ${tMain.actualTableName} (
          ${tMain.id.name}, ${tMain.indexId.name}, ${tMain.termId.name}, ${tMain.readingId.name}, 
          ${tMain.popularity.name}, ${tMain.sequenceNumber.name}, ${tMain.definitionJsonId.name}
        )
        SELECT 
          $maxTermBankId + s.local_id,
          $indexId,
          t.${tTerm.id.name},
          r.${tReading.id.name},
          s.popularity,
          s.sequence_number,
          j.${tJson.id.name}
        FROM $workerAlias.term_staging_table s
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = s.term
        JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = s.reading
        -- Link using definition_json_hash
        LEFT JOIN ${tJson.actualTableName} j ON j.${tJson.definitionJsonHash.name} = s.definition_json_hash
        GROUP BY s.local_id  -- Ensure unique ID generation
        ORDER BY s.term
      ''');

      // --- Junction Tables ---
      await targetDb.customStatement('''
        INSERT INTO ${tjDef.actualTableName} (
            ${tjDef.termBankId.name}, 
            ${tjDef.definitionId.name}, 
            ${tjDef.rank.name}
        )
        SELECT 
            $maxTermBankId + s.term_local_id, 
            d.id, 
            s.rank -- Select the rank from staging
        FROM $workerAlias.term_definition_staging_table s
        JOIN ${tDef.actualTableName} d ON d.definition = s.definition
        ORDER BY s.rowid
      ''');

      await targetDb.customStatement('''
        INSERT INTO ${tjTag.actualTableName} (${tjTag.termBankId.name}, ${tjTag.tagBankId.name})
        SELECT $maxTermBankId + s.term_local_id, t.id
        FROM $workerAlias.term_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.is_definition_tag = 0
        ORDER BY s.rowid
      ''');
      
      await targetDb.customStatement('''
        INSERT INTO ${tjDefTag.actualTableName} (${tjDefTag.termBankId.name}, ${tjDefTag.definitionTagId.name})
        SELECT $maxTermBankId + s.term_local_id, t.id
        FROM $workerAlias.term_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.is_definition_tag = 1
        ORDER BY s.rowid
      ''');

      await targetDb.customStatement('''
        INSERT INTO ${tjRule.actualTableName} (${tjRule.termBankId.name}, ${tjRule.ruleIdentifierId.name})
        SELECT $maxTermBankId + s.term_local_id, r.id
        FROM $workerAlias.term_rule_staging_table s
        JOIN ${tRule.actualTableName} r ON r.rule_identifier = s.rule_id
        ORDER BY s.rowid
      ''');

    }
    catch (e) {
      print("Error during TermBankV3 merge: $e");
      rethrow;
    }
  }
}
