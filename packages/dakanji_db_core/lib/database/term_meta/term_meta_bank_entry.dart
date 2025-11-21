
import 'dart:convert';

import 'package:dakanji_db_core/data/term_meta_entry_types.dart';
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/index/index_table_entry.dart';
import 'package:dakanji_db_core/helper/json_index_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/database/term_meta/term_meta_bank_ipa_entry.dart';
import '/database/term_meta/term_meta_bank_pitch_entry.dart';

part 'term_meta_bank_entry.freezed.dart';
part 'term_meta_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry of the database
abstract class TermMetaBankV3Entry with _$TermMetaBankV3Entry {

  const factory TermMetaBankV3Entry(
    {
      /// The id of this entry in the sqlite database
      required int id,
      /// The index (dictionary) in which this entry was found
      @IndexEntryJsonConverter()
      required IndexEntry indexEntry,
      /// The term of this entry
      required String term,
      /// The type of this entry
      required TermMetaBankEntryTypes type,
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
      id: data.termMetaId,
      indexEntry: IndexEntry.fromJson(jsonDecode(data.indexEntry)),
      term: data.term,
      type: TermMetaBankEntryTypes.values.firstWhere((e) => e.name == data.type),
      reading: data.reading,
      frequency: data.frequency,
      frequencyDisplayValue: data.frequencyDisplayValue,
      pitchs: List<TermMetaBankV3PitchEntry>.from(
        jsonDecode(data.pitchs).map((e) => TermMetaBankV3PitchEntry.fromJson(e))),
      ipas: List<TermMetaBankV3IpaEntry>.from(
        jsonDecode(data.ipas).map((e) => TermMetaBankV3IpaEntry.fromJson(e))),
    );
  }

  factory TermMetaBankV3Entry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3EntryFromJson(json);

}
