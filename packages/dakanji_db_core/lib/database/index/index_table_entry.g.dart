// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_table_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexEntry _$IndexEntryFromJson(Map<String, dynamic> json) => IndexEntry(
  id: (json['id'] as num).toInt(),
  isDefaultDictionary: const BoolAsIntConverter().fromJson(
    (json['isDefaultDictionary'] as num).toInt(),
  ),
  dictionaryType: $enumDecode(_$DictionaryTypesEnumMap, json['dictionaryType']),
  currentSortingOrder: (json['currentSortingOrder'] as num).toInt(),
  currentFrequencyDictionary: const BoolAsIntConverter().fromJson(
    (json['currentFrequencyDictionary'] as num).toInt(),
  ),
  title: json['title'] as String,
  revision: json['revision'] as String,
  sequenced: const NullableBoolAsIntConverter().fromJson(
    (json['sequenced'] as num?)?.toInt(),
  ),
  format: (json['format'] as num?)?.toInt(),
  version: (json['version'] as num?)?.toInt(),
  author: json['author'] as String?,
  updatable: json['updatable'] as bool?,
  indexUrl: json['indexUrl'] as String?,
  downloadUrl: json['downloadUrl'] as String?,
  url: json['url'] as String?,
  description: json['description'] as String?,
  attribution: json['attribution'] as String?,
  sourceLanguage: json['sourceLanguage'] as String?,
  targetLanguage: json['targetLanguage'] as String?,
  frequencyMode: json['frequencyMode'] as String?,
);

Map<String, dynamic> _$IndexEntryToJson(
  IndexEntry instance,
) => <String, dynamic>{
  'id': instance.id,
  'isDefaultDictionary': const BoolAsIntConverter().toJson(
    instance.isDefaultDictionary,
  ),
  'dictionaryType': _$DictionaryTypesEnumMap[instance.dictionaryType]!,
  'currentSortingOrder': instance.currentSortingOrder,
  'currentFrequencyDictionary': const BoolAsIntConverter().toJson(
    instance.currentFrequencyDictionary,
  ),
  'title': instance.title,
  'revision': instance.revision,
  'sequenced': const NullableBoolAsIntConverter().toJson(instance.sequenced),
  'format': instance.format,
  'version': instance.version,
  'author': instance.author,
  'updatable': instance.updatable,
  'indexUrl': instance.indexUrl,
  'downloadUrl': instance.downloadUrl,
  'url': instance.url,
  'description': instance.description,
  'attribution': instance.attribution,
  'sourceLanguage': instance.sourceLanguage,
  'targetLanguage': instance.targetLanguage,
  'frequencyMode': instance.frequencyMode,
};

const _$DictionaryTypesEnumMap = {
  DictionaryTypes.yomitan: 'yomitan',
  DictionaryTypes.examples: 'examples',
  DictionaryTypes.audio: 'audio',
  DictionaryTypes.grammar: 'grammar',
};
