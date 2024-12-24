// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:dakanji_db/database/tag/tag_bank_v3_entry.dart';

part 'term_bank_v3_entry.freezed.dart';
part 'term_bank_v3_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one kanji entry of the database
class TermBankV3Entry with _$TermBankV3Entry {

  const factory TermBankV3Entry(
    {
      /// 
      required String term,
      /// 
      required String reading,
      ///
      required List<String> definitionTags,
      ///
      required List<String> ruleIdentifiers,
      /// 
      required int popularity,
      /// 
      required List<String>? definitions,
      /// 
      required int sequenceNumber,
      ///
      required List<TagBankV3Entry> tags
    }) = _TermBankV3Entry;

  factory TermBankV3Entry.fromJson(Map<String, Object?> json)
    => _$TermBankV3EntryFromJson(json);

}
