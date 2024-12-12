import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_meta_bank_entry.freezed.dart';
part 'kanji_meta_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one meta entry of the database
class KanjiMetaBankEntry with _$KanjiMetaBankEntry {

  const factory KanjiMetaBankEntry(
    {
      /// The term of this entry
      required String term,
      /// The category of this entry
      required String category,
      /// the numeric value of thsi entry
      int? value,
      /// The display value of this entry
      String? displayValue,
    }) = _KanjiMetaBankEntry;

  factory KanjiMetaBankEntry.fromJson(Map<String, Object?> json)
    => _$KanjiMetaBankEntryFromJson(json);

}