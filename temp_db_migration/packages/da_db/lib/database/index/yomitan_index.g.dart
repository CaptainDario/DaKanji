// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yomitan_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YomitanIndex _$YomitanIndexFromJson(Map<String, dynamic> json) => YomitanIndex(
  title: json['title'] as String,
  revision: json['revision'] as String,
  sequenced: const FlexibleNullableBoolConverter().fromJson(json['sequenced']),
  format: (json['format'] as num?)?.toInt(),
  version: (json['version'] as num?)?.toInt(),
  author: json['author'] as String?,
  isUpdatable: const FlexibleNullableBoolConverter().fromJson(
    json['isUpdatable'],
  ),
  indexUrl: json['indexUrl'] as String?,
  downloadUrl: json['downloadUrl'] as String?,
  url: json['url'] as String?,
  description: json['description'] as String?,
  attribution: json['attribution'] as String?,
  sourceLanguage: const Iso6393Converter().fromJson(
    json['sourceLanguage'] as String?,
  ),
  targetLanguage: const Iso6393Converter().fromJson(
    json['targetLanguage'] as String?,
  ),
  frequencyMode: $enumDecodeNullable(
    _$FrequencyModeEnumMap,
    json['frequencyMode'],
  ),
);

Map<String, dynamic> _$YomitanIndexToJson(
  YomitanIndex instance,
) => <String, dynamic>{
  'title': instance.title,
  'revision': instance.revision,
  'sequenced': const FlexibleNullableBoolConverter().toJson(instance.sequenced),
  'format': instance.format,
  'version': instance.version,
  'author': instance.author,
  'isUpdatable': const FlexibleNullableBoolConverter().toJson(
    instance.isUpdatable,
  ),
  'indexUrl': instance.indexUrl,
  'downloadUrl': instance.downloadUrl,
  'url': instance.url,
  'description': instance.description,
  'attribution': instance.attribution,
  'sourceLanguage': const Iso6393Converter().toJson(instance.sourceLanguage),
  'targetLanguage': const Iso6393Converter().toJson(instance.targetLanguage),
  'frequencyMode': _$FrequencyModeEnumMap[instance.frequencyMode],
};

const _$FrequencyModeEnumMap = {
  FrequencyMode.occurrenceBased: 'occurrenceBased',
  FrequencyMode.rankBased: 'rankBased',
};
