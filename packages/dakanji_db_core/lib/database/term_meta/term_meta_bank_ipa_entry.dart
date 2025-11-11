
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_core/helper/json_tag_bank_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_ipa_entry.freezed.dart';
part 'term_meta_bank_ipa_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one term meta entry's pitch data
class TermMetaBankV3IpaEntry with _$TermMetaBankV3IpaEntry {

  /// the ipa transcription of this entry
  @override
  String ipa;
  /// all tags of this pitch entry
  @TagBankV3EntryConverter()
  @Default([])
  @override
  List<TagBankV3Entry> tags;

  TermMetaBankV3IpaEntry(
    {
      /// the ipa transcription of this entry
      required this.ipa,
      this.tags = const [],
    }) {
      tags = List.from(tags)..sort((a, b) => a.compareTo(b));
    }

  factory TermMetaBankV3IpaEntry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3IpaEntryFromJson(json);

  Map<String, Object?> toJson() => _$TermMetaBankV3IpaEntryToJson(this);

}
