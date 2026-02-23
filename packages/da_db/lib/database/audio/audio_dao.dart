
import "dart:convert";

import "package:da_db/database/audio/audio_entry.dart";
import "package:da_db/database/audio/audio_tables.dart";
import "package:da_db/database/term/term_bank_v3_entry.dart";
import "package:da_db/database/term_meta/term_meta_bank_entry.dart";
import "package:drift/drift.dart";
import 'package:language_processing/language_processing.dart';

import "../da_db.dart";

part 'audio_dao.g.dart';



// Dao class that contains all queries related to the `ReadingTable`
@DriftAccessor(tables: [
  AudioTable
])
class AudioDao extends DatabaseAccessor<DaKanjiDB> with _$AudioDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  AudioDao(super.db);

  /// Search for audio entries matching the given terms, readings, and pitch
  /// accent patterns.
  /// If reading or pitchAccentPattern is null, it will be ignored in the search
  /// ie. all readings or pitch accent patterns will be matched.
  Future<List<AudioEntry>> audioSearch(
    List<({String term, String? reading, int? pitchAccentPattern})> entries
  ) async {

    if (entries.isEmpty) return [];

    // 1. Convert the rich objects to a simple List of Maps
    ProcessorOptions opts = ProcessorOptions();
    final List<Map<String, dynamic>> jsonList = entries.map((e) => {
      'term': db.languageProcessor.normalize(e.term, opts).first,
      'reading': e.reading != null
        ? db.languageProcessor.normalize(e.reading!, opts).first
        : null,
      'pitch': e.pitchAccentPattern,
    }).toList();

    // 2. Execute the SQL (Pass as a JSON string)
    final rows = await db.audio_search_drift(jsonEncode(jsonList)).get();

    // 3. Map result
    return rows.map((row) => AudioEntry.fromAudioEntryViewData(row)).toList();

  }

  /// Get audio data for the given term bank entries.
  Future<List<AudioEntry>> getAudioDataByTermBankEntries(
    List<TermBankV3Entry> entries, List<TermMetaBankV3Entry?> termMetaEntries
  ) async {

    assert(entries.length == termMetaEntries.length);

    List<({String term, String? reading, int? pitchAccentPattern})> searchEntries = [];
    for (int i = 0; i < entries.length; i++) {
      final termEntry = entries[i];
      final termMetaEntry = termMetaEntries[i];

      searchEntries.add((
        term: termEntry.term,
        reading: termMetaEntry?.reading,
        pitchAccentPattern: termMetaEntry?.pitchs.first.position
      ));
    }

    return await audioSearch(searchEntries);

  }
  
  /// Get the maximum id of the media table
  Future<int> maxAudioId() async {
    
    final query = await (selectOnly(audioTable)
        ..addColumns([audioTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(audioTable.id.max()) ?? 0;

  }

}
