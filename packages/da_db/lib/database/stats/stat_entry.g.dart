// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatEntry _$StatEntryFromJson(Map<String, dynamic> json) => _StatEntry(
  statName: json['statName'] as String,
  displayName: json['displayName'] as String?,
  value: (json['value'] as num).toDouble(),
  displayValue: json['displayValue'] as String?,
);

Map<String, dynamic> _$StatEntryToJson(_StatEntry instance) =>
    <String, dynamic>{
      'statName': instance.statName,
      'displayName': instance.displayName,
      'value': instance.value,
      'displayValue': instance.displayValue,
    };
