// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermBankV3Entry _$TermBankV3EntryFromJson(Map<String, dynamic> json) =>
    TermBankV3Entry(
      id: (json['id'] as num).toInt(),
      indexEntry: IndexEntry.fromJson(
        json['indexEntry'] as Map<String, dynamic>,
      ),
      term: json['term'] as String,
      reading: json['reading'] as String,
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      structuredContentDefinitions:
          json['structuredContentDefinitions'] as List<dynamic>,
      definitionTags: (json['definitionTags'] as List<dynamic>)
          .map((e) => TagBankV3Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
      ruleIdentifiers: (json['ruleIdentifiers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      popularity: (json['popularity'] as num).toInt(),
      sequenceNumber: (json['sequenceNumber'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagBankV3Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TermBankV3EntryToJson(TermBankV3Entry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexEntry': instance.indexEntry,
      'term': instance.term,
      'reading': instance.reading,
      'definitions': instance.definitions,
      'structuredContentDefinitions': instance.structuredContentDefinitions,
      'definitionTags': instance.definitionTags,
      'ruleIdentifiers': instance.ruleIdentifiers,
      'popularity': instance.popularity,
      'sequenceNumber': instance.sequenceNumber,
      'tags': instance.tags,
    };
