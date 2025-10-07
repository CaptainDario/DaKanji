import 'dart:convert';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/kanji/kanji_bank_v3_entry.dart';
import 'package:dakanji_db_core/database/kanji_meta/kanji_meta_bank_v3_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanji_dictionary_search_result.freezed.dart';
part 'kanji_dictionary_search_result.g.dart';



/// Class representing one search result entry of the kanji dictionary search
@Freezed()
@JsonSerializable()
class KanjiDictionarySearchResult with _$KanjiDictionarySearchResult {

  @override
  /// List of kanji bank entries found for the search
  KanjiBankV3Entry kanjiBankEntry;
  @override
  /// List of lists of kanji meta bank entries, each list corresponds to one
  /// kanji bank entry of [kanjiBankEntry]
  List<KanjiMetaBankV3Entry> kanjiMetaBankEntry;


  KanjiDictionarySearchResult({
    required this.kanjiBankEntry,
    required this.kanjiMetaBankEntry,
  });

  factory KanjiDictionarySearchResult.fromKanjiDictionarySearchViewData(KanjiDictionarySearchViewData data){
    
    return KanjiDictionarySearchResult(
      kanjiBankEntry: KanjiBankV3Entry.fromKanjiDictionarySearchViewData(data),
      kanjiMetaBankEntry: (jsonDecode(data.kanjiMetaBankV3Entries) as List)
        .map((e) => KanjiMetaBankV3Entry.fromJson(e))
        .toList()
    );
  }

  factory KanjiDictionarySearchResult.fromJson(Map<String, Object?> json)
    => _$KanjiDictionarySearchResultFromJson(json);

  Map<String, Object?> toJson() => _$KanjiDictionarySearchResultToJson(this);

}