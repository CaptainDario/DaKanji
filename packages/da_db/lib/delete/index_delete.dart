import 'package:da_db/database/da_db.dart';



Future deleteIndex(DaDb db, int indexId) async {

  // Start a transaction to ensure all deletions are atomic
  await db.transaction(() async {

    // Delete a Dictionary (Index)
    await (db.delete(db.indexTable)
      ..where((tbl) => tbl.id.equals(indexId)))
      .go();
      
  });

}