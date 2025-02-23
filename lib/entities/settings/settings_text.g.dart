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
          [
            'SettingsScreen.dict_term',
            'SettingsScreen.dict_convert_to_kana',
            'SettingsScreen.dict_base_form'
          ]
  ..selectedSearchResultSortPriorities =
      (json['selectedSearchResultSortPriorities'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$SettingsTextToJson(SettingsText instance) =>
    <String, dynamic>{
      'selectionButtonsEnabled': instance.selectionButtonsEnabled,
      'searchResultSortPriorities': instance.searchResultSortPriorities,
      'selectedSearchResultSortPriorities':
          instance.selectedSearchResultSortPriorities,
    };
