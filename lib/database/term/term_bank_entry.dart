// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:dakanji_db/database/kanji/kanji_bank_entry_stat.dart';
import 'package:dakanji_db/database/tag/tag_bank_entry.dart';

part 'term_bank_entry.freezed.dart';
part 'term_bank_entry.g.dart';



@Freezed(makeCollectionsUnmodifiable: false)
/// Class representing one kanji entry of the database
class TermBankEntry with _$TermBankEntry {

  const factory TermBankEntry(
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
      required List<TagBankEntry> tags
    }) = _TermBankEntry;

  factory TermBankEntry.fromJson(Map<String, Object?> json)
    => _$TermBankEntryFromJson(json);

}
