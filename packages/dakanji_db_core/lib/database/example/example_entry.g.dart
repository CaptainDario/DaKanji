// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleEntry _$ExampleEntryFromJson(Map<String, dynamic> json) => ExampleEntry(
  example: json['example'] as String,
  translations: (json['translations'] as List<dynamic>)
      .map((e) => ExampleEntryTranslation.fromJson(e as Map<String, dynamic>))
      .toList(),
  indexId: (json['indexId'] as num).toInt(),
);

Map<String, dynamic> _$ExampleEntryToJson(ExampleEntry instance) =>
    <String, dynamic>{
      'example': instance.example,
      'indexId': instance.indexId,
      'translations': instance.translations,
    };
