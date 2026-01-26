import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/delete/index_delete.dart';



Future<void> deleteAudioDictionary(DaKanjiDB db, int indexId) async {
  // Run inside a transaction to ensure atomicity (all or nothing)
  await db.transaction(() async {
    
    // 1. Find all audio entries for this indexId
    final audioEntriesToDelete = await (db.select(db.audioTable)
      ..where((tbl) => tbl.indexId.equals(indexId)))
      .get();

    if (audioEntriesToDelete.isNotEmpty) {
      // 2. Capture IDs before deletion
      final mediaIdsToDelete = audioEntriesToDelete.map((e) => e.mediaId).toList();
      final audioIdsToDelete = audioEntriesToDelete.map((e) => e.id).toList();

      // 3. Delete Audio Entries FIRST
      // (Prevents FK constraint errors if Audio references Media)
      // This will also trigger the cascade for `AudioTable_X_TermTable`
      await (db.delete(db.audioTable)
        ..where((tbl) => tbl.id.isIn(audioIdsToDelete)))
        .go();

      // 4. Delete the associated Media files
      await (db.delete(db.mediaTable)
        ..where((tbl) => tbl.id.isIn(mediaIdsToDelete)))
        .go();
    }

    // 5. Finally, delete the IndexTable entry
    await deleteIndex(db, indexId);
      
  });
}