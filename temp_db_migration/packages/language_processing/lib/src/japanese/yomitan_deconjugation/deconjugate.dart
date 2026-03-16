import 'package:language_processing/src/deconjugation_result.dart';
import 'package:language_processing/src/japanese/conjugation/yomitan_conjugation_data/japanese_transforms.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/language_transformer.dart';


/// A service class to deconjugate Japanese words
class JapaneseDeconjugator {
  final LanguageTransformer _transformer;
  final List<String> _dictionaryForms;

  /// Creates and initializes the deconjugator.
  JapaneseDeconjugator()
      : _transformer = LanguageTransformer(),
        _dictionaryForms = [] {
    // Load the Japanese grammar rules into the transformer.
    _transformer.addDescriptor(japaneseTransforms); //

    // Pre-compile a list of all conditions that are valid dictionary forms
    // by checking the `isDictionaryForm` flag from the descriptor.
    for (final entry in japaneseTransforms.conditions.entries) { //
      if (entry.value.isDictionaryForm) { //
        _dictionaryForms.add(entry.key);
      }
    }
  }

  /// Returns all possible deconjugations for a given [inflectedWord].
  Set<DeconjugationResult> deconjugate(String inflectedWord) {
    final allTransforms = _transformer.transform(inflectedWord); //
    final validResults = <DeconjugationResult>{};

    for (final result in allTransforms) {
      final requiredPos = _findRequiredPartsOfSpeech(result.conditions);

      if (requiredPos.isNotEmpty) {
        final rules =
            _transformer.getUserFacingInflectionRules(result.transformIds); //
        validResults.add(
          DeconjugationResult(
            deconjugatedTerm: result.text,
            requiredPartsOfSpeech: requiredPos,
            transformRules: rules,
          ),
        );
      }
    }
    return validResults;
  }

  List<Set<DeconjugationResult>> deconjugateAll(List<String> terms) {

    final List<Set<DeconjugationResult>> results = [];
    final Set<String> exclusions = terms.toSet();

    for (String d in terms) {
      results.add({});
      if (d.isEmpty) continue;
      
      results.last.addAll(
        deconjugate(d).where((e) => !exclusions.contains(e.deconjugatedTerm))
      );
    }

    return results;
  }

  /// Finds the required PoS by testing every known dictionary form
  /// against the result's condition flags.
  List<String> _findRequiredPartsOfSpeech(int resultConditions) {
    final matchingPos = <String>[];
    if (resultConditions == 0) {
      return matchingPos;
    }

    // For every known dictionary form (e.g., 'v1', 'v5', 'adj-i')...
    for (final posString in _dictionaryForms) {
      // ...get its unique integer flag using the public API...
      final posFlag =
          _transformer.getConditionFlagsFromPartsOfSpeech([posString]); //

      // ...and check if it matches the result's conditions.
      if (LanguageTransformer.conditionsMatch(resultConditions, posFlag)) { //
        matchingPos.add(posString);
      }
    }
    return matchingPos;
  }
}