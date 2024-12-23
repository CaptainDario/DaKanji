// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermBankEntryImpl _$$TermBankEntryImplFromJson(Map<String, dynamic> json) =>
    _$TermBankEntryImpl(
      term: json['term'] as String,
      reading: json['reading'] as String,
      definitionTags: (json['definitionTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ruleIdentifiers: (json['ruleIdentifiers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      popularity: (json['popularity'] as num).toInt(),
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sequenceNumber: (json['sequenceNumber'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagBankEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TermBankEntryImplToJson(_$TermBankEntryImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'reading': instance.reading,
      'definitionTags': instance.definitionTags,
      'ruleIdentifiers': instance.ruleIdentifiers,
      'popularity': instance.popularity,
      'definitions': instance.definitions,
      'sequenceNumber': instance.sequenceNumber,
      'tags': instance.tags,
    };
