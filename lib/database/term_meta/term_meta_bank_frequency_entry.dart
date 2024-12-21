// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_frequency_entry.freezed.dart';
part 'term_meta_bank_frequency_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry's frequency data
class TermMetaBankV3FrequencyEntry with _$TermMetaBankV3FrequencyEntry {

  const factory TermMetaBankV3FrequencyEntry(
    {
      /// the frequency of this entry as a numeric value
      int? frequency,
      /// the frequency of this entry as a string for displaying
      String? frequencyDisplayValue,
    }) = _TermMetaBankV3FrequencyEntry;

  factory TermMetaBankV3FrequencyEntry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3FrequencyEntryFromJson(json);

}
