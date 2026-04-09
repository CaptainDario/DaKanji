import 'package:language_processing/language_processing.dart';



class DictionarySearchContext {

  /// The cleaned search input
  ///   - tags have been removed
  ///   - pos filters have been removed
  String cleanedSearchInput = "";

  /// List of terms to search for extracted from the query
  List<String> searchTerms = [];
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
    return [termFilter, readingFilter, definitionFilter].nonNulls.toList();
  }

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
    cleanedSearchInput = extracted.cleanedQuery;
  }

  void applyArgumentParserResult(({
    List<String>? searchQueries,
    ({
      String? termFilter,
      String? readingFilter,
      String? definitionFilter,
    })? filters
  }) parsed) {
    
    // Handle Filters (if they exist)
    if (parsed.filters != null) {
      termFilter = parsed.filters!.termFilter;
      readingFilter = parsed.filters!.readingFilter;
      definitionFilter = parsed.filters!.definitionFilter;
    }

    // Handle Queries (if they exist)
    if (parsed.searchQueries != null) {
      searchTerms = parsed.searchQueries!;
    }
  }

  void applyPreprocessInputResult(List<({
    List<String> normalizedTerms,
    List<DeconjugationResult> termVariants
  })> result) {

    for (final r in result) {
      normalizedTerms.addAll(r.normalizedTerms);
      termVariants.addAll(r.termVariants);
    }

  }

}