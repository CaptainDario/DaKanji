// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleEntry _$ExampleEntryFromJson(Map<String, dynamic> json) => ExampleEntry(
  id: (json['id'] as num).toInt(),
  indexEntry: IndexEntry.fromJson(json['indexEntry'] as Map<String, dynamic>),
  example: json['example'] as String,
  translations: (json['translations'] as List<dynamic>)
      .map((e) => ExampleEntryTranslation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExampleEntryToJson(ExampleEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexEntry': instance.indexEntry,
      'example': instance.example,
      'translations': instance.translations,
    };
