// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dakanji_db_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DaKanjiDbSettings _$DaKanjiDbSettingsFromJson(Map<String, dynamic> json) =>
    _DaKanjiDbSettings(
      firstSortOrder:
          (json['firstSortOrder'] as List<dynamic>?)
              ?.map(
                (e) => _$recordConvert(
                  e,
                  ($jsonValue) => (
                    $enumDecode(
                      _$DakanjiDbSearchResult1stSortOrderEnumMap,
                      $jsonValue[r'$1'],
                    ),
                    $jsonValue[r'$2'] as bool,
                  ),
                ),
              )
              .toList() ??
          const [
            (DakanjiDbSearchResult1stSortOrder.queryMatch, true),
            (DakanjiDbSearchResult1stSortOrder.normalizedMatch, true),
            (DakanjiDbSearchResult1stSortOrder.deconjugationMatch, true),
            (DakanjiDbSearchResult1stSortOrder.spellfixMatch, true),
          ],
      secondSortOrder:
          (json['secondSortOrder'] as List<dynamic>?)
              ?.map(
                (e) => _$recordConvert(
                  e,
                  ($jsonValue) => (
                    $enumDecode(
                      _$DakanjiDbSearchReesult2ndSortOrderEnumMap,
                      $jsonValue[r'$1'],
                    ),
                    $jsonValue[r'$2'] as bool,
                  ),
                ),
              )
              .toList() ??
          const [
            (DakanjiDbSearchReesult2ndSortOrder.exactMatch, true),
            (DakanjiDbSearchReesult2ndSortOrder.prefixMatch, true),
            (DakanjiDbSearchReesult2ndSortOrder.subwordMatch, true),
            (DakanjiDbSearchReesult2ndSortOrder.wildcardMatch, true),
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
      showTags: json['showTags'] as bool? ?? true,
      showMetaEntries: json['showMetaEntries'] as bool? ?? true,
      definitionsMaxHeight:
          (json['definitionsMaxHeight'] as num?)?.toDouble() ?? 60.0,
      useKatakanaForFurigana: json['useKatakanaForFurigana'] as bool? ?? false,
      searchResultLimit: (json['searchResultLimit'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$DaKanjiDbSettingsToJson(_DaKanjiDbSettings instance) =>
    <String, dynamic>{
      'firstSortOrder': instance.firstSortOrder
          .map(
            (e) => <String, dynamic>{
              r'$1': _$DakanjiDbSearchResult1stSortOrderEnumMap[e.$1]!,
              r'$2': e.$2,
            },
          )
          .toList(),
      'secondSortOrder': instance.secondSortOrder
          .map(
            (e) => <String, dynamic>{
              r'$1': _$DakanjiDbSearchReesult2ndSortOrderEnumMap[e.$1]!,
              r'$2': e.$2,
            },
          )
          .toList(),
      'normalizeSearchConvertsRomajiToHiragana':
          instance.normalizeSearchConvertsRomajiToHiragana,
      'groupingRules': instance.groupingRules,
      'showSearchResultSeparationHeaders':
          instance.showSearchResultSeparationHeaders,
      'showTags': instance.showTags,
      'showMetaEntries': instance.showMetaEntries,
      'definitionsMaxHeight': instance.definitionsMaxHeight,
      'useKatakanaForFurigana': instance.useKatakanaForFurigana,
      'searchResultLimit': instance.searchResultLimit,
    };

const _$DakanjiDbSearchResult1stSortOrderEnumMap = {
  DakanjiDbSearchResult1stSortOrder.queryMatch: 'queryMatch',
  DakanjiDbSearchResult1stSortOrder.normalizedMatch: 'normalizedMatch',
  DakanjiDbSearchResult1stSortOrder.deconjugationMatch: 'deconjugationMatch',
  DakanjiDbSearchResult1stSortOrder.spellfixMatch: 'spellfixMatch',
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);

const _$DakanjiDbSearchReesult2ndSortOrderEnumMap = {
  DakanjiDbSearchReesult2ndSortOrder.exactMatch: 'exactMatch',
  DakanjiDbSearchReesult2ndSortOrder.prefixMatch: 'prefixMatch',
  DakanjiDbSearchReesult2ndSortOrder.subwordMatch: 'subwordMatch',
  DakanjiDbSearchReesult2ndSortOrder.wildcardMatch: 'wildcardMatch',
};
