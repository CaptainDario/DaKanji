import 'package:dakanji_db/database/kanji/kanji_bank_entry_stat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_bank_entry.freezed.dart';
part 'kanji_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one kanji entry of the database
class KanjiBankEntry with _$KanjiBankEntry {

  const factory KanjiBankEntry(
    {
      /// The kanji character of this entry
      required String kanji,
      /// The onyomi readings of this entry
      required List<String>? onyomis,
      /// The kunyomi readings of this entry
      required List<String>? kunyomis,
      /// The tags of this entry
      required List<String>? tags,
      /// The meanings of this entry
      required List<String>? meanings,
      /// The stats of this entry
      required List<KanjiBankEntryStat>? stats
    }) = _KanjiBankEntry;

  factory KanjiBankEntry.fromJson(Map<String, Object?> json)
    => _$KanjiBankEntryFromJson(json);

}