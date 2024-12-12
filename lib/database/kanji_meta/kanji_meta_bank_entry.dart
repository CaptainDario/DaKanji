import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_meta_bank_entry.freezed.dart';
part 'kanji_meta_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one meta entry of the database
class KanjiMetaBankV3Entry with _$KanjiMetaBankV3Entry {

  const factory KanjiMetaBankV3Entry(
    {
      /// The kanji of this entry
      required String kanji,
      /// The type of this entry
      required String type,
      /// the numeric value of thsi entry
      int? value,
      /// The display value of this entry
      String? displayValue,
    }) = _KanjiMetaBankV3Entry;

  factory KanjiMetaBankV3Entry.fromJson(Map<String, Object?> json)
    => _$KanjiMetaBankV3EntryFromJson(json);

}