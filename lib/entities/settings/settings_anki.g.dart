// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_anki.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsAnki _$SettingsAnkiFromJson(Map<String, dynamic> json) => SettingsAnki()
  ..defaultDeck = json['defaultDeck'] as String?
  ..includedLanguages = (json['includedLanguages'] as List<dynamic>)
      .map((e) => e as bool)
      .toList()
  ..noTranslations = (json['noTranslations'] as num).toInt()
  ..desktopAnkiURL = json['desktopAnkiURL'] as String
  ..noExamples = (json['noExamples'] as num).toInt()
  ..includeExampleTranslations = json['includeExampleTranslations'] as bool
  ..includeGoogleImage = json['includeGoogleImage'] as bool
  ..includeAudio = json['includeAudio'] as bool
  ..includeScreenshot = json['includeScreenshot'] as bool;

Map<String, dynamic> _$SettingsAnkiToJson(SettingsAnki instance) =>
    <String, dynamic>{
      'defaultDeck': instance.defaultDeck,
      'includedLanguages': instance.includedLanguages,
      'noTranslations': instance.noTranslations,
      'desktopAnkiURL': instance.desktopAnkiURL,
      'noExamples': instance.noExamples,
      'includeExampleTranslations': instance.includeExampleTranslations,
      'includeGoogleImage': instance.includeGoogleImage,
      'includeAudio': instance.includeAudio,
      'includeScreenshot': instance.includeScreenshot,
    };
