// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouping_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SequenceGroupingRule _$SequenceGroupingRuleFromJson(
  Map<String, dynamic> json,
) => SequenceGroupingRule(
  sourceDictId: (json['sourceDictId'] as num).toInt(),
  targetDictIds: (json['targetDictIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toSet(),
);

Map<String, dynamic> _$SequenceGroupingRuleToJson(
  SequenceGroupingRule instance,
) => <String, dynamic>{
  'sourceDictId': instance.sourceDictId,
  'targetDictIds': instance.targetDictIds.toList(),
};

TermAndReadingGroupingRule _$TermAndReadingGroupingRuleFromJson(
  Map<String, dynamic> json,
) => TermAndReadingGroupingRule(
  (json['targetDictIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toSet(),
);

Map<String, dynamic> _$TermAndReadingGroupingRuleToJson(
  TermAndReadingGroupingRule instance,
) => <String, dynamic>{'targetDictIds': instance.targetDictIds.toList()};

TermGroupingRule _$TermGroupingRuleFromJson(Map<String, dynamic> json) =>
    TermGroupingRule(
      (json['targetDictIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toSet(),
    );

Map<String, dynamic> _$TermGroupingRuleToJson(TermGroupingRule instance) =>
    <String, dynamic>{'targetDictIds': instance.targetDictIds.toList()};

NoGroupingRule _$NoGroupingRuleFromJson(Map<String, dynamic> json) =>
    NoGroupingRule();

Map<String, dynamic> _$NoGroupingRuleToJson(NoGroupingRule instance) =>
    <String, dynamic>{};
