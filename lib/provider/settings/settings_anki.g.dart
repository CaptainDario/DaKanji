// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_anki.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsAnki _$SettingsAnkiFromJson(Map<String, dynamic> json) => SettingsAnki()
  ..includeGoogleImage = json['includeGoogleImage'] as bool
  ..includeAudio = json['includeAudio'] as bool? ?? false
  ..includeScreenshot = json['includeScreenshot'] as bool? ?? false;

Map<String, dynamic> _$SettingsAnkiToJson(SettingsAnki instance) =>
    <String, dynamic>{
      'includeGoogleImage': instance.includeGoogleImage,
      'includeAudio': instance.includeAudio,
      'includeScreenshot': instance.includeScreenshot,
    };
