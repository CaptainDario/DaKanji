import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:language_processing/src/japanese/conjugation/yomitan_conjugation_data/japanese_transforms.dart';


/// Represents a single mutation in a chain of deconjugations.
class InflectionStep {
  final String groupId;
  final int ruleIndex;
  final String surfaceTerm;

  InflectionStep(this.groupId, this.ruleIndex, this.surfaceTerm);
}

/// Represents a potential dictionary form discovered during traversal.
class CandidateNode {
  final String term;
  final int activeMask;
  final List<InflectionStep> history;

  CandidateNode(this.term, this.activeMask, this.history);

  List<String> get pathIds => history.map((h) => h.groupId).toList();
}

/// Metadata about a successfully applied rule group.
class RuleDescription {
  final String title;
  final String? details;

  RuleDescription({required this.title, this.details});
}

// Internal compiled structures for fast bitwise execution
class _CompiledRule {
  final RegExp matcher;
  final String Function(String) apply;
  final int requiredMask;
  final int resultingMask;

  _CompiledRule(this.matcher, this.apply, this.requiredMask, this.resultingMask);
}

class _CompiledGroup {
  final String id;
  final String title;
  final String? details;
  final RegExp quickReject;
  final List<_CompiledRule> rules;

  _CompiledGroup(this.id, this.title, this.details, this.quickReject, this.rules);
}

/// Manages the resolution and allocation of bitwise flags for grammar conditions.
class _ConditionRegistry {
  final Map<String, int> masks = {};
  final Map<String, int> dictionaryMasks = {};
  int _nextBit = 0;

  void compile(Map<String, ConditionInfo> conditions) {
    var pending = conditions.entries.toList();

    // Topological resolution of nested conditions
    while (pending.isNotEmpty) {
      final stillPending = <MapEntry<String, ConditionInfo>>[];

      for (final entry in pending) {
        final subs = entry.value.subConditions;
        
        if (subs == null) {
          masks[entry.key] = 1 << _nextBit++;
        } else {
          int combined = 0;
          bool ready = true;
          for (final sub in subs) {
            if (!masks.containsKey(sub)) {
              ready = false;
              break;
            }
            combined |= masks[sub]!;
          }

          if (ready) {
            masks[entry.key] = combined;
          } else {
            stillPending.add(entry);
          }
        }
      }

      if (stillPending.length == pending.length) {
        throw StateError('Circular dependency detected in grammar conditions.');
      }
      pending = stillPending;
    }

    // Isolate dictionary forms
    for (final entry in conditions.entries) {
      if (entry.value.isDictionaryForm) {
        dictionaryMasks[entry.key] = masks[entry.key]!;
      }
    }
  }

  int resolveMask(List<String> types) {
    int mask = 0;
    for (final t in types) {
      mask |= (masks[t] ?? 0);
    }
    return mask;
  }
}

/// The main engine that evaluates word morphology.
class DeinflectionEngine {
  final List<_CompiledGroup> _groups = [];
  final _ConditionRegistry _registry = _ConditionRegistry();

  void loadGrammar(LanguageTransformDescriptor data) {
    _groups.clear();
    _registry.masks.clear();
    _registry.dictionaryMasks.clear();
    _registry._nextBit = 0;

    _registry.compile(data.conditions);

    for (final entry in data.transforms.entries) {
      final rules = <_CompiledRule>[];
      final patterns = <String>[];

      for (final r in entry.value.rules) {
        // We cast back to InflectionPattern because we changed the interface
        final pattern = r;
        
        final reqMask = _registry.resolveMask(pattern.expectedFlags);
        final resMask = _registry.resolveMask(pattern.nextFlags);

        rules.add(_CompiledRule(
          pattern.matchPattern,
          pattern.revert,
          reqMask,
          resMask,
        ));
        patterns.add(pattern.matchPattern.pattern);
      }

      _groups.add(_CompiledGroup(
        entry.key,
        entry.value.name,
        entry.value.description,
        RegExp(patterns.join('|')),
        rules,
      ));
    }
  }

  int maskForPartsOfSpeech(List<String> pos) {
    int mask = 0;
    for (final p in pos) {
      mask |= (_registry.dictionaryMasks[p] ?? 0);
    }
    return mask;
  }

  int maskForCondition(String condition) => _registry.masks[condition] ?? 0;

  /// Analyzes a string and returns all valid morphological paths.
  List<CandidateNode> analyze(String input) {
    // Breadth-first search queue
    final queue = Queue<CandidateNode>()..add(CandidateNode(input, 0, []));
    final validPaths = <CandidateNode>[];

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      validPaths.add(current);

      for (final group in _groups) {
        if (!group.quickReject.hasMatch(current.term)) continue;

        for (var i = 0; i < group.rules.length; i++) {
          final rule = group.rules[i];

          // Check condition overlaps safely
          if (!_isCompatible(current.activeMask, rule.requiredMask)) continue;
          if (!rule.matcher.hasMatch(current.term)) continue;

          // Prevent infinite cyclic loops
          final isCycle = current.history.any((step) =>
              step.groupId == group.id &&
              step.ruleIndex == i &&
              step.surfaceTerm == current.term);

          if (isCycle) continue;

          final step = InflectionStep(group.id, i, current.term);
          final nextTerm = rule.apply(current.term);
          
          queue.add(CandidateNode(
            nextTerm,
            rule.resultingMask,
            [step, ...current.history], // Prepend to maintain reverse order
          ));
        }
      }
    }

    return validPaths;
  }

  List<RuleDescription> getDescriptions(List<String> pathIds) {
    return pathIds.map((id) {
      final group = _groups.firstWhereOrNull((g) => g.id == id);
      return RuleDescription(
        title: group?.title ?? id,
        details: group?.details,
      );
    }).toList();
  }

  static bool _isCompatible(int currentMask, int requiredMask) {
    return currentMask == 0 || (currentMask & requiredMask) != 0;
  }

  // Exposed for tests
  static bool checkOverlap(int a, int b) => _isCompatible(a, b);
}