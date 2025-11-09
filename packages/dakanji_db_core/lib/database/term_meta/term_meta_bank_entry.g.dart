// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TermMetaBankV3Entry _$TermMetaBankV3EntryFromJson(
  Map<String, dynamic> json,
) => _TermMetaBankV3Entry(
  termMetaBankV3TableId: (json['termMetaBankV3TableId'] as num).toInt(),
  indexEntry: IndexEntry.fromJson(json['indexEntry'] as Map<String, dynamic>),
  term: json['term'] as String,
  type: json['type'] as String,
  reading: json['reading'] as String?,
  frequency: (json['frequency'] as num?)?.toInt(),
  frequencyDisplayValue: json['frequencyDisplayValue'] as String?,
  pitchs: (json['pitchs'] as List<dynamic>)
      .map((e) => TermMetaBankV3PitchEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
  ipas: (json['ipas'] as List<dynamic>)
      .map((e) => TermMetaBankV3IpaEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TermMetaBankV3EntryToJson(
  _TermMetaBankV3Entry instance,
) => <String, dynamic>{
  'termMetaBankV3TableId': instance.termMetaBankV3TableId,
  'indexEntry': instance.indexEntry,
  'term': instance.term,
  'type': instance.type,
  'reading': instance.reading,
  'frequency': instance.frequency,
  'frequencyDisplayValue': instance.frequencyDisplayValue,
  'pitchs': instance.pitchs,
  'ipas': instance.ipas,
};
