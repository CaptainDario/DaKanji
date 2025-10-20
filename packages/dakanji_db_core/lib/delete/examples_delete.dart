import 'package:dakanji_db_core/database/dakanji_db.dart';



Future deleteExamplesDictionary(DaKanjiDB db, int indexId) async {

  // 1. Find all example IDs for the given indexId
    final exampleIdsQuery = db.select(db.exampleTable, distinct: true)
                            ..where((tbl) => tbl.indexId.equals(indexId));
    final exampleIds = await exampleIdsQuery.map((row) => row.id).get();

  if (exampleIds.isNotEmpty) {
    // 2. Find all translation IDs linked to these examples
    final transIdsQuery = db.select(db.exampleTableXExampleTranslationTable, distinct: true)
                          ..where((tbl) => tbl.exampleId.isIn(exampleIds));
    final translationIds = await transIdsQuery.map((row) => row.translationId).get();

    // 3. Delete from the relation table
    await (db.delete(db.exampleTableXExampleTranslationTable)
          ..where((tbl) => tbl.exampleId.isIn(exampleIds))).go();
    
    // 4. Delete from the translation table
    if (translationIds.isNotEmpty) {
      await (db.delete(db.exampleTranslationTable)
            ..where((tbl) => tbl.id.isIn(translationIds))).go();
    }

    // 5. Delete from the example table
    await (db.delete(db.exampleTable)
          ..where((tbl) => tbl.id.isIn(exampleIds))).go();
  }
}