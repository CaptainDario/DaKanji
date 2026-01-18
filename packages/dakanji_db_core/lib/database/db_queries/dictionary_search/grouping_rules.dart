import 'package:freezed_annotation/freezed_annotation.dart';

part 'grouping_rules.freezed.dart';
part 'grouping_rules.g.dart';


/// Base class for grouping rules
abstract class DictionaryGroupingRule {

  const DictionaryGroupingRule();


  Set<int> get targetDictIds;

  Set<int> get dictionaryIds;

  factory DictionaryGroupingRule.fromJson(Map<String, dynamic> json) {
    final type = json['runtimeType'] as String?;
    
    switch (type) {
      case 'sequence':
        return SequenceGroupingRule.fromJson(json);
      case 'termAndReading':
        return TermAndReadingGroupingRule.fromJson(json);
      case 'term':
        return TermGroupingRule.fromJson(json);
      case 'noGrouping':
        return NoGroupingRule.fromJson(json);
      default:
        // Fallback or throw error
        return NoGroupingRule.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();

}

/// Rule for Sequence-based grouping
@Freezed()
@JsonSerializable()
class SequenceGroupingRule extends DictionaryGroupingRule with _$SequenceGroupingRule {

  /// The dictionary from which sequence numbers are taken.
  @override
  final int? sourceDictId;
  /// The dictionaries in which to search for entries matching the sequence
  /// numbers from [sourceDictId].
  @override
  final Set<int> targetDictIds;

  const SequenceGroupingRule({required this.sourceDictId, required this.targetDictIds});

  @override
  Set<int> get dictionaryIds => {?sourceDictId, ...targetDictIds};

  factory SequenceGroupingRule.fromJson(Map<String, dynamic> json)
    => _$SequenceGroupingRuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    ..._$SequenceGroupingRuleToJson(this),
    'runtimeType': 'sequence',
  };
}

/// Rule for Term+Reading grouping
@Freezed()
@JsonSerializable()
class TermAndReadingGroupingRule extends DictionaryGroupingRule with _$TermAndReadingGroupingRule {

  /// The dictionaries in which to search for matching entries 
  @override
  final Set<int> targetDictIds;

  const TermAndReadingGroupingRule(this.targetDictIds);

  @override
  Set<int> get dictionaryIds => targetDictIds;

  factory TermAndReadingGroupingRule.fromJson(Map<String, dynamic> json)
    => _$TermAndReadingGroupingRuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    ..._$TermAndReadingGroupingRuleToJson(this),
    'runtimeType': 'termAndReading',
  };
}

/// Rule for Term grouping
@Freezed()
@JsonSerializable()
class TermGroupingRule extends DictionaryGroupingRule with _$TermGroupingRule {

  /// The dictionaries in which to search for matching entries
  @override
  final Set<int> targetDictIds;

  const TermGroupingRule(this.targetDictIds);

  @override
  Set<int> get dictionaryIds => targetDictIds;

  factory TermGroupingRule.fromJson(Map<String, dynamic> json)
    => _$TermGroupingRuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    ..._$TermGroupingRuleToJson(this),
    'runtimeType': 'term',
  };
}

/// Shorthand class for no grouping
@Freezed()
@JsonSerializable()
class NoGroupingRule extends DictionaryGroupingRule with _$NoGroupingRule {

  const NoGroupingRule();

  @override
  Set<int> get targetDictIds => {};

  @override
  Set<int> get dictionaryIds => {};

  factory NoGroupingRule.fromJson(Map<String, dynamic> json)
    => _$NoGroupingRuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
      ..._$NoGroupingRuleToJson(this),
      'runtimeType': 'noGrouping',
    };
}

