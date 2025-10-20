import 'package:dakanji_db_core/database/dakanji_db.dart';



Future deleteAudioDictionary(DaKanjiDB db, int indexId) async {

  // 1. Find all audio entries for this indexId
  final audioEntriesToDelete = await (db.select(db.audioTable)
        ..where((tbl) => tbl.indexId.equals(indexId)))
        .get();

  if (audioEntriesToDelete.isNotEmpty) {
    // 2. Get the IDs of the media files they use
    final mediaIdsToDelete = audioEntriesToDelete.map((entry) => entry.mediaId).toList();
    final audioIdsToDelete = audioEntriesToDelete.map((entry) => entry.id).toList();

    await (db.delete(db.mediaTable)
          ..where((tbl) => tbl.id.isIn(mediaIdsToDelete)))
          .go();

    // Deleting this will automatically trigger the cascade
    // and delete all related entries from `AudioTable_X_TermTable`.
    await (db.delete(db.audioTable)
          ..where((tbl) => tbl.id.isIn(audioIdsToDelete)))
          .go();
    }

}