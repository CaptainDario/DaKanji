import "dart:convert";

import "package:da_db/database/audio_source_list/audio_source_list_entry.dart";
import "package:da_db/database/da_db.dart";
import "package:da_db/database/index/index_table_entry.dart";
import "package:drift/drift.dart";

import "audio_source_list_tables.dart";

part 'audio_source_list_dao.g.dart';



// Dao class that contains all queries related to the `ReadingTable`
@DriftAccessor(
  tables: [
    AudioSourceListTable
  ],
)
class AudioSourceListDao extends DatabaseAccessor<DaDb> with _$AudioSourceListDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  AudioSourceListDao(super.db);

  /// Returns all audio sources
  Future<List<AudioSourceListEntry>> getAllAudioSources() async {
    // 1. Join the table and the view
    final query = select(audioSourceListTable).join([
      innerJoin(
        db.indexEntryAsJsonView,
        db.indexEntryAsJsonView.id.equalsExp(audioSourceListTable.indexId),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      // 2. Read the table data for the base audio source info
      final sourceRow = row.readTable(audioSourceListTable);
      
      // 3. Read the JSON string from the view column
      final String? jsonString = row.read(db.indexEntryAsJsonView.indexEntry);
      
      // 4. Parse the JSON into your IndexEntry class
      final indexEntry = IndexEntry.fromJson(jsonDecode(jsonString!));

      // 5. Construct your Freezed class
      return AudioSourceListEntry(
        id: sourceRow.id,
        name: sourceRow.name,
        uri: sourceRow.uri,
        indexEntry: indexEntry,
      );
    }).toList();
  }

}
