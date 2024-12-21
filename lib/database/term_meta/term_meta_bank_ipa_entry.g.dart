// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_ipa_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermMetaBankV3IpaEntryImpl _$$TermMetaBankV3IpaEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$TermMetaBankV3IpaEntryImpl(
      ipa: json['ipa'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$TermMetaBankV3IpaEntryImplToJson(
        _$TermMetaBankV3IpaEntryImpl instance) =>
    <String, dynamic>{
      'ipa': instance.ipa,
      'tags': instance.tags,
    };
