
import "package:dakanji_db_core/database/audio/audio_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'audio_dao.g.dart';



// Dao class that contains all queries related to the `ReadingTable`
@DriftAccessor(tables: [
  AudioTable
])
class AudioDao extends DatabaseAccessor<DaKanjiDB> with _$AudioDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  AudioDao(super.db);
  
  /// Get the maximum id of the media table
  Future<int> maxAudioId() async {
    
    final query = await (selectOnly(audioTable)
        ..addColumns([audioTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(audioTable.id.max()) ?? 0;

  }

}
