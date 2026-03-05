import 'dart:convert';

import 'package:language_processing/language_processing.dart';
import 'package:language_processing/src/parse_result.dart';





abstract class LanguageProcessor {

  abstract Iso639_3 languageCode;

  const LanguageProcessor();

  factory LanguageProcessor.fromJson(Map<String, dynamic> json) {
    final String languageCode = json['languageCode'];

    if (languageCode == Iso639_3.jpn.name) {
      return JapaneseProcessor.fromJson(json);
    }
    else {
      throw UnsupportedError('Unknown LanguageProcessor type: $languageCode');
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

  ParseResult parse(String term, ProcessorOptions options);

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

  List<String> findSentences(String text, ProcessorOptions options);

}