import 'package:dakanji_db_core/database/dakanji_db.dart';



Future deleteIndex(DaKanjiDB db, int indexId) async {

  // Start a transaction to ensure all deletions are atomic
  await db.transaction(() async {

    // Delete a Dictionary (Index)
    await (db.delete(db.indexTable)
      ..where((tbl) => tbl.id.equals(indexId)))
      .go();
      
  });

}