
import "package:dakanji_db_core/database/audio/audio_entry.dart";
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

  /// Search for audio entries matching the given term.
  Future<List<AudioEntry>> audioSearch(String term) async {

    final results = (await db.audio_search_drift(term).get())
      .map((e) => AudioEntry.fromAudioEntryViewData(e))
      .toList();
    
    return results;

  }

  /// Get audio data for the given term bank entries.
  //Future<List<Uint8List>> getAudioDataByTermBankEntries(List<TermBankV3Entry> entries) async {



  //}
  
  /// Get the maximum id of the media table
  Future<int> maxAudioId() async {
    
    final query = await (selectOnly(audioTable)
        ..addColumns([audioTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(audioTable.id.max()) ?? 0;

  }

}
