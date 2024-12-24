// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExampleEntryImpl _$$ExampleEntryImplFromJson(Map<String, dynamic> json) =>
    _$ExampleEntryImpl(
      example: json['example'] as String,
      translations: (json['translations'] as List<dynamic>)
          .map((e) =>
              ExampleEntryTranslation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExampleEntryImplToJson(_$ExampleEntryImpl instance) =>
    <String, dynamic>{
      'example': instance.example,
      'translations': instance.translations,
    };
