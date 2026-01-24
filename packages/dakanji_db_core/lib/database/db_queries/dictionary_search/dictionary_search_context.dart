import 'package:language_processing/japanese/conjugation/yomitan_deconjugate.dart';



class DictionarySearchContext {

  /// The cleaned query
  ///   - tags have been removed
  String cleanedQuery = "";

  /// List of tag-filters to apply to all search results extracted from the
  /// query
  List<String> tags = [];
  /// List of part-of-speech filters to apply to all search results
  List<String> pos = [];


  String? definitionFilter;
  String? readingFilter;
  String? termFilter;

  ({String? term, String? reading, String? definition})? get filterParams {
    
    if(termFilter == null && readingFilter == null && definitionFilter == null) {
      return null;
    }
    
    return (
      definition: definitionFilter,
      reading: readingFilter,
      term: termFilter
    );
  }

  List<String> get nonNullFilterParams {
    return [termFilter, readingFilter, definitionFilter]
      .whereType<String>().toList();
  }

  /// Returns the prioritized list of terms to search for.
  List<String> get lookupTerms => filterParams != null
    ? nonNullFilterParams
    : [cleanedQuery];

  List<String> normalizedTerms = [];
  List<DeconjugationResult> termVariants = [];

  /// All spelling variations generated for spellfix search
  List<String> spellingVariations = [];


  bool isWildcardSearch = false;


  DictionarySearchContext();

  void applyExtractTagsAndPosResult(
    ({List<String> tags, List<String> pos, String cleanedQuery}) extracted) {
    tags = extracted.tags;
    pos = extracted.pos;
    cleanedQuery = extracted.cleanedQuery;
  }

  void applyArgumentParserResult(({String? term, String? reading, String? definition})? filterParams) {
    if (filterParams == null) return;
    termFilter = filterParams.term;
    readingFilter = filterParams.reading;
    definitionFilter = filterParams.definition;
  }

  void applyPreprocessInputResult(({
    List<String> normalizedTerms,
    List<DeconjugationResult> termVariants
  }) result) {
    normalizedTerms = result.normalizedTerms;
    termVariants = result.termVariants;
  }

}