// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_dictionary_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanjiDictionarySearchResult _$KanjiDictionarySearchResultFromJson(
  Map<String, dynamic> json,
) => KanjiDictionarySearchResult(
  kanjiBankEntry: KanjiBankV3Entry.fromJson(
    json['kanjiBankEntry'] as Map<String, dynamic>,
  ),
  kanjiMetaBankEntries: (json['kanjiMetaBankEntries'] as List<dynamic>)
      .map((e) => KanjiMetaBankV3Entry.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$KanjiDictionarySearchResultToJson(
  KanjiDictionarySearchResult instance,
) => <String, dynamic>{
  'kanjiBankEntry': instance.kanjiBankEntry,
  'kanjiMetaBankEntries': instance.kanjiMetaBankEntries,
};
