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
      value: (json['value'] as num?)?.toInt(),
      displayValue: json['displayValue'] as String?,
    );

Map<String, dynamic> _$$TermMetaBankV3EntryImplToJson(
        _$TermMetaBankV3EntryImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'type': instance.type,
      'value': instance.value,
      'displayValue': instance.displayValue,
    };
