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
  ..noTranslations = json['noTranslations'] as int
  ..desktopAnkiURL = json['desktopAnkiURL'] as String
  ..includeGoogleImage = json['includeGoogleImage'] as bool
  ..includeAudio = json['includeAudio'] as bool
  ..includeScreenshot = json['includeScreenshot'] as bool;

Map<String, dynamic> _$SettingsAnkiToJson(SettingsAnki instance) =>
    <String, dynamic>{
      'defaultDeck': instance.defaultDeck,
      'includedLanguages': instance.includedLanguages,
      'noTranslations': instance.noTranslations,
      'desktopAnkiURL': instance.desktopAnkiURL,
      'includeGoogleImage': instance.includeGoogleImage,
      'includeAudio': instance.includeAudio,
      'includeScreenshot': instance.includeScreenshot,
    };
