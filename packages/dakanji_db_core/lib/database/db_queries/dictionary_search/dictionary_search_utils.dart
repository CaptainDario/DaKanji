import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
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
/// Returns
/// - `normalizedTerms`: All possible normalized terms
/// - `deconjugatedTerms`: A list of found deconjugations of the input term
({List<String> normalizedTerms, List<DeconjugationResult> termVariants}) 
  preprocessInput(String searchTerm, bool convertRomajiToHiragana) {

  if(searchTerm == "") return (normalizedTerms: [], termVariants: []);

  // convert full-width romaji to half-width and half-width kana to full-width
  String widthNormalizedTerm = searchTerm.toFullwidth(convertKana: true);
  widthNormalizedTerm = widthNormalizedTerm.toHalfwidth(
    convertAlphabet: true, convertNumber: true, convertSymbol: true);

  // convert all kana to hiragana
  // optionally: convet romaji to hiragana if romaji are converted multiple
  //             hiragana terms may be returned
  List<String> normalizedTerms = katakanaToHiragana(widthNormalizedTerm, convertRomajiToHiragana);

  // find all possible deconjugations of the terms
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

/// Helper to print debug information
void printDictionarySearchDebugInfo(
  DictionarySearchParams params,
  List<String> normalizedTerms,
  List<DeconjugationResult> termVariants,
  List<String> spellingVariations,
  bool isWildcardSearch,
  Stopwatch s
) {
    print("=== Dictionary Search Debug Info ===");
    print("Input Term: ${params.query}");
    print("Normalized Search: ${params.normalizedSearch}");
    print("Deconjugation Search: ${params.deconjugationSearch}");
    print("Spellfix Search: ${params.spellfixSearch}");
    print("Normalized Terms: $normalizedTerms");
    print("Term Variants (Deconjugated): ${termVariants.map((e) => e.deconjugatedTerm).toList()}");
    print("Spelling Variations: $spellingVariations");
    print("Is Wildcard Search: $isWildcardSearch");
    print("Indexes to Include: ${params.indexesToInclude}");
    print("Grouping Rules: ${params.groupingRules}");
    print("Search setup complete in ${s.elapsedMilliseconds}ms");
    print("====================================");
  }