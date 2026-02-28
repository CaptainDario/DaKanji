import 'package:da_db/database/da_db.dart';
import 'package:da_db/parsing/staging_db/mergers/staging_merger.dart';

class TagBankMerger implements StagingMerger {
  @override
  Future<void> merge({
    required DaDb targetDb,
    required String workerAlias,
    required int indexId,
  }) async {
    
    const sourceTable = 'tag_staging_table';
    final targetTable = targetDb.tagBankV3Table.actualTableName;

    // use UPSERT here to overwrite any dummy tags that might have 
    // been inserted by term_meta or kanji_meta if they merged first.
    await targetDb.customStatement('''
      INSERT INTO $targetTable 
        (index_id, name, category, sorting_order, notes, score)
      SELECT DISTINCT 
        $indexId, 
        tag_name, 
        category, 
        sorting_order, 
        notes, 
        score
      FROM $workerAlias.$sourceTable
      WHERE 1=1
      ON CONFLICT(name, index_id) DO UPDATE SET 
        category = excluded.category,
        sorting_order = excluded.sorting_order,
        notes = excluded.notes,
        score = excluded.score
      WHERE excluded.category != '' OR excluded.notes != ''
    ''');
  }
}