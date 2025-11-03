// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_bank_v3_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermBankV3Entry _$TermBankV3EntryFromJson(Map<String, dynamic> json) =>
    TermBankV3Entry(
      termBankV3TableId: (json['termBankV3TableId'] as num).toInt(),
      indexId: (json['indexId'] as num).toInt(),
      term: json['term'] as String,
      reading: json['reading'] as String,
      definitionTags: (json['definitionTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ruleIdentifiers: (json['ruleIdentifiers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      popularity: (json['popularity'] as num).toInt(),
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sequenceNumber: (json['sequenceNumber'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagBankV3Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TermBankV3EntryToJson(TermBankV3Entry instance) =>
    <String, dynamic>{
      'termBankV3TableId': instance.termBankV3TableId,
      'indexId': instance.indexId,
      'term': instance.term,
      'reading': instance.reading,
      'definitionTags': instance.definitionTags,
      'ruleIdentifiers': instance.ruleIdentifiers,
      'popularity': instance.popularity,
      'definitions': instance.definitions,
      'sequenceNumber': instance.sequenceNumber,
      'tags': instance.tags,
    };
