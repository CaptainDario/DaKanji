// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lists_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordListsData _$WordListsDataFromJson(Map<String, dynamic> json) =>
    WordListsData(
      json['name'] as String,
      $enumDecode(_$WordListNodeTypeEnumMap, json['type']),
      (json['wordIds'] as List<dynamic>).map((e) => e as int).toList(),
      json['isExpanded'] as bool,
    )..isChecked = json['isChecked'] as bool;

Map<String, dynamic> _$WordListsDataToJson(WordListsData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$WordListNodeTypeEnumMap[instance.type]!,
      'wordIds': instance.wordIds,
      'isExpanded': instance.isExpanded,
      'isChecked': instance.isChecked,
    };

const _$WordListNodeTypeEnumMap = {
  WordListNodeType.folder: 'folder',
  WordListNodeType.folderDefault: 'folderDefault',
  WordListNodeType.wordList: 'wordList',
  WordListNodeType.wordListDefault: 'wordListDefault',
  WordListNodeType.root: 'root',
};
