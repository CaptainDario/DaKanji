import 'package:fullwidth_halfwidth_converter/fullwidth_halfwidth_converter.dart';
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
({List<String> normalizedTerms, List<DeconjugationResult> termVariants}) preprocessInput(String searchTerm, bool convertRomajiToHiragana) {

  if(searchTerm == "") return (normalizedTerms: [], termVariants: []);

  // 1. convert full-width romaji to half-width and half-width kana to full-width
  String widthNormalizedTerm = searchTerm.toFullwidth(convertKana: true);
  widthNormalizedTerm = widthNormalizedTerm.toHalfwidth(
    convertAlphabet: true, convertNumber: true, convertSymbol: true);

  // 2. convert all kana to hiragana and optionally romaji to hiragana
  // if romaji are converted multiple hiragana terms may be returned
  List<String> normalizedTerms = katakanaToHiragana(widthNormalizedTerm, convertRomajiToHiragana);

  // 4. find all possible deconjugations of the terms
  Iterable<String>? deconjugate = {searchTerm, ...normalizedTerms}.toList();
  
  List<DeconjugationResult> termVariants = [];
  for (String d in deconjugate) {
    JapaneseDeconjugator deconjugator = JapaneseDeconjugator();
    termVariants.addAll(
      deconjugator.deconjugate(d)
        .where((e) =>
          e.deconjugatedTerm != d // filter out the input term itself
          && e.deconjugatedTerm != widthNormalizedTerm // filter out the hiragana term if applicable
          && e.deconjugatedTerm != searchTerm // filter out the original search term
        )
    );
  }

  return (
    normalizedTerms: normalizedTerms,
    termVariants: termVariants
  );
}
