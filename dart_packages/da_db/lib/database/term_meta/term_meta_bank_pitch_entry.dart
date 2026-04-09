
import 'package:da_db/database/tag/tag_bank_v3_entry.dart';
import 'package:da_db/util/data_converters/json_tag_bank_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_meta_bank_pitch_entry.freezed.dart';
part 'term_meta_bank_pitch_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
@JsonSerializable()
/// Class representing one term meta entry's pitch data
class TermMetaBankV3PitchEntry with _$TermMetaBankV3PitchEntry {

  /// the position of this pitch entry
  @override
  String position;
  /// all tags of this pitch entry
  @TagBankV3EntryConverter()
  @Default([])
  @override
  List<TagBankV3Entry> tags;
  /// nasal data of this pitch entry
  @override
  List<int>? nasal;
  /// devoice data of this pitch entry
  @override
  List<int>? devoice;

  TermMetaBankV3PitchEntry(
    {
      required this.position,
      this.tags = const [],
      this.nasal,
      this.devoice
    }){
      tags = List.from(tags)..sort((a, b) => a.compareTo(b));
    }

  factory TermMetaBankV3PitchEntry.fromJson(Map<String, Object?> json)
    => _$TermMetaBankV3PitchEntryFromJson(json);

}
