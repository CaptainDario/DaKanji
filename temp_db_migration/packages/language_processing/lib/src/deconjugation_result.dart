import 'package:language_processing/src/japanese/yomitan_deconjugation/language_transformer.dart';

/// Holds a single, complete deconjugation result.
class DeconjugationResult {
  /// The deconjugated term (the dictionary form).
  final String deconjugatedTerm;

  /// A list of the parts of speech the base term must be for this
  /// deconjugation path to be valid.
  final List<String> requiredPartsOfSpeech;

  /// The chain of transformation rules that were applied to get to the base term.
  final List<InflectionRuleInfo> transformRules;

  DeconjugationResult({
    required this.deconjugatedTerm,
    required this.requiredPartsOfSpeech,
    required this.transformRules,
  });

  @override
  String toString() {
    final rulesString = transformRules.map((r) => r.name).join(' -> ');
    return 'Term: $deconjugatedTerm, PoS: $requiredPartsOfSpeech, Rules: [$rulesString]';
  }
}