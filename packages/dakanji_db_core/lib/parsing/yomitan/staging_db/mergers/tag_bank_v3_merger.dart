import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/parsing/yomitan/staging_db/mergers/staging_merger.dart';



class TagBankMerger implements StagingMerger {
  @override
  Future<void> merge({
    required DaKanjiDB targetDb,
    required String workerAlias,
    required int indexId,
  }) async {
    
    const sourceTable = 'tag_staging_table';
    final targetTable = targetDb.tagBankV3Table.actualTableName;

    await targetDb.customStatement('''
      INSERT OR IGNORE INTO $targetTable 
        (index_id, name, category, sorting_order, notes, score)
      SELECT DISTINCT 
        $indexId, 
        tag_name, 
        category, 
        sorting_order, 
        notes, 
        score
      FROM $workerAlias.$sourceTable
    ''');
  }
}