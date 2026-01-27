// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_bank_v3_entry_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KanjiBankV3EntryStat _$KanjiBankV3EntryStatFromJson(
  Map<String, dynamic> json,
) => _KanjiBankV3EntryStat(
  value: json['value'] as String,
  tag: TagBankV3Entry.fromJson(json['tag'] as Map<String, dynamic>),
);

Map<String, dynamic> _$KanjiBankV3EntryStatToJson(
  _KanjiBankV3EntryStat instance,
) => <String, dynamic>{'value': instance.value, 'tag': instance.tag};
