import 'dart:convert';

import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_context.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:fullwidth_halfwidth_converter/fullwidth_halfwidth_converter.dart';
import 'package:language_processing/japanese/conjugation/yomitan_deconjugate.dart';
import 'package:language_processing/japanese/japanese_string_operations.dart';

/// Parses special argument syntax from raw input strings.
/// 
/// The expected format is:
/// `?t=termFilter&r=readingFilter&d=definitionFilter #tag1 #tag2`
/// 
/// Returns a tuple containing the extracted filters:
/// - termFilter: Filter for terms (nullable)
/// - readingFilter: Filter for readings (nullable)
/// - definitionFilter: Filter for definitions (nullable)
/// 
/// If the input does not match the expected format, returns null.
({
  String? term,
  String? reading,
  String? definition,
})? argumentParser(String raw) {
  
  // Structured command mode (e.g. "?t=word")
  if (raw.startsWith("?")) {
    final uri = Uri.tryParse("x:$raw");
    if (uri != null) {
      return (
        term: uri.queryParameters['t'],
        reading: uri.queryParameters['r'],
        definition: uri.queryParameters['d'],
      );
    }
  }

  // Return empty structure if nothing found
  return (term: null, reading: null, definition: null);
}

/// Extracts #tags and $pos using Regex and returns the list of tags and the cleaned
/// string.
({List<String> tags, List<String> pos, String cleanedQuery}) extractTagsAndPos(String raw) {
  final tagRegex = RegExp(r'#([^\s]+)');
  final posRegex = RegExp(r'\$([^\s]+)'); // Escape $ with \
  
  // 1. Extract Tags
  List<String> tags = tagRegex
    .allMatches(raw)
    .map((match) => match.group(1)!)
    .toList();

  // 2. Extract POS
  List<String> pos = posRegex
    .allMatches(raw)
    .map((match) => match.group(1)!)
    .toList();

  // 3. Clean the string (remove both patterns)
  String cleaned = raw
      .replaceAll(tagRegex, '')
      .replaceAll(posRegex, '')
      .trim();

  return (tags: tags, pos: pos, cleanedQuery: cleaned);
}

/// Extracts %pos using Regex and returns the list of tags and the cleaned
/// string.
({List<String> tags, String queryWoTags}) extractPos(String raw) {
  final tagRegex = RegExp(r'#([^\s]+)');
  
  List<String> tags = tagRegex
    .allMatches(raw)
    .map((match) => match.group(1)!)
    .toList();

  return (tags: tags, queryWoTags: raw.replaceAll(tagRegex, '').trim());
}


/// Constructs the JSON string for dictionary search.
/// 
/// [searchInputs]: List of `[term, mode]`. Example: `[['eat', 0], ['eating', 0]]`
/// [rules]: Optional list of rule (pos) lists per term. Example: `[['v1'], ['n']]`
/// [tags]: Optional list of tag lists per term. Example: `[[], ['common']]`
String buildSearchInputJson(
  List<List<dynamic>> searchInputs, {
  List<List<String>>? pos,
  List<List<String>>? tags,
}) {
  final mergedList = <List<dynamic>>[];

  for (int i = 0; i < searchInputs.length; i++) {
    // 1. Get Term and Mode from your existing input
    final term = searchInputs[i][0];
    final mode = searchInputs[i][1];

    // 2. Get corresponding Rules (POS) and Tags, or null if not provided
    // This allows you to pass specific filters for specific terms
    final ruleSet = (pos != null && i < pos.length) ? pos[i] : null;
    final tagSet = (tags != null && i < tags.length) ? tags[i] : null;

    // 3. Create the [Term, Mode, Rules, Tags] tuple
    mergedList.add([term, mode, ruleSet, tagSet]);
  }

  return jsonEncode(mergedList);
}

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
  DictionarySearchContext ctx,
  Stopwatch s,
) {
    print("=== Dictionary Search Debug Info ===");
    print("Input Term: ${params.query}");
    print("Normalized Search: ${params.normalizedSearch}");
    print("Deconjugation Search: ${params.deconjugationSearch}");
    print("Spellfix Search: ${params.spellfixSearch}");
    print("Normalized Terms: ${ctx.normalizedTerms}");
    print("Term Variants (Deconjugated): ${ctx.termVariants.map((e) => e.deconjugatedTerm).toList()}");
    print("Spelling Variations: ${ctx.spellingVariations}");
    print("Is Wildcard Search: ${ctx.isWildcardSearch}");
    print("Indexes to Include: ${params.indexesToInclude}");
    print("Grouping Rules: ${params.groupingRules}");
    print("Tag Filters: ${ctx.tags}");
    print("Filters: ${ctx.filterParams}");
    print("Search setup complete in ${s.elapsedMilliseconds}ms");
    print("====================================");
  }