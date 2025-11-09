
import 'package:dakanji_db_core/database/tag/tag_bank_v3_entry.dart';
import 'package:dakanji_db_core/helper/json_tag_bank_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_pitch_entry.freezed.dart';
part 'term_meta_bank_pitch_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one term meta entry's pitch data
abstract class TermMetaBankV3PitchEntry with _$TermMetaBankV3PitchEntry {

  const factory TermMetaBankV3PitchEntry(
    {
      /// the position of this pitch entry
      required int position,
      /// all tags of this pitch entry
      @TagBankV3EntryConverter()
      @Default([])
      List<TagBankV3Entry> tags,
      /// nasal data of this pitch entry
      int? nasal,
      /// devoice data of this pitch entry
      int? devoice
    }) = _TermMetaBankV3PitchEntry;

  factory TermMetaBankV3PitchEntry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3PitchEntryFromJson(json);

}
