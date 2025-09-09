import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/japanese/japanese_string_operations.dart';
import 'package:fullwidth_halfwidth_converter/fullwidth_halfwidth_converter.dart';



/// Preprocesses the input term for searching.
/// Standardize full-width / half-width
///   * For kana everything is converted to full-width
///   * For romaji everything is converted to half-width
/// and optionally converts romaji to hiragana (if `convertRomajiToHiragana` is
/// true).
/// 
/// Returns a tuple containing:
/// - `term`: The preprocessed term
/// - `hiraganaTerm`: The hiragana conversion of the term if romaji conversion
///    was performed, otherwise null.
({String term, String? hiraganaTerm}) preprocessInput(String input, bool convertRomajiToHiragana) {
  // convert full-width romaji to half-width and half-width kana to full-width
  String processedTerm = input.toFullwidth(convertKana: true);
  processedTerm = processedTerm.toHalfwidth(
    convertAlphabet: true, convertNumber: true, convertSymbol: true);

  // 2. convert all kana to hiragana
  processedTerm = katakanaToHiragana(processedTerm);

  // 3. convert romaji to kana if convertRomajiToHiragana is true
  //    AND the input contains romaji characters
  String? hiraganaTerm;
  if (convertRomajiToHiragana) {
    final romajiConverted = romajiToHiragana(processedTerm);
    // Only set hiraganaTerm if the conversion actually changed the string
    // AND the result contains ONLY Japanese characters
    if (romajiConverted != processedTerm &&
      KanaKit().isJapanese(romajiConverted)) {
      hiraganaTerm = romajiConverted;
    }
  }

  return (term: processedTerm, hiraganaTerm: hiraganaTerm);
}