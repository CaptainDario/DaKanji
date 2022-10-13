// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_misc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsMisc _$SettingsMiscFromJson(Map<String, dynamic> json) => SettingsMisc()
  ..selectedStartupScreen = json['selectedStartupScreen'] as String
  ..windowWidth = json['windowWidth'] as int
  ..windowHeight = json['windowHeight'] as int
  ..selectedTheme = json['selectedTheme'] as String;

Map<String, dynamic> _$SettingsMiscToJson(SettingsMisc instance) =>
    <String, dynamic>{
      'selectedStartupScreen': instance.selectedStartupScreen,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'selectedTheme': instance.selectedTheme,
    };
