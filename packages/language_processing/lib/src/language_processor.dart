import 'dart:convert';

import 'package:language_processing/src/deconjugation_result.dart';
import 'package:language_processing/src/japanese/japanese_processor.dart';
import 'package:language_processing/src/language_processor_options.dart';
import 'package:language_processing/src/term_reading_pair.dart';





abstract class LanguageProcessor {

  const LanguageProcessor();

  factory LanguageProcessor.fromJson(Map<String, dynamic> json) {
    final String type = json['type'];

    switch (type) {
      case 'japanese':
        return JapaneseProcessor.fromJson(json);
      default:
        throw UnsupportedError('Unknown LanguageProcessor type: $type');
    }
  }

  factory LanguageProcessor.fromJsonString(String jsonString)
    => LanguageProcessor.fromJson(jsonDecode(jsonString));

  // Concrete implementation relying on the abstract toJson()
  String toJsonString() => jsonEncode(toJson());

  Map<String, dynamic> toJson();

  Future init();

  Future close();

  List<String> normalize(String term, ProcessorOptions options);

  List<String> normalizeAll(List<String> terms, ProcessorOptions options);

  Set<DeconjugationResult> deconjugate(String term);

  List<Set<DeconjugationResult>> deconjugateAll(List<String> terms);

  /// Tokenizes the given text and returns the tokenized string (separated by
  /// spaces), if `tokenizeed != text` else returns null
  String? tokenize(String text);

  /// Returns the readings for the given text
  String getReadings(String text);

  /// Generates possible misspelling variants from a given string
  List<String> generateSpellingVariations({
    required String word,
    required int n,
    required int maxCost,
    int substitutionPenalty = 0,
    List<(String, String, int)> rules,
    List<String> forbiddenSequences
  });

  /// Returns true if the string consists primarily of the language's 
  /// specific ideographs (e.g., Kanji for JP, Hanzi for CN)
  bool isIdeographic(String text);

  List<TermReadingPair> getTermReadingPairs(
    String term, String reading, ProcessorOptions options);

  List<String> findSentences(String text);

}