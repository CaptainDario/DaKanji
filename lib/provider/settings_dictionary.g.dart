// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsDictionary _$SettingsDictionaryFromJson(Map<String, dynamic> json) =>
    SettingsDictionary()
      ..selectedTranslationLanguages =
          (json['selectedTranslationLanguages'] as List<dynamic>)
              .map((e) => e as String)
              .toList();

Map<String, dynamic> _$SettingsDictionaryToJson(SettingsDictionary instance) =>
    <String, dynamic>{
      'selectedTranslationLanguages': instance.selectedTranslationLanguages,
    };
