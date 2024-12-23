// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermMetaBankV3EntryImpl _$$TermMetaBankV3EntryImplFromJson(
        Map<String, dynamic> json) =>
    _$TermMetaBankV3EntryImpl(
      term: json['term'] as String,
      type: json['type'] as String,
      reading: json['reading'] as String?,
      frequency: (json['frequency'] as num?)?.toInt(),
      frequencyDisplayValue: json['frequencyDisplayValue'] as String?,
      pitchs: (json['pitchs'] as List<dynamic>?)
          ?.map((e) =>
              TermMetaBankV3PitchEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      ipas: (json['ipas'] as List<dynamic>?)
          ?.map(
              (e) => TermMetaBankV3IpaEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TermMetaBankV3EntryImplToJson(
        _$TermMetaBankV3EntryImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'type': instance.type,
      'reading': instance.reading,
      'frequency': instance.frequency,
      'frequencyDisplayValue': instance.frequencyDisplayValue,
      'pitchs': instance.pitchs,
      'ipas': instance.ipas,
    };
