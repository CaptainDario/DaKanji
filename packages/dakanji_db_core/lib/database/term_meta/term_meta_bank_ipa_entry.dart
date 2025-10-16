
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_ipa_entry.freezed.dart';
part 'term_meta_bank_ipa_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry's pitch data
abstract class TermMetaBankV3IpaEntry with _$TermMetaBankV3IpaEntry {

  const factory TermMetaBankV3IpaEntry(
    {
      /// the ipa transcription of this entry
      required String ipa,
      /// all tags of this pitch entry
      required List<String> tags,
    }) = _TermMetaBankV3IpaEntry;

  factory TermMetaBankV3IpaEntry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3IpaEntryFromJson(json);

}
