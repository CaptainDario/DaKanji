import 'package:fullwidth_halfwidth_converter/fullwidth_halfwidth_converter.dart';
import 'package:language_processing/src/japanese/japanese_string_operations.dart';



/// Normalizes a term by:
/// 1. Converting full-width Romaji to half-width.
/// 2. Converting half-width Kana to full-width.
/// 3. Converting Katakana to Hiragana.
/// 4. Optionally converting Romaji to Hiragana.
List<String> normalize(String term, {bool convertRomajiToHiragana = true}) {
  if (term.isEmpty) return [];

  // 1. Width Normalization
  String widthNormalized = term.toFullwidth(convertKana: true);
  widthNormalized = widthNormalized.toHalfwidth(
    convertAlphabet: true, 
    convertNumber: true, 
    convertSymbol: true
  );

  // 2. Script Conversion (Katakana/Romaji -> Hiragana)
  return katakanaToHiragana(widthNormalized, convertRomajiToHiragana);
}

/// Normalizes a list of terms and returns a unique, flattened list of results.
List<String> normalizeAll(List<String> terms, {bool convertRomajiToHiragana = true}) {
  final Set<String> results = {};
  
  for (final term in terms) {
    results.addAll(normalize(term, convertRomajiToHiragana: convertRomajiToHiragana));
  }

  return results.toList();
}