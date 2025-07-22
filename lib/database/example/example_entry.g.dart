// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExampleEntry _$ExampleEntryFromJson(Map<String, dynamic> json) =>
    _ExampleEntry(
      example: json['example'] as String,
      tokenizedExample: json['tokenizedExample'] as String,
      translations: (json['translations'] as List<dynamic>)
          .map(
            (e) => ExampleEntryTranslation.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ExampleEntryToJson(_ExampleEntry instance) =>
    <String, dynamic>{
      'example': instance.example,
      'tokenizedExample': instance.tokenizedExample,
      'translations': instance.translations,
    };
