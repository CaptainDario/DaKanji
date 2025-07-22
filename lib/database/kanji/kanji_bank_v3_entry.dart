// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:dakanji_db/database/kanji/kanji_bank_v3_entry_stat.dart';
import 'package:dakanji_db/database/tag/tag_bank_v3_entry.dart';

part 'kanji_bank_v3_entry.freezed.dart';
part 'kanji_bank_v3_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one kanji entry of the database
abstract class KanjiBankV3Entry with _$KanjiBankV3Entry {

  const factory KanjiBankV3Entry(
    {
      /// The kanji character of this entry
      required String kanji,
      /// The onyomi readings of this entry
      required List<String>? onyomis,
      /// The kunyomi readings of this entry
      required List<String>? kunyomis,
      /// The tags of this entry
      required List<TagBankV3Entry>? tags,
      /// The meanings of this entry
      required List<String>? meanings,
      /// The stats of this entry
      required List<KanjiBankV3EntryStat>? stats
    }) = _KanjiBankV3Entry;

  factory KanjiBankV3Entry.fromJson(Map<String, Object?> json)
    => _$KanjiBankV3EntryFromJson(json);

}
