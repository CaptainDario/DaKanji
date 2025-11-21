// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_misc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsMisc _$SettingsMiscFromJson(Map<String, dynamic> json) => SettingsMisc()
  ..selectedStartupScreen = (json['selectedStartupScreen'] as num).toInt()
  ..selectedLocale = json['selectedLocale'] as String
  ..fontSizeScale = (json['fontSizeScale'] as num).toDouble()
  ..selectedTheme = json['selectedTheme'] as String
  ..windowWidth = (json['windowWidth'] as num?)?.toInt() ?? 480
  ..windowHeight = (json['windowHeight'] as num?)?.toInt() ?? 720
  ..windowPosX = (json['windowPosX'] as num?)?.toInt() ?? 0
  ..windowPosY = (json['windowPosY'] as num?)?.toInt() ?? 0
  ..alwaysOnTop = json['alwaysOnTop'] as bool
  ..alwaysSaveWindowSize = json['alwaysSaveWindowSize'] as bool
  ..alwaysSaveWindowPosition = json['alwaysSaveWindowPosition'] as bool
  ..windowOpacity = (json['windowOpacity'] as num).toDouble()
  ..drawerItemOrder =
      (json['drawerItemOrder'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      []
  ..sharingScheme = json['sharingScheme'] as String;

Map<String, dynamic> _$SettingsMiscToJson(SettingsMisc instance) =>
    <String, dynamic>{
      'selectedStartupScreen': instance.selectedStartupScreen,
      'selectedLocale': instance.selectedLocale,
      'fontSizeScale': instance.fontSizeScale,
      'selectedTheme': instance.selectedTheme,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'windowPosX': instance.windowPosX,
      'windowPosY': instance.windowPosY,
      'alwaysOnTop': instance.alwaysOnTop,
      'alwaysSaveWindowSize': instance.alwaysSaveWindowSize,
      'alwaysSaveWindowPosition': instance.alwaysSaveWindowPosition,
      'windowOpacity': instance.windowOpacity,
      'drawerItemOrder': instance.drawerItemOrder,
      'sharingScheme': instance.sharingScheme,
    };
