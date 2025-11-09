// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_meta_bank_ipa_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TermMetaBankV3IpaEntry _$TermMetaBankV3IpaEntryFromJson(
  Map<String, dynamic> json,
) => _TermMetaBankV3IpaEntry(
  ipa: json['ipa'] as String,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map(const TagBankV3EntryConverter().fromJson)
          .toList() ??
      const [],
);

Map<String, dynamic> _$TermMetaBankV3IpaEntryToJson(
  _TermMetaBankV3IpaEntry instance,
) => <String, dynamic>{
  'ipa': instance.ipa,
  'tags': instance.tags.map(const TagBankV3EntryConverter().toJson).toList(),
};
