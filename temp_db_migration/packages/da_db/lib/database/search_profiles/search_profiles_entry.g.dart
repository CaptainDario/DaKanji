// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_profiles_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchProfilesEntry _$SearchProfilesEntryFromJson(Map<String, dynamic> json) =>
    _SearchProfilesEntry(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      isActiveProfile: json['isActiveProfile'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 1,
      firstSortOrder:
          (json['firstSortOrder'] as List<dynamic>?)
              ?.map(
                (e) => _$recordConvert(
                  e,
                  ($jsonValue) => (
                    $enumDecode(
                      _$SearchResult1stSortOrderEnumMap,
                      $jsonValue[r'$1'],
                    ),
                    $jsonValue[r'$2'] as bool,
                  ),
                ),
              )
              .toList() ??
          const [
            (SearchResult1stSortOrder.queryMatch, true),
            (SearchResult1stSortOrder.normalizedMatch, true),
            (SearchResult1stSortOrder.deconjugationMatch, true),
            (SearchResult1stSortOrder.spellfixMatch, true),
          ],
      secondSortOrder:
          (json['secondSortOrder'] as List<dynamic>?)
              ?.map(
                (e) => _$recordConvert(
                  e,
                  ($jsonValue) => (
                    $enumDecode(
                      _$SearchResult2ndSortOrderEnumMap,
                      $jsonValue[r'$1'],
                    ),
                    $jsonValue[r'$2'] as bool,
                  ),
                ),
              )
              .toList() ??
          const [
            (SearchResult2ndSortOrder.exactMatch, true),
            (SearchResult2ndSortOrder.prefixMatch, true),
            (SearchResult2ndSortOrder.subwordMatch, true),
            (SearchResult2ndSortOrder.wildcardMatch, true),
          ],
      normalizeSearchConvertsRomajiToHiragana:
          json['normalizeSearchConvertsRomajiToHiragana'] as bool? ?? true,
      groupingRules:
          (json['groupingRules'] as List<dynamic>?)
              ?.map(
                (e) =>
                    DictionaryGroupingRule.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      showSearchResultSeparationHeaders:
          json['showSearchResultSeparationHeaders'] as bool? ?? true,
      showKanjiEntriesInSearchResults:
          json['showKanjiEntriesInSearchResults'] as bool? ?? true,
      showTags: json['showTags'] as bool? ?? true,
      showMetaEntries: json['showMetaEntries'] as bool? ?? true,
      definitionsMaxHeight:
          (json['definitionsMaxHeight'] as num?)?.toDouble() ?? 60.0,
      definitionsCompactMode: json['definitionsCompactMode'] as bool? ?? true,
      useKatakanaForFurigana: json['useKatakanaForFurigana'] as bool? ?? false,
      spellfixMaxResults: (json['spellfixMaxResults'] as num?)?.toInt() ?? 20,
      spellfixMaxCost: (json['spellfixMaxCost'] as num?)?.toInt() ?? 10,
      searchResultLimit: (json['searchResultLimit'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$SearchProfilesEntryToJson(
  _SearchProfilesEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isActiveProfile': instance.isActiveProfile,
  'sortOrder': instance.sortOrder,
  'firstSortOrder': instance.firstSortOrder
      .map(
        (e) => <String, dynamic>{
          r'$1': _$SearchResult1stSortOrderEnumMap[e.$1]!,
          r'$2': e.$2,
        },
      )
      .toList(),
  'secondSortOrder': instance.secondSortOrder
      .map(
        (e) => <String, dynamic>{
          r'$1': _$SearchResult2ndSortOrderEnumMap[e.$1]!,
          r'$2': e.$2,
        },
      )
      .toList(),
  'normalizeSearchConvertsRomajiToHiragana':
      instance.normalizeSearchConvertsRomajiToHiragana,
  'groupingRules': instance.groupingRules,
  'showSearchResultSeparationHeaders':
      instance.showSearchResultSeparationHeaders,
  'showKanjiEntriesInSearchResults': instance.showKanjiEntriesInSearchResults,
  'showTags': instance.showTags,
  'showMetaEntries': instance.showMetaEntries,
  'definitionsMaxHeight': instance.definitionsMaxHeight,
  'definitionsCompactMode': instance.definitionsCompactMode,
  'useKatakanaForFurigana': instance.useKatakanaForFurigana,
  'spellfixMaxResults': instance.spellfixMaxResults,
  'spellfixMaxCost': instance.spellfixMaxCost,
  'searchResultLimit': instance.searchResultLimit,
};

const _$SearchResult1stSortOrderEnumMap = {
  SearchResult1stSortOrder.queryMatch: 'queryMatch',
  SearchResult1stSortOrder.normalizedMatch: 'normalizedMatch',
  SearchResult1stSortOrder.deconjugationMatch: 'deconjugationMatch',
  SearchResult1stSortOrder.spellfixMatch: 'spellfixMatch',
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);

const _$SearchResult2ndSortOrderEnumMap = {
  SearchResult2ndSortOrder.exactMatch: 'exactMatch',
  SearchResult2ndSortOrder.prefixMatch: 'prefixMatch',
  SearchResult2ndSortOrder.subwordMatch: 'subwordMatch',
  SearchResult2ndSortOrder.wildcardMatch: 'wildcardMatch',
};
