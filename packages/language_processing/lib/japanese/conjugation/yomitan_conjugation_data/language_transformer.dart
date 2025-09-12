import 'package:collection/collection.dart';
import 'package:language_processing/japanese/conjugation/yomitan_conjugation_data/japanese_transforms.dart';

/// Represents a single step in a deconjugation chain.
class TraceFrame {
  final String transformId;
  final int ruleIndex;
  final String text;

  TraceFrame(this.transformId, this.ruleIndex, this.text);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TraceFrame &&
          runtimeType == other.runtimeType &&
          transformId == other.transformId &&
          ruleIndex == other.ruleIndex &&
          text == other.text;

  @override
  int get hashCode => transformId.hashCode ^ ruleIndex.hashCode ^ text.hashCode;
}

/// Represents a potential deconjugated form of a source word.
class TransformedText {
  final String text;
  final int conditions;
  final List<TraceFrame> trace;

  TransformedText(this.text, this.conditions, this.trace);

  /// Extracts the chain of transform IDs from the trace.
  List<String> get transformIds => trace.map((f) => f.transformId).toList();
}

/// Represents user-facing information about an inflection rule.
class InflectionRuleInfo {
  final String name;
  final String? description;

  InflectionRuleInfo({required this.name, this.description});
}

// Internal representation of a rule using integer flags for conditions.
class _FlagRule {
  final RegExp isInflected;
  final String Function(String) deinflect;
  final int conditionsIn;
  final int conditionsOut;

  _FlagRule({
    required this.isInflected,
    required this.deinflect,
    required this.conditionsIn,
    required this.conditionsOut,
  });
}

// Internal representation of a transform containing rules with integer flags.
class _FlagTransform {
  final String id;
  final String name;
  final String? description;
  final RegExp heuristic;
  final List<_FlagRule> rules;

  _FlagTransform({
    required this.id,
    required this.name,
    this.description,
    required this.heuristic,
    required this.rules,
  });
}

class LanguageTransformer {
  int _nextFlagIndex = 0;
  final List<_FlagTransform> _transforms = [];
  final Map<String, int> _conditionTypeToConditionFlagsMap = {};
  final Map<String, int> _partOfSpeechToConditionFlagsMap = {};

  /// Resets the transformer's state.
  void clear() {
    _nextFlagIndex = 0;
    _transforms.clear();
    _conditionTypeToConditionFlagsMap.clear();
    _partOfSpeechToConditionFlagsMap.clear();
  }

  void addDescriptor(LanguageTransformDescriptor descriptor) {
    final conditionEntries = descriptor.conditions.entries.toList();
    final conditionFlagsMapResult =
        _getConditionFlagsMap(conditionEntries, _nextFlagIndex);
    final conditionFlagsMap = conditionFlagsMapResult.conditionFlagsMap;
    _nextFlagIndex = conditionFlagsMapResult.nextFlagIndex;

    for (final transformEntry in descriptor.transforms.entries) {
      final transformId = transformEntry.key;
      final transformData = transformEntry.value;

      final flagRules = <_FlagRule>[];
      for (final rule in transformData.rules) {
        final flagsIn =
            _getConditionFlagsStrict(conditionFlagsMap, rule.conditionsIn);
        final flagsOut =
            _getConditionFlagsStrict(conditionFlagsMap, rule.conditionsOut);
        if (flagsIn == null || flagsOut == null) {
          throw Exception(
              'Invalid conditionsIn or conditionsOut for transform $transformId');
        }

        flagRules.add(_FlagRule(
          isInflected: rule.isInflected,
          deinflect: rule.deinflect,
          conditionsIn: flagsIn,
          conditionsOut: flagsOut,
        ));
      }

      final heuristic = RegExp(
          transformData.rules.map((r) => r.isInflected.pattern).join('|'));

      _transforms.add(_FlagTransform(
        id: transformId,
        // Assumes `transformData` has `name` and optional `description` fields.
        name: transformData.name,
        description: transformData.description,
        rules: flagRules,
        heuristic: heuristic,
      ));
    }

    for (final entry in conditionEntries) {
      final type = entry.key;
      final conditionInfo = entry.value;
      final flags = conditionFlagsMap[type];
      if (flags == null) continue;
      _conditionTypeToConditionFlagsMap[type] = flags;
      if (conditionInfo.isDictionaryForm) {
        _partOfSpeechToConditionFlagsMap[type] = flags;
      }
    }
  }

