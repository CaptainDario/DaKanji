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
      frequency: json['frequency'] == null
          ? null
          : TermMetaBankV3FrequencyEntry.fromJson(
              json['frequency'] as Map<String, dynamic>),
      pitch: json['pitch'] == null
          ? null
          : TermMetaBankV3PitchEntry.fromJson(
              json['pitch'] as Map<String, dynamic>),
      ipa: json['ipa'] == null
          ? null
          : TermMetaBankV3IpaEntry.fromJson(
              json['ipa'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TermMetaBankV3EntryImplToJson(
        _$TermMetaBankV3EntryImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'type': instance.type,
      'reading': instance.reading,
      'frequency': instance.frequency,
      'pitch': instance.pitch,
      'ipa': instance.ipa,
    };
