import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_bank_entry.freezed.dart';
part 'tag_bank_entry.g.dart';



@Freezed()
/// Class representing one stat of a kanji entry of DaKanjiDB
class TagBankEntry with _$TagBankEntry {

  const factory TagBankEntry(
    {

      /// Tag name.
      required String name,
      /// Categories for the tag.
      required String categories,
      /// Sorting order for the tag.
      required int sortingOrder,
      /// Notes for the tag.
      required String notes,
      /// Score used to determine popularity. Negative values are more rare and
      /// positive values are more frequent. This score is also used to sort search
      /// results.
      required int score,

    }) = _TagBankEntry;

  factory TagBankEntry.fromJson(Map<String, Object?> json)
    => _$TagBankEntryFromJson(json);

}