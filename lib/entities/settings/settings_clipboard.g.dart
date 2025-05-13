// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_clipboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsClipboard _$SettingsClipboardFromJson(Map<String, dynamic> json) =>
    SettingsClipboard()
      ..searchResultSortPriorities =
          (json['searchResultSortPriorities'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              ['SettingsScreen.dict_term', 'SettingsScreen.dict_base_form']
      ..selectedSearchResultSortPriorities =
          (json['selectedSearchResultSortPriorities'] as List<dynamic>)
              .map((e) => e as String)
              .toList();

Map<String, dynamic> _$SettingsClipboardToJson(SettingsClipboard instance) =>
    <String, dynamic>{
      'searchResultSortPriorities': instance.searchResultSortPriorities,
      'selectedSearchResultSortPriorities':
          instance.selectedSearchResultSortPriorities,
    };
