import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:drift/drift.dart';

import 'staging_merger.dart';

class TermBankV3Merger implements StagingMerger {
  final bool addJsonDefs;

  TermBankV3Merger({required this.addJsonDefs});

  @override
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
  }) async {
    
    // Aggressive optimizations for the MAIN connection during merge
    await targetDb.customStatement('PRAGMA cache_size = -200000;'); // Use 20MB cache
    await targetDb.customStatement('PRAGMA temp_store = MEMORY;'); // Temp tables in RAM

    final maxTermBankId = (await targetDb.termBankV3Dao.maxTermBankV3Id());
    final maxJsonId = addJsonDefs ? (await targetDb.termBankV3Dao.maxTermBankV3DefinitionJsonId()) : 0;

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

      // --- Drop Secondary Indexes ---
      final tablesToOptimize = [
        tMain.actualTableName,
        tjDef.actualTableName,
        tjTag.actualTableName,
        tjDefTag.actualTableName,
        tjRule.actualTableName,
      ];
      
      final droppedIndexes = <String>[];
      
      for (final table in tablesToOptimize) {
        final indexes = await targetDb.customSelect(
          "SELECT name, sql FROM sqlite_master WHERE type = 'index' AND tbl_name = ? AND sql IS NOT NULL",
          variables: [Variable.withString(table)]
        ).get();
        
        for (final row in indexes) {
          final name = row.read<String>('name');
          final sql = row.read<String>('sql');
          // Skip internal auto-indexes and explicit UNIQUE indexes
          if (!name.startsWith('sqlite_autoindex_') && 
              !sql.toUpperCase().contains('CREATE UNIQUE INDEX')) {
             droppedIndexes.add(sql);
             await targetDb.customStatement('DROP INDEX IF EXISTS "$name"');
          }
        }
      }

      // 1. Insert Strings (Resolved set-based)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTerm.actualTableName} (${tTerm.term.name}, ${tTerm.termNormalized.name}, ${tTerm.termTokens.name}, ${tTerm.termTokensNormalized.name})
        SELECT DISTINCT term, term_normalized, term_tokens, term_tokens_normalized 
        FROM $workerAlias.term_staging_table
      ''');

      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (${tReading.reading.name}, ${tReading.readingNormalized.name})
        SELECT DISTINCT reading, reading_normalized 
        FROM $workerAlias.term_staging_table
      ''');

      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tDef.actualTableName} (${tDef.definition.name})
        SELECT DISTINCT definition 
        FROM $workerAlias.term_definition_staging_table
      ''');
      
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTag.actualTableName} (${tTag.indexId.name}, ${tTag.name.name}, ${tTag.category.name}, ${tTag.sortingOrder.name}, ${tTag.notes.name}, ${tTag.score.name})
        SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
        FROM $workerAlias.term_tag_staging_table s
        WHERE NOT EXISTS (
          SELECT 1 FROM ${tTag.actualTableName} t 
          WHERE t.name = s.tag_name AND t.index_id = $indexId
        )
      ''');

      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tRule.actualTableName} (${tRule.ruleIdentifier.name})
        SELECT DISTINCT rule_id 
        FROM $workerAlias.term_rule_staging_table
      ''');

      if (addJsonDefs) {
        await targetDb.customStatement('''
          INSERT INTO ${tJson.actualTableName} (${tJson.id.name}, ${tJson.definitionJson.name})
          SELECT $maxJsonId + local_id, original_json
          FROM $workerAlias.term_staging_table
          WHERE original_json IS NOT NULL
        ''');
      }

      // --- Main Insert ---
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
          ${addJsonDefs ? 'CASE WHEN s.original_json IS NOT NULL THEN $maxJsonId + s.local_id ELSE NULL END' : 'NULL'}
        FROM $workerAlias.term_staging_table s
        JOIN ${tTerm.actualTableName} t ON t.${tTerm.term.name} = s.term
        JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = s.reading
        ORDER BY s.term
      ''');

      // --- Junction Tables ---
      await targetDb.customStatement('''
        INSERT INTO ${tjDef.actualTableName} (${tjDef.termBankId.name}, ${tjDef.definitionId.name})
        SELECT $maxTermBankId + s.term_local_id, d.id
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

      // --- OPTIMIZATION END: Restore Indexes ---
      for (final sql in droppedIndexes) {
         try {
           await targetDb.customStatement(sql);
         }
         catch (e) {
           print("Warning: Failed to restore index: $e");
         }
      }

    }
    finally {
      // Revert PRAGMA if needed, or rely on connection close
    }
  }
}