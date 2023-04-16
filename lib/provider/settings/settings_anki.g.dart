// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_anki.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsAnki _$SettingsAnkiFromJson(Map<String, dynamic> json) => SettingsAnki()
  ..defaultDeck = json['defaultDeck'] as String
  ..noLangsToInclude = json['noLangsToInclude'] as int
  ..noTranslations = json['noTranslations'] as int
  ..includeGoogleImage = json['includeGoogleImage'] as bool
  ..includeAudio = json['includeAudio'] as bool
  ..includeScreenshot = json['includeScreenshot'] as bool;

Map<String, dynamic> _$SettingsAnkiToJson(SettingsAnki instance) =>
    <String, dynamic>{
      'defaultDeck': instance.defaultDeck,
      'noLangsToInclude': instance.noLangsToInclude,
      'noTranslations': instance.noTranslations,
      'includeGoogleImage': instance.includeGoogleImage,
      'includeAudio': instance.includeAudio,
      'includeScreenshot': instance.includeScreenshot,
    };
