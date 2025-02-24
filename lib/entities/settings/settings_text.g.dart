// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsText _$SettingsTextFromJson(Map<String, dynamic> json) => SettingsText()
  ..selectionButtonsEnabled = json['selectionButtonsEnabled'] as bool
  ..searchResultSortPriorities =
      (json['searchResultSortPriorities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          ['SettingsScreen.dict_term', 'SettingsScreen.dict_base_form']
  ..selectedSearchResultSortPriorities =
      (json['selectedSearchResultSortPriorities'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
  ..windowWidth = (json['windowWidth'] as num?)?.toInt() ?? 480
  ..windowHeight = (json['windowHeight'] as num?)?.toInt() ?? 720
  ..windowPosX = (json['windowPosX'] as num?)?.toInt() ?? 0
  ..windowPosY = (json['windowPosY'] as num?)?.toInt() ?? 0;

Map<String, dynamic> _$SettingsTextToJson(SettingsText instance) =>
    <String, dynamic>{
      'selectionButtonsEnabled': instance.selectionButtonsEnabled,
      'searchResultSortPriorities': instance.searchResultSortPriorities,
      'selectedSearchResultSortPriorities':
          instance.selectedSearchResultSortPriorities,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'windowPosX': instance.windowPosX,
      'windowPosY': instance.windowPosY,
    };
