import "package:da_db/database/audio_source_list/audio_source_list_entry.dart";
import "package:da_db/database/da_db.dart";
import "package:drift/drift.dart";

import "audio_source_list_tables.dart";

part 'audio_source_list_dao.g.dart';



// Dao class that contains all queries related to the `ReadingTable`
@DriftAccessor(tables: [
  AudioSourceListTable
])
class AudioSourceListDao extends DatabaseAccessor<DaDb> with _$AudioSourceListDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  AudioSourceListDao(super.db);

  /// Returns all audio sources
  Future<List<AudioSourceListEntry>> getAllAudioSources() async {

    final rows = await select(audioSourceListTable).get();

    return rows.map((row) =>
      AudioSourceListEntry(name: row.name, uri: row.uri)
    ).toList();

  }

}
