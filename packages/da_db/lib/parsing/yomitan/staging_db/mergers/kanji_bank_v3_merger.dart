import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/yomitan/staging_db/mergers/staging_merger.dart';

class KanjiBankV3Merger implements StagingMerger {
  @override
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
  }) async {

    // 1. Fetch IDs
    final maxKanjiBankId = await targetDb.kanjiBankV3Dao.maxKanjiId();
    final maxStatId = await targetDb.kanjiBankV3Dao.maxStatsId();

    // Table Shortcuts
    final tKanji = targetDb.kanjiTable;
    final tReading = targetDb.readingTable;
    final tDef = targetDb.definitionTable;
    final tTag = targetDb.tagBankV3Table;
    final tStat = targetDb.kanjiBankV3StatsTable;
    
    final tMain = targetDb.kanjiBankV3Table;
    
    final tjOnyomi = targetDb.kanjiBankV3XOnyomiReadingTable;
    final tjKunyomi = targetDb.kanjiBankV3XKunyomiReadingTable;
    final tjDef = targetDb.kanjiBankV3XDefinitionTable;
    final tjTag = targetDb.kanjiBankV3XTagBankV3Table;
  
    try {
      // --- 1. Insert Core Entities (Distinct) ---
      
      // Kanji Strings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tKanji.actualTableName} (${tKanji.kanji.name})
        SELECT DISTINCT kanji FROM $workerAlias.kanji_staging_table
      ''');

      // Readings
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tReading.actualTableName} (${tReading.reading.name}, ${tReading.readingNormalized.name})
        SELECT DISTINCT reading, reading_normalized FROM $workerAlias.kanji_reading_staging_table
      ''');

      // Definitions
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tDef.actualTableName} (${tDef.definition.name})
        SELECT DISTINCT definition FROM $workerAlias.kanji_definition_staging_table
      ''');

      // Tags (From Tag Staging)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTag.actualTableName} (${tTag.indexId.name}, ${tTag.name.name}, ${tTag.category.name}, ${tTag.sortingOrder.name}, ${tTag.notes.name}, ${tTag.score.name})
        SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
        FROM $workerAlias.kanji_tag_staging_table s
        WHERE NOT EXISTS (SELECT 1 FROM ${tTag.actualTableName} t WHERE t.name = s.tag_name AND t.index_id = $indexId)
      ''');
      
      // Tags (From Stats Staging - Stats keys are also tags)
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tTag.actualTableName} (${tTag.indexId.name}, ${tTag.name.name}, ${tTag.category.name}, ${tTag.sortingOrder.name}, ${tTag.notes.name}, ${tTag.score.name})
        SELECT DISTINCT $indexId, tag_name, '', 0, '', 0 
        FROM $workerAlias.kanji_stat_staging_table s
        WHERE NOT EXISTS (SELECT 1 FROM ${tTag.actualTableName} t WHERE t.name = s.tag_name AND t.index_id = $indexId)
      ''');

      // --- 2. Insert Main Kanji Bank Entry ---
      await targetDb.customStatement('''
        INSERT INTO ${tMain.actualTableName} (
          ${tMain.id.name}, ${tMain.indexId.name}, ${tMain.kanjiId.name}, 
          ${tMain.onyomiOrder.name}, ${tMain.kunyomiOrder.name}, ${tMain.definitionOrder.name}
        )
        SELECT 
          $maxKanjiBankId + s.local_id,
          $indexId,
          k.${tKanji.id.name},
          '[]', '[]', '[]' 
        FROM $workerAlias.kanji_staging_table s
        JOIN ${tKanji.actualTableName} k ON k.${tKanji.kanji.name} = s.kanji
      ''');

      // --- 3. Junction Tables ---

      // Onyomi Junction
      await targetDb.customStatement('''
        INSERT INTO ${tjOnyomi.actualTableName} (${tjOnyomi.kanjiId.name}, ${tjOnyomi.onyomiReadingId.name})
        SELECT $maxKanjiBankId + s.kanji_local_id, r.id
        FROM $workerAlias.kanji_reading_staging_table s
        JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = s.reading
        WHERE s.type = 'onyomi'
        ORDER BY s.position
      ''');

      // Kunyomi Junction
      await targetDb.customStatement('''
        INSERT INTO ${tjKunyomi.actualTableName} (${tjKunyomi.kanjiId.name}, ${tjKunyomi.kunyomiReadingId.name})
        SELECT $maxKanjiBankId + s.kanji_local_id, r.id
        FROM $workerAlias.kanji_reading_staging_table s
        JOIN ${tReading.actualTableName} r ON r.${tReading.reading.name} = s.reading
        WHERE s.type = 'kunyomi'
        ORDER BY s.position
      ''');

      // Tag Junction
      await targetDb.customStatement('''
        INSERT INTO ${tjTag.actualTableName} (${tjTag.kanjiId.name}, ${tjTag.tagId.name})
        SELECT $maxKanjiBankId + s.kanji_local_id, t.id
        FROM $workerAlias.kanji_tag_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
      ''');

      // Definition Junction
      await targetDb.customStatement('''
        INSERT INTO ${tjDef.actualTableName} (${tjDef.kanjiId.name}, ${tjDef.definitionId.name})
        SELECT $maxKanjiBankId + s.kanji_local_id, d.id
        FROM $workerAlias.kanji_definition_staging_table s
        JOIN ${tDef.actualTableName} d ON d.${tDef.definition.name} = s.definition
        ORDER BY s.position
      ''');

      // Stats Table (Direct Insert)
      await targetDb.customStatement('''
        INSERT INTO ${tStat.actualTableName} (${tStat.id.name}, ${tStat.kanjiBankEntryId.name}, ${tStat.statTagId.name}, ${tStat.statValue.name})
        SELECT 
           $maxStatId + ROW_NUMBER() OVER (ORDER BY s.kanji_local_id),
           $maxKanjiBankId + s.kanji_local_id,
           t.id,
           s.value
        FROM $workerAlias.kanji_stat_staging_table s
        JOIN ${tTag.actualTableName} t ON t.name = s.tag_name AND t.index_id = $indexId
      ''');

    }
    catch (e) {
      print("Error merging Kanji Bank: $e");
      rethrow;
    }
  }
}