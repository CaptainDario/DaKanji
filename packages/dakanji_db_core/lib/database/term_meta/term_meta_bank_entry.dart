// Package imports:
import 'dart:convert';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '/database/term_meta/term_meta_bank_ipa_entry.dart';
import '/database/term_meta/term_meta_bank_pitch_entry.dart';

part 'term_meta_bank_entry.freezed.dart';
part 'term_meta_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry of the database
abstract class TermMetaBankV3Entry with _$TermMetaBankV3Entry {

  const factory TermMetaBankV3Entry(
    {
      /// id of this entry's dictionary
      required int indexId,
      /// The term of this entry
      required String term,
      /// The type of this entry
      required String type,
      /// The reading of this entry
      String? reading,
      /// the frequency of this entry as a numeric value
      int? frequency,
      /// the frequency of this entry as a string for displaying
      String? frequencyDisplayValue,
      /// Pitch data of this entry
      required List<TermMetaBankV3PitchEntry> pitchs,
      /// Ipa transcription data of this entry
      required List<TermMetaBankV3IpaEntry> ipas
    }) = _TermMetaBankV3Entry;

  factory TermMetaBankV3Entry.fromTermMetaBankV3EntryViewData(TermMetaBankV3EntryViewData data) {

    return TermMetaBankV3Entry(
      indexId: data.indexId,
      term: data.term,
      type: data.type,
      reading: data.reading,
      frequency: data.frequency,
      frequencyDisplayValue: data.frequencyDisplayValue,
      pitchs: List<TermMetaBankV3PitchEntry>.from(
        jsonDecode(data.pitchs).map((e) => TermMetaBankV3PitchEntry.fromJson(e))),
      ipas: List<TermMetaBankV3IpaEntry>.from(
        jsonDecode(data.ipas).map((e) => TermMetaBankV3IpaEntry.fromJson(e))),
    );
  }

  factory TermMetaBankV3Entry.fromDictionarySearchDrift(DictionarySearchDriftResult r) {

    final metaEntries = jsonDecode(r.termMetaEntries);
    print(metaEntries);

    return TermMetaBankV3Entry.fromJson(metaEntries);
  }

  factory TermMetaBankV3Entry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3EntryFromJson(json);

}
