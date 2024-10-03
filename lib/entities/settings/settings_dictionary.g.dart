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
      ..addToAnkiFromSearchResults =
          json['addToAnkiFromSearchResults'] as bool? ?? false
      ..addToListFromSearchResults =
          json['addToListFromSearchResults'] as bool? ?? false
      ..showWordFruequency = json['showWordFruequency'] as bool? ?? false
      ..searchDeconjugate = json['searchDeconjugate'] as bool? ?? true
      ..convertToHiragana = json['convertToHiragana'] as bool? ?? true
      ..selectedFallingWordsLevels =
          (json['selectedFallingWordsLevels'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              ['N5', 'N4', 'N3']
      ..playKanjiAnimationWhenOpened =
          json['playKanjiAnimationWhenOpened'] as bool? ?? true
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
      'addToAnkiFromSearchResults': instance.addToAnkiFromSearchResults,
      'addToListFromSearchResults': instance.addToListFromSearchResults,
      'showWordFruequency': instance.showWordFruequency,
      'searchDeconjugate': instance.searchDeconjugate,
      'convertToHiragana': instance.convertToHiragana,
      'selectedFallingWordsLevels': instance.selectedFallingWordsLevels,
      'playKanjiAnimationWhenOpened': instance.playKanjiAnimationWhenOpened,
      'kanjiAnimationStrokesPerSecond': instance.kanjiAnimationStrokesPerSecond,
      'resumeAnimationAfterStopSwipe': instance.resumeAnimationAfterStopSwipe,
      'googleImageSearchQuery': instance.googleImageSearchQuery,
    };
