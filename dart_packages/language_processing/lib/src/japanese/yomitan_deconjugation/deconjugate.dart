// lib/src/japanese/yomitan_deconjugation/deconjugate.dart

import 'package:language_processing/src/deconjugation_result.dart';
import 'package:language_processing/src/japanese/conjugation/yomitan_conjugation_data/japanese_transforms.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/language_transformer.dart';


/// Represents user-facing information about an inflection rule.
class InflectionRuleInfo {
  final String name;
  final String? description;

  InflectionRuleInfo({required this.name, this.description});
}

/// Analyzes and deconjugates Japanese surface forms.
class JapaneseWordAnalyzer {
  final DeinflectionEngine _engine;
  final List<String> _validDictionaryForms;

  JapaneseWordAnalyzer()
      : _engine = DeinflectionEngine(),
        _validDictionaryForms = [] {
    
    _engine.loadGrammar(japaneseTransforms);

    // Cache valid parts of speech to evaluate nodes later
    for (final entry in japaneseTransforms.conditions.entries) {
      if (entry.value.isDictionaryForm) {
        _validDictionaryForms.add(entry.key);
      }
    }
  }

  /// Processes a single word into a set of distinct deconjugation results.
  Set<DeconjugationResult> processSingle(String word) {
    final candidates = _engine.analyze(word);
    final validResults = <DeconjugationResult>{};

    for (final candidate in candidates) {
      final matchingPos = _evaluatePartsOfSpeech(candidate.activeMask);

      if (matchingPos.isNotEmpty) {
        final rules = _engine.getDescriptions(candidate.pathIds);
        validResults.add(
          DeconjugationResult(
            deconjugatedTerm: candidate.term,
            requiredPartsOfSpeech: matchingPos,
            transformRules: rules.map((r) => InflectionRuleInfo(name: r.title, description: r.details)).toList(), // Adapt to your old DTO if needed
          ),
        );
      }
    }
    return validResults;
  }

  /// Batch processes multiple terms, filtering out redundant roots.
  List<Set<DeconjugationResult>> processBatch(List<String> terms) {
    final results = <Set<DeconjugationResult>>[];
    final skippedSet = terms.toSet();

    for (final term in terms) {
      if (term.isEmpty) {
        results.add({});
        continue;
      }

      final processed = processSingle(term);
      // Filter out results that are identical to any of the input seeds
      final filtered = processed.where((res) => !skippedSet.contains(res.deconjugatedTerm)).toSet();
      
      results.add(filtered);
    }

    return results;
  }

  List<String> _evaluatePartsOfSpeech(int mask) {
    if (mask == 0) return const [];

    final posList = <String>[];
    for (final pos in _validDictionaryForms) {
      final targetMask = _engine.maskForPartsOfSpeech([pos]);
      if (DeinflectionEngine.checkOverlap(mask, targetMask)) {
        posList.add(pos);
      }
    }
    return posList;
  }
}