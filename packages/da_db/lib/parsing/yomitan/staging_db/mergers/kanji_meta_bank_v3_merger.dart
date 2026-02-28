import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';

class KanjiMetaBankV3Merger implements StagingMerger {
  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required int indexId,
  }) async {

    final tKanji = targetDb.kanjiTable;
    final tType = targetDb.kanjiMetaBankV3TypeTable;
    final tMain = targetDb.kanjiMetaBankV3Table;

    try {
      // 1. Insert New Kanjis
      await targetDb.customStatement('''
        INSERT OR IGNORE INTO ${tKanji.actualTableName} (${tKanji.kanji.name})
        SELECT DISTINCT kanji FROM $workerAlias.kanji_meta_staging_table
      ''');

      // 2. Insert New Types (Manual ID Generation)
      // Since 'id' is not AUTOINCREMENT in the schema, must generate it.
      final currentMaxTypeId = await targetDb.kanjiMetaBankV3Dao.maxKanjiMetaBankV3TypeId();
      
      await targetDb.customStatement('''
        INSERT INTO ${tType.actualTableName} (${tType.id.name}, ${tType.type.name})
        SELECT 
          $currentMaxTypeId + ROW_NUMBER() OVER (ORDER BY s.type), 
          s.type
        FROM (
          SELECT DISTINCT type FROM $workerAlias.kanji_meta_staging_table
          EXCEPT 
          SELECT type FROM ${tType.actualTableName}
        ) s
      ''');

      // 3. Insert Main Entries
      // Note: The Main Table ID is auto-incrementing, so no need to manually set it
      // unless we want to strictly preserve insertion order from staging.
      await targetDb.customStatement('''
        INSERT INTO ${tMain.actualTableName} (
          ${tMain.indexId.name}, ${tMain.kanjiId.name}, ${tMain.typeId.name}, 
          ${tMain.freqValue.name}, ${tMain.freqDisplayValue.name}
        )
        SELECT 
          $indexId,
          k.${tKanji.id.name},
          t.${tType.id.name},
          s.freq_value,
          s.freq_display_value
        FROM $workerAlias.kanji_meta_staging_table s
        JOIN ${tKanji.actualTableName} k ON k.${tKanji.kanji.name} = s.kanji
        JOIN ${tType.actualTableName} t ON t.${tType.type.name} = s.type
      ''');

    }
    catch (e) {
      print("Error merging Kanji Meta Bank: $e");
      rethrow;
    }
  }
}