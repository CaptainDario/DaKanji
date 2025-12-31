import 'dart:convert';

/// Parses special argument syntax from raw input strings.
/// 
/// The expected format is:
/// `?t=termFilter&r=readingFilter&d=definitionFilter`
/// 
/// Returns a tuple containing the extracted filters:
/// - termFilter: Filter for terms (nullable)
/// - readingFilter: Filter for readings (nullable)
/// - definitionFilter: Filter for definitions (nullable)
/// If the input does not match the expected format, returns null.
({String? term, String? reading, String? definition})? argumentParser(String raw) {

  if(!raw.startsWith("?") || ["t=", "r=", "d="].any((e) => raw.contains(e)) == false) {
    return null;
  }

  final uri = Uri.parse("x:$raw"); 
  final filters = uri.queryParameters;

  String? termFilter = filters['t'];    // extract term filter
  String? readingFilter = filters['r']; // extract reading filter
  String? defFilter = filters['d'];     // extract definition filter

  return (
    term: termFilter,
    reading: readingFilter,
    definition: defFilter
  );

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

