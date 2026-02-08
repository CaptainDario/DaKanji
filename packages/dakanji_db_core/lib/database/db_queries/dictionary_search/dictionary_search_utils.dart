import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_context.dart';
import 'package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart';
import 'package:language_processing/language_processing.dart';


/// Parses special argument syntax from raw input strings.
/// 
/// The expected format is:
/// `?t=termFilter&r=readingFilter&d=definitionFilter #tag1 #tag2`
/// OR
/// `?q=query1&q=query2`
/// 
/// Returns:
/// - searchQueries: List of terms to search for (from 'q')
/// - termFilter: Filter for terms (from 't') - DOES NOT SEARCH, ONLY FILTERS
/// - readingFilter: Filter for readings (from 'r')
/// - definitionFilter: Filter for definitions (from 'd')
({
  List<String>? searchQueries,
  ({
    String? termFilter,
    String? readingFilter,
    String? definitionFilter,
  })? filters
})
argumentParser(String raw) {
  
  if (raw.startsWith("?")) {
    // We prepend "x:" to make it a valid URI so we can parse the query part.
    // Dart's Uri parser handles decoding (e.g. %20 -> space) automatically.
    final uri = Uri.tryParse("x:$raw");
    
    if (uri != null && uri.queryParameters.isNotEmpty) {
      return (
        searchQueries: uri.queryParametersAll['q'],
        filters: (
          termFilter: uri.queryParameters['t'],
          readingFilter: uri.queryParameters['r'],
          definitionFilter: uri.queryParameters['d'],
        )
      );
    }
  }

  return (searchQueries: null, filters: null);
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


/// Preprocesses the input terms for searching.
/// Standardize full-width / half-width
///   * For kana everything is converted to full-width
///   * For romaji everything is converted to half-width
/// and optionally converts romaji to hiragana (if `convertRomajiToHiragana` is
/// true).
/// 
/// Returns
/// - `normalizedTerms`: All possible normalized terms
/// - `deconjugatedTerms`: A list of found deconjugations of the input term
List<({List<String> normalizedTerms, List<DeconjugationResult> termVariants})> 
  normalizeAndDeconjugate(
    List<String> searchTerms,
    LanguageProcessor processor,
    ProcessorOptions options
  ) {

  // Get Normalized Terms
  final normalized = processor.normalizeAll(searchTerms, options);

  // Prepare Targets for Deconjugation
  final targets = {...searchTerms, ...normalized}.toList();

  // Get Deconjugated Variants
  final variants = processor.deconjugateAll(targets);

  return [
    (
      normalizedTerms: normalized,
      termVariants: variants.flattened.toSet().toList()
    )
  ];
}

/// Constructs the JSON string for dictionary search.
/// 
/// [searchInputs]: List of `[term, mode]`. Example: `[['eat', 0], ['eating', 0]]`
/// [rules]: Optional list of rule (pos) lists per term. Example: `[['v1'], ['n']]`
/// [tags]: Optional list of tag lists per term. Example: `[[], ['common']]`
String buildSearchInputJson({
  required List<String> terms,
  List<List<String>>? pos,
  List<List<String>>? tags,
  required LanguageProcessor processor,
}) {
  final mergedList = <List<dynamic>>[];

  // assert all input lists have the same length
  assert({terms.length, ?pos?.length, ?tags?.length}.length == 1,
    "All input lists must have the same length.");

  for (int i = 0; i < terms.length; i++) {

    int runPrefixSearch = 1; // currently not used, but may be useful later
    int onlyFirstTokenMatch =
      (terms[i].length > 1 || processor.isIdeographic(terms[i])) ? 0 : 1;

    mergedList.add(
      [terms[i], runPrefixSearch, onlyFirstTokenMatch, pos?[i], tags?[i]]);
  }

  return jsonEncode(mergedList);
}

/// Helper to print debug information
void printDictionarySearchDebugInfo(
  DictionarySearchParams params,
  DictionarySearchContext ctx,
  Stopwatch s,
) {
    print("=== Dictionary Search Debug Info ===");
    print("Input: ${params.searchInput}");
    print("Search Terms: ${ctx.searchTerms}");
    print("Filter Params: ${ctx.filterParams}");
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
    print("Search setup complete in ${s.elapsedMilliseconds}ms");
    print("====================================");
  }