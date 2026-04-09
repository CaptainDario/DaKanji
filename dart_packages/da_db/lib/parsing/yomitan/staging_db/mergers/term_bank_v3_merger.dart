// Dart imports:
import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/index/yomitan_index.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';
import 'package:language_processing/language_processing.dart';

class TermBankV3Merger implements StagingMerger {

  TermBankV3Merger();

  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required YomitanIndex index,
    required int indexId,
  }) async {

    final bool isSourceSpaceLang = usesSpaceSeparation(index.sourceLanguage);
    final bool isTargetSpaceLang = usesSpaceSeparation(index.targetLanguage);

    final String ftsTermsTable = isSourceSpaceLang ? "fts_terms_unicode" : "fts_terms";
    final String ftsReadingsTable = isSourceSpaceLang ? "fts_readings_unicode" : "fts_readings";
    final String ftsDefsTable = isTargetSpaceLang ? "fts_definitions_unicode" : "fts_definitions";

    final maxTermBankId = (await targetDb.termBankV3Dao.maxTermBankV3Id());
    final maxTermId = await targetDb.termDao.maxTermId();
    final maxReadingId = await targetDb.readingDao.maxReadingId(); 
    final maxDefinitionId = await targetDb.definitionDao.maxDefinitionId();

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
      await targetDb.customStatement('''
        INSERT INTO $ftsTermsTable(rowid, term, term_normalized)
        SELECT id, term, term_normalized 
        FROM ${tTerm.actualTableName} 
        WHERE id > $maxTermId
      ''');

      // Readings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (${tReading.reading.name}, ${tReading.readingNormalized.name})
        SELECT DISTINCT reading, reading_normalized 
        FROM $workerAlias.term_staging_table
      ''');
      await targetDb.customStatement('''
        INSERT INTO $ftsReadingsTable(rowid, reading, reading_normalized)
        SELECT id, reading, reading_normalized 
        FROM ${tReading.actualTableName} 
        WHERE id > $maxReadingId
      ''');

      // Definitions (Simple)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tDef.actualTableName} (${tDef.definition.name})
        SELECT DISTINCT definition 
        FROM $workerAlias.term_definition_staging_table
      ''');
      await targetDb.customStatement('''
        INSERT INTO $ftsDefsTable(rowid, definition)
        SELECT id, definition 
        FROM ${tDef.actualTableName} 
        WHERE id > $maxDefinitionId
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
      
      // 1. Definition Junction
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tjDef.actualTableName} (
            ${tjDef.termBankId.name}, 
            ${tjDef.definitionId.name}, 
            ${tjDef.rank.name}
        )
        SELECT 
            $maxTermBankId + s.term_local_id, 
            d.id, 
            s.rank
        FROM $workerAlias.term_definition_staging_table s
        JOIN ${tDef.actualTableName} d ON d.${tDef.definition.name} = s.definition
        ORDER BY s.rowid
      ''');

      // 2. Tag Junction
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tjTag.actualTableName} (${tjTag.termBankId.name}, ${tjTag.tagBankId.name})
        SELECT $maxTermBankId + s.term_local_id, t.id
        FROM $workerAlias.term_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.is_definition_tag = 0
        ORDER BY s.rowid
      ''');
      
      // 3. Definition Tag Junction
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tjDefTag.actualTableName} (${tjDefTag.termBankId.name}, ${tjDefTag.definitionTagId.name})
        SELECT $maxTermBankId + s.term_local_id, t.id
        FROM $workerAlias.term_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
        WHERE s.is_definition_tag = 1
        ORDER BY s.rowid
      ''');

      // 4. Rule Junction
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tjRule.actualTableName} (${tjRule.termBankId.name}, ${tjRule.ruleIdentifierId.name})
        SELECT $maxTermBankId + s.term_local_id, r.id
        FROM $workerAlias.term_rule_staging_table s
        JOIN ${tRule.actualTableName} r ON r.${tRule.ruleIdentifier.name} = s.rule_id
        ORDER BY s.rowid
      ''');

    }
    catch (e) {
      print("Error during TermBankV3 merge: $e");
      rethrow;
    }
  }
}
