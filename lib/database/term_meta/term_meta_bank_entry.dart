// Package imports:
import 'package:dakanji_db/database/term_meta/term_meta_bank_frequency_entry.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_ipa_entry.dart';
import 'package:dakanji_db/database/term_meta/term_meta_bank_pitch_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_entry.freezed.dart';
part 'term_meta_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry of the database
class TermMetaBankV3Entry with _$TermMetaBankV3Entry {

  const factory TermMetaBankV3Entry(
    {
      /// The term of this entry
      required String term,
      /// The type of this entry
      required String type,
      /// The reading of this entry
      String? reading,
      /// Frequency of this entry
      TermMetaBankV3FrequencyEntry? frequency,
      /// Pitch data of this entry
      TermMetaBankV3PitchEntry? pitch,
      /// Ipa transcription data of this entry
      TermMetaBankV3IpaEntry? ipa
    }) = _TermMetaBankV3Entry;

  factory TermMetaBankV3Entry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3EntryFromJson(json);

}
