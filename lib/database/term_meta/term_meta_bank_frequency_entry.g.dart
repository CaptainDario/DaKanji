// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_frequency_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermMetaBankV3FrequencyEntryImpl _$$TermMetaBankV3FrequencyEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$TermMetaBankV3FrequencyEntryImpl(
      frequency: (json['frequency'] as num?)?.toInt(),
      frequencyDisplayValue: json['frequencyDisplayValue'] as String?,
    );

Map<String, dynamic> _$$TermMetaBankV3FrequencyEntryImplToJson(
        _$TermMetaBankV3FrequencyEntryImpl instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'frequencyDisplayValue': instance.frequencyDisplayValue,
    };
