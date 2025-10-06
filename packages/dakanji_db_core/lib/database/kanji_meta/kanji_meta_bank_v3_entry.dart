// Package imports:
import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_meta_bank_v3_entry.freezed.dart';
part 'kanji_meta_bank_v3_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one meta entry of the database
abstract class KanjiMetaBankV3Entry with _$KanjiMetaBankV3Entry {

  const factory KanjiMetaBankV3Entry(
    {
      /// The kanji of this entry
      required String kanji,
      /// id of this entry's dictionary
      required int indexId,
      /// The type of this entry
      required String type,
      /// the numeric value of this entry's frequency
      int? freqValue,
      /// The display value of this entry's frequency
      String? freqDisplayValue,
    }) = _KanjiMetaBankV3Entry;

  factory KanjiMetaBankV3Entry.fromKanjiMetaBankV3EntryViewData(KanjiMetaBankV3EntryViewData data) {
    return KanjiMetaBankV3Entry(
      kanji: data.kanji,
      indexId: data.indexId,
      type: data.type,
      freqValue: data.freqValue,
      freqDisplayValue: data.freqDisplayValue,
    );
  }



  factory KanjiMetaBankV3Entry.fromJson(Map<String, Object?> json)
    => _$KanjiMetaBankV3EntryFromJson(json);

}
