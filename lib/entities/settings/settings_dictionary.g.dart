// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsDictionary _$SettingsDictionaryFromJson(Map<String, dynamic> json) =>
    SettingsDictionary()
      ..translationLanguageCodes =
          (json['translationLanguageCodes'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              ['en', 'de', 'ru', 'it', 'fr', 'es', 'pl']
      ..selectedTranslationLanguages =
          (json['selectedTranslationLanguages'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
      ..showSearchMatchSeparation =
          json['showSearchMatchSeparation'] as bool? ?? false
      ..addToAnkiFromSearchResults =
          json['addToAnkiFromSearchResults'] as bool? ?? false
      ..addToListFromSearchResults =
          json['addToListFromSearchResults'] as bool? ?? false
      ..showWordFruequency = json['showWordFruequency'] as bool? ?? false
      ..searchResultSortPriorities =
          (json['searchResultSortPriorities'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [
                'SettingsScreen.dict_term',
                'SettingsScreen.dict_convert_to_kana',
                'SettingsScreen.dict_base_form'
              ]
      ..selectedSearchResultSortPriorities =
          (json['selectedSearchResultSortPriorities'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
      ..selectedFallingWordsLevels =
          (json['selectedFallingWordsLevels'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              ['N5', 'N4', 'N3']
      ..playKanjiAnimationWhenOpened =
          json['playKanjiAnimationWhenOpened'] as bool? ?? true
      ..limitSearchResults =
          (json['limitSearchResults'] as num?)?.toInt() ?? 100
      ..kanjiAnimationStrokesPerSecond =
          (json['kanjiAnimationStrokesPerSecond'] as num?)?.toDouble() ?? 5.0
      ..resumeAnimationAfterStopSwipe =
          json['resumeAnimationAfterStopSwipe'] as bool? ?? false
      ..googleImageSearchQuery =
          json['googleImageSearchQuery'] as String? ?? '%X%';

Map<String, dynamic> _$SettingsDictionaryToJson(SettingsDictionary instance) =>
    <String, dynamic>{
      'translationLanguageCodes': instance.translationLanguageCodes,
      'selectedTranslationLanguages': instance.selectedTranslationLanguages,
      'showSearchMatchSeparation': instance.showSearchMatchSeparation,
      'addToAnkiFromSearchResults': instance.addToAnkiFromSearchResults,
      'addToListFromSearchResults': instance.addToListFromSearchResults,
      'showWordFruequency': instance.showWordFruequency,
      'searchResultSortPriorities': instance.searchResultSortPriorities,
      'selectedSearchResultSortPriorities':
          instance.selectedSearchResultSortPriorities,
      'selectedFallingWordsLevels': instance.selectedFallingWordsLevels,
      'playKanjiAnimationWhenOpened': instance.playKanjiAnimationWhenOpened,
      'limitSearchResults': instance.limitSearchResults,
      'kanjiAnimationStrokesPerSecond': instance.kanjiAnimationStrokesPerSecond,
      'resumeAnimationAfterStopSwipe': instance.resumeAnimationAfterStopSwipe,
      'googleImageSearchQuery': instance.googleImageSearchQuery,
    };
