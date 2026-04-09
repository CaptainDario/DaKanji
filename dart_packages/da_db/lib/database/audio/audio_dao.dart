import "dart:convert";

import "package:da_db/database/audio/audio_entry.dart";
import "package:da_db/database/audio/audio_tables.dart";
import 'package:da_db/database/da_db.dart';
import "package:da_db/database/term/term_bank_v3_entry.dart";
import "package:da_db/database/term_meta/term_meta_bank_entry.dart";
import "package:drift/drift.dart";
import 'package:language_processing/language_processing.dart';

part 'audio_dao.g.dart';

/// Data Access Object for handling audio-related database queries.
/// 
/// Manages searching for audio files based on term, reading, and pitch pattern 
/// combinations, and linking term bank entries to their corresponding audio.
@DriftAccessor(tables: [AudioTable])
class AudioDao extends DatabaseAccessor<DaDb> with _$AudioDaoMixin {
  AudioDao(super.db);

  /// Searches for audio entries matching specific linguistic criteria.
  ///
  /// Takes a list of [entries] records. Each record must contain a [term].
  /// [reading] and [pitchAccentPattern] are optional; if provided, they act as 
  /// strict filters. If null, the search returns all matches for that term.
  /// 
  /// [pitchAccentPattern] expects the unified "H/L" string format.
  Future<List<AudioEntry>> audioSearch(
    List<({String term, String? reading, String? pitchAccentPattern})> entries
  ) async {
    if (entries.isEmpty) return [];

    final ProcessorOptions opts = const ProcessorOptions();
    
    // Normalize and serialize search parameters into a JSON array for the SQL engine.
    final List<Map<String, dynamic>> jsonList = entries.map((e) => {
      'term': db.languageProcessor.normalize(e.term, opts).first,
      'reading': e.reading != null
        ? db.languageProcessor.normalize(e.reading!, opts).first
        : null,
      'pitch': e.pitchAccentPattern,
    }).toList();

    // Execute the optimized Drift custom query using JSON-based bulk parameter passing.
    final rows = await db.audio_search_drift(jsonEncode(jsonList)).get();

    return rows.map((row) => AudioEntry.fromAudioEntryViewData(row)).toList();
  }

  /// Retrieves audio data associated with specific term bank and metadata entries.
  ///
  /// [entries] and [termMetaEntries] must be of equal length. This method 
  /// extracts the term, reading, and the primary pitch pattern to perform 
  /// a bulk audio search.
  Future<List<AudioEntry>> getAudioDataByTermBankEntries(
    List<TermBankV3Entry> entries, 
    List<TermMetaBankV3Entry?> termMetaEntries
  ) async {
    assert(entries.length == termMetaEntries.length);

    final List<({String term, String? reading, String? pitchAccentPattern})> searchEntries = [];
    
    for (int i = 0; i < entries.length; i++) {
      final termEntry = entries[i];
      final termMetaEntry = termMetaEntries[i];

      searchEntries.add((
        term: termEntry.term,
        reading: termMetaEntry?.reading,
        // Accesses the normalized "H/L" string pattern from the first pitch entry.
        pitchAccentPattern: termMetaEntry?.pitchs.firstOrNull?.position
      ));
    }

    return await audioSearch(searchEntries);
  }
  
  /// Returns the maximum ID currently present in the audio table.
  /// 
  /// Used primarily for maintaining ID uniqueness during staging and batch imports.
  Future<int> maxAudioId() async {
    final query = await (selectOnly(audioTable)
        ..addColumns([audioTable.id.max()]))
      .getSingle();

    return query.read(audioTable.id.max()) ?? 0;
  }
}