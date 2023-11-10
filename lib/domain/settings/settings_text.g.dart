// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsText _$SettingsTextFromJson(Map<String, dynamic> json) => SettingsText()
  ..selectionButtonsEnabled = json['selectionButtonsEnabled'] as bool
  ..openInFullscreen = json['openInFullscreen'] as bool
  ..searchDeconjugate = json['searchDeconjugate'] as bool? ?? true;

Map<String, dynamic> _$SettingsTextToJson(SettingsText instance) =>
    <String, dynamic>{
      'selectionButtonsEnabled': instance.selectionButtonsEnabled,
      'openInFullscreen': instance.openInFullscreen,
      'searchDeconjugate': instance.searchDeconjugate,
    };
