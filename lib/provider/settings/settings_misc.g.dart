// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_misc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsMisc _$SettingsMiscFromJson(Map<String, dynamic> json) => SettingsMisc()
  ..selectedStartupScreen = json['selectedStartupScreen'] as String
  ..windowWidth = json['windowWidth'] as int? ?? 480
  ..windowHeight = json['windowHeight'] as int? ?? 480
  ..selectedTheme = json['selectedTheme'] as String
  ..alwaysOnTop = json['alwaysOnTop'] as bool
  ..windowOpacity = (json['windowOpacity'] as num).toDouble();

Map<String, dynamic> _$SettingsMiscToJson(SettingsMisc instance) =>
    <String, dynamic>{
      'selectedStartupScreen': instance.selectedStartupScreen,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'selectedTheme': instance.selectedTheme,
      'alwaysOnTop': instance.alwaysOnTop,
      'windowOpacity': instance.windowOpacity,
    };
