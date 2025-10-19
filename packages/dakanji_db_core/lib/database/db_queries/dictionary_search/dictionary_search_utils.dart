import 'package:fullwidth_halfwidth_converter/fullwidth_halfwidth_converter.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/japanese/conjugation/yomitan_deconjugate.dart';
import 'package:language_processing/japanese/japanese_string_operations.dart';



/// Preprocesses the input term for searching.
/// Standardize full-width / half-width
///   * For kana everything is converted to full-width
///   * For romaji everything is converted to half-width
/// and optionally converts romaji to hiragana (if `convertRomajiToHiragana` is
/// true).
/// 
/// Returns a tuple containing:
/// - `hiraganaTerm`: The hiragana conversion of the term if romaji conversion
///    was performed, otherwise null.
/// - `processedTerms`: A list of processed terms
({String? normalizedTerm, List<DeconjugationResult> termVariants}) preprocessInput(String searchTerm, bool convertRomajiToHiragana) {

  if(searchTerm == "") return (normalizedTerm: searchTerm, termVariants: []);

  // 1. convert full-width romaji to half-width and half-width kana to full-width
  String normalizedTerm = searchTerm.toFullwidth(convertKana: true);
  normalizedTerm = normalizedTerm.toHalfwidth(
    convertAlphabet: true, convertNumber: true, convertSymbol: true);

  // 2. convert all kana to hiragana
  normalizedTerm = katakanaToHiragana(normalizedTerm);

  // 3. convert romaji to kana
  String? romajiToHiraganaResult;
  if(convertRomajiToHiragana) romajiToHiraganaResult= romajiToHiragana(normalizedTerm);
  
  // Only set hiraganaTerm if the conversion actually changed the string
  // AND the result contains ONLY Japanese characters
  String? hiraganaTerm;
  if (romajiToHiraganaResult != null &&
    KanaKit().isJapanese(romajiToHiraganaResult)) {
    hiraganaTerm = romajiToHiraganaResult;
  }
  // OR the normalized term is different from the input term
  else {
    hiraganaTerm = normalizedTerm;
  }

  // 4. find all possible deconjugations of the hiragana term
  Iterable<String>? deconjugate = [searchTerm, hiraganaTerm].nonNulls;
  
  List<DeconjugationResult>? termVariants;
  for (String d in deconjugate) {
    JapaneseDeconjugator deconjugator = JapaneseDeconjugator();
    termVariants = deconjugator.deconjugate(d)
      .where((e) =>
        e.deconjugatedTerm != d // filter out the input term itself
        && e.deconjugatedTerm != hiraganaTerm // filter out the hiragana term if applicable
        && e.deconjugatedTerm != searchTerm // filter out the original search term
      )
      .toSet() /// remove duplicates
      .toList();
  }

  return (
    normalizedTerm: hiraganaTerm,
    termVariants: termVariants ?? []
  );
}