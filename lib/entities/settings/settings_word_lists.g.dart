// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_word_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsWordLists _$SettingsWordListsFromJson(Map<String, dynamic> json) =>
    SettingsWordLists()
      ..showWordFruequency = json['showWordFruequency'] as bool? ?? false
      ..includedLanguages = (json['includedLanguages'] as List<dynamic>)
          .map((e) => e as bool)
          .toList()
      ..noTranslations = json['noTranslations'] as int;

Map<String, dynamic> _$SettingsWordListsToJson(SettingsWordLists instance) =>
    <String, dynamic>{
      'showWordFruequency': instance.showWordFruequency,
      'includedLanguages': instance.includedLanguages,
      'noTranslations': instance.noTranslations,
    };
