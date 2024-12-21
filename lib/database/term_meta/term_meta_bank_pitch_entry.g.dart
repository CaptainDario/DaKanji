// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_pitch_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermMetaBankV3PitchEntryImpl _$$TermMetaBankV3PitchEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$TermMetaBankV3PitchEntryImpl(
      position: (json['position'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      nasal: (json['nasal'] as num?)?.toInt(),
      devoice: (json['devoice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TermMetaBankV3PitchEntryImplToJson(
        _$TermMetaBankV3PitchEntryImpl instance) =>
    <String, dynamic>{
      'position': instance.position,
      'tags': instance.tags,
      'nasal': instance.nasal,
      'devoice': instance.devoice,
    };