  int getConditionFlagsFromPartsOfSpeech(List<String> partsOfSpeech) {
    return _getConditionFlags(_partOfSpeechToConditionFlagsMap, partsOfSpeech);
  }

  int getConditionFlagsFromConditionType(String conditionType) {
    return _getConditionFlags(
        _conditionTypeToConditionFlagsMap, [conditionType]);
  }

  /// Deconjugates a given source word, returning all possible transformations.
  List<TransformedText> transform(String sourceText) {
    final results = [TransformedText(sourceText, 0, [])];

    for (var i = 0; i < results.length; ++i) {
      final current = results[i];

      for (final transform in _transforms) {
        if (!transform.heuristic.hasMatch(current.text)) {
          continue;
        }

        for (var j = 0; j < transform.rules.length; j++) {
          final rule = transform.rules[j];
          if (!conditionsMatch(current.conditions, rule.conditionsIn)) {
            continue;
          }
          if (!rule.isInflected.hasMatch(current.text)) {
            continue;
          }

          final isCycle = current.trace.any((frame) =>
              frame.transformId == transform.id &&
              frame.ruleIndex == j &&
              frame.text == current.text);
          if (isCycle) {
            continue;
          }

          final newText = rule.deinflect(current.text);

          final newTrace = [
            TraceFrame(transform.id, j, current.text),
            ...current.trace
          ];

          results.add(TransformedText(newText, rule.conditionsOut, newTrace));
        }
      }
    }
    return results;
  }

  /// Gets user-friendly information for a chain of inflection rule IDs.
  List<InflectionRuleInfo> getUserFacingInflectionRules(
      List<String> inflectionRuleIds) {
    return inflectionRuleIds.map((ruleId) {
      final fullRule = _transforms.firstWhereOrNull(
        (transform) => transform.id == ruleId,
      );

      if (fullRule == null) {
        return InflectionRuleInfo(name: ruleId);
      }

      return InflectionRuleInfo(
        name: fullRule.name,
        description: fullRule.description,
      );
    }).toList();
  }

  /// Checks if the conditions match. If currentConditions is 0 (initial state),
  /// it always matches. Otherwise, there must be an overlap.
  static bool conditionsMatch(int currentConditions, int nextConditions) {
    return currentConditions == 0 || (currentConditions & nextConditions) != 0;
  }

  ({Map<String, int> conditionFlagsMap, int nextFlagIndex})
      _getConditionFlagsMap(
          List<MapEntry<String, ConditionInfo>> conditions, int nextFlagIndex) {
    final conditionFlagsMap = <String, int>{};
    var targets = List.of(conditions);

    while (targets.isNotEmpty) {
      final nextTargets = <MapEntry<String, ConditionInfo>>[];
      for (final target in targets) {
        final type = target.key;
        final condition = target.value;
        final subConditions = condition.subConditions;
        int? flags;

        if (subConditions == null) {
          if (nextFlagIndex >= 32) {
            throw Exception('Maximum number of conditions (32) was exceeded');
          }
          flags = 1 << nextFlagIndex;
          nextFlagIndex++;
        } else {
          flags = _getConditionFlagsStrict(conditionFlagsMap, subConditions);
          if (flags == null) {
            nextTargets.add(target);
            continue;
          }
        }
        conditionFlagsMap[type] = flags;
      }
      if (nextTargets.length == targets.length) {
        throw Exception(
            'Cycle in sub-condition declaration or unresolved condition');
      }
      targets = nextTargets;
    }
    return (conditionFlagsMap: conditionFlagsMap, nextFlagIndex: nextFlagIndex);
  }

  int? _getConditionFlagsStrict(
      Map<String, int> conditionFlagsMap, List<String> conditionTypes) {
    int flags = 0;
    for (final conditionType in conditionTypes) {
      final flags2 = conditionFlagsMap[conditionType];
      if (flags2 == null) {
        return null;
      }
      flags |= flags2;
    }
    return flags;
  }

  int _getConditionFlags(
      Map<String, int> conditionFlagsMap, List<String> conditionTypes) {
    int flags = 0;
    for (final conditionType in conditionTypes) {
      flags |= conditionFlagsMap[conditionType] ?? 0;
    }
    return flags;
  }
}