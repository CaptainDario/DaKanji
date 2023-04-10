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
      ..showWordFruequency = json['showWordFruequency'] as bool? ?? false
      ..searchDeconjugate = json['searchDeconjugate'] as bool? ?? true
      ..searchKanaize = json['searchKanaize'] as bool? ?? true;

Map<String, dynamic> _$SettingsDictionaryToJson(SettingsDictionary instance) =>
    <String, dynamic>{
      'translationLanguageCodes': instance.translationLanguageCodes,
      'selectedTranslationLanguages': instance.selectedTranslationLanguages,
      'showWordFruequency': instance.showWordFruequency,
      'searchDeconjugate': instance.searchDeconjugate,
      'searchKanaize': instance.searchKanaize,
    };
