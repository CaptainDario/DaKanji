import "dart:convert";

import "package:dakanji_db_core/database/audio/audio_entry.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart";
import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";
import "package:language_processing/japanese/japanese_string_operations.dart";
import "package:language_processing/japanese/spellfix/spellfix.dart";

import "../dakanji_db.dart";

part "db_queries_dao.g.dart";

@DriftAccessor()
class DBQueriesDao extends DatabaseAccessor<DaKanjiDB> with _$DBQueriesDaoMixin {
  
  DBQueriesDao(super.db);
  
    Future<List<AudioEntry>> audioSearch(String term) async {

    final results = (await db.audio_search_drift(term).get())
      .map((e) => AudioEntry.fromAudioEntryViewData(e))
      .toList();
    
    return results;

  }

  Future<List<KanjiDictionarySearchResult>> kanjiDictionarySearch(List<String> kanjis) async {

    if(kanjis.isEmpty) return [];

    // run the query
    final searchResults = await db.kanji_dictionary_search_drift(kanjis).get();
    final convertedResults = searchResults.map((result) =>
      KanjiDictionarySearchResult.fromKanjiDictionarySearchViewData(result)
    ).toList();

    return convertedResults;

  }

  Future<DictionarySearchResult> dictionarySearch(
    String term,
    {
      required bool normalizedSearch,
      required bool normalizedSearchConvertsRomajiToHiragana,
      required bool deconjugationSearch,
      required bool spellfixSearch,

      List<String> tags = const [],

      bool groupSequences=false,
      bool groupByTermAndReading=false,
      int spellfixMaxCost=10,
      int spellfixMaxResults=20,
      int limit=-1,
      int offset=0,
      List<int>? indexesToInclude,
      bool useOnlyEnabledDictionaries = false,
      bool useOnlyDefaultDictionaries = false,
    }
  ) async {

    assert(([indexesToInclude != null, useOnlyEnabledDictionaries, useOnlyDefaultDictionaries].where((e) => e).length <= 1),
      "You can only use one of 'indexesToInclude', 'useOnlyEnabledDictionaries' or 'useOnlyDefaultDictionaries' at a time."
    );

    // Get all enabled indexes if set
    if(useOnlyEnabledDictionaries) {
      final enabledIndexes = await db.indexDao.getAllEnabledIndexes();
      indexesToInclude = enabledIndexes.map((e) => e.id).toList();
    }
    // Get all default indexes if set
    if(useOnlyDefaultDictionaries) {
      final defaultIndexes = await db.indexDao.getAllDefaultIndexes();
      indexesToInclude = defaultIndexes.map((e) => e.id).toList();
    }

    // Check for special argument syntax
    var params = argumentParser(term);

    // Preprocess input term (normalize, deconjugate, spellfix)
    var (:normalizedTerms, :termVariants) = preprocessInput(term, normalizedSearchConvertsRomajiToHiragana);
    List<String> spellingVariations = [];
    if(spellfixSearch)
      spellingVariations = normalizedTerms.expand((e) => 
        generateSpellingVariations(word: e, n: spellfixMaxResults, maxCost: spellfixMaxCost)
      ).toList();
    
    bool isWildcardSearch = false;
    if(params == null) isWildcardSearch = term.contains(RegExp(r'\*|\?'));

    // 1. Run the lightweight search queries in parallel (IDs only)
    Stopwatch s = Stopwatch()..start();
    final resultsRaw = await Future.wait([
      // exact query
      _findTermBankEntries(
        terms: params != null
          ? [params.$1, params.$2, params.$3].nonNulls.toList()
          : [term],
        tags: tags,
        termFilter: params?.$1,
        readingFilter: params?.$2,
        definitionFilter: params?.$3,
        useGlob: isWildcardSearch,
        searchNormalized: false,
        indexesToInclude: indexesToInclude,
        limit: limit,
        offset: offset,
      ),
      // normalized terms
      normalizedSearch && params == null
        ? _findTermBankEntries(
          terms: normalizedTerms,
          tags: tags,
          useGlob: isWildcardSearch,
          searchNormalized: true,
          indexesToInclude: indexesToInclude,
          limit: limit,
          offset: offset,
        )
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[]),
      // term variants (deconjugated forms)
      deconjugationSearch && params == null
        ? _findTermBankEntries(
          terms: termVariants.map((e) => e.deconjugatedTerm).toList(),
          tags: tags,
          useGlob: isWildcardSearch,
          searchNormalized: true,
          indexesToInclude: indexesToInclude,
          limit: limit,
          offset: offset,
        )
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[]),
      // spellfix / fuzzy search
      spellfixSearch && params == null
        ? _findTermBankEntries(
          terms: spellingVariations,
          tags: tags,
          useGlob: isWildcardSearch,
          searchNormalized: true,
          indexesToInclude: indexesToInclude,
          limit: limit,
          offset: offset,
        )
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[])
    ]);

    print("Phase 1 (Search IDs) completed in ${s.elapsedMilliseconds}ms.");
    s.reset();

    // 2. Aggregate unique IDs and Sequence Numbers to prevent over-fetching details
    final Set<int> allTermBankIds = {};
    final Set<int> allSequenceNumbers = {};

    for (final group in resultsRaw) {
      for (final entry in group) {
        allTermBankIds.add(entry.termBankId);
        if (groupSequences) {
          allSequenceNumbers.add(entry.sequenceNumber);
        }
      }
    }

    // 3. Find Sequences (if enabled)
    List<DictionarySearchDriftFindTermBankSequencesResult> sequenceMatches = [];
    if (groupSequences && allSequenceNumbers.isNotEmpty) {
      sequenceMatches = await db.dictionary_search_drift_find_term_bank_sequences(
        jsonEncode(allSequenceNumbers.toList()), 
        jsonEncode(allTermBankIds.toList()) // Exclude IDs we already found
      ).get();
      
      // Add the newly found sequence IDs to the fetch list
      allTermBankIds.addAll(sequenceMatches.map((e) => e.termBankId));
    }

    // 4. Fetch details for ALL unique IDs found in any step
    List<DictionarySearchDriftFindTermBankDetailsResult> allDetails = [];
    if (allTermBankIds.isNotEmpty) {
      allDetails = await db.dictionary_search_drift_find_term_bank_details(
        jsonEncode(allTermBankIds.toList())
      ).get();
    }

    print("Phase 2 (Details & Sequences) completed in ${s.elapsedMilliseconds}ms. Fetched details for ${allDetails.length} entries.");
    s.stop();
    
    // 5. Assemble the result
    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionarySearch(
        (resultsRaw[0], sequenceMatches, allDetails), isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading)
        .firstOrNull ?? SearchMatchGroup.empty(),
      normalizedQueryMatchGroups: SearchMatchGroup.fromDictionarySearch(
        (resultsRaw[1], sequenceMatches, allDetails), isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading),
      queryVariantMatches: SearchMatchGroup.fromDictionarySearch(
        (resultsRaw[2], sequenceMatches, allDetails), isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading),
      fuzzyMatches: SearchMatchGroup.fromDictionarySearch(
        (resultsRaw[3], sequenceMatches, allDetails), isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading)
    );
  }

  /// Helper method to run ONLY the ID search (Query 1)
  Future<List<DictionarySearchDriftFindTermBankEntriesResult>> _findTermBankEntries({
    required List<String> terms,
    required List<String> tags,
    required bool useGlob,
    required bool searchNormalized,
    String? termFilter,
    String? readingFilter,
    String? definitionFilter,
    List<int>? indexesToInclude = const [],
    int limit = -1,
    int offset = 0,
  }) async {
    if (terms.isEmpty) return [];

    // only run prefix search for terms longer than 2 characters or containing kanji
    List<List<dynamic>> searchInputs = [];
    for (final term in terms) {
      int runPrefixSearch = 0;
      if(term.length > 1 || kanjiRegex.hasMatch(term)) runPrefixSearch = 1;
      
      searchInputs.add([term, runPrefixSearch]);
    }
    print(definitionFilter);

    return await db.dictionary_search_drift_find_term_bank_entries(
      jsonEncode(searchInputs),
      jsonEncode(tags),
      jsonEncode(indexesToInclude ?? []),
      useGlob ? 1 : 0,
      searchNormalized ? 1 : 0,
      termFilter,
      readingFilter,
      definitionFilter,
      indexesToInclude == null ? 0 : 1,
      limit,
      offset
    ).get();
  }

}

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
(String? term, String? reading, String? definition)? argumentParser(String raw) {

  if(!raw.startsWith("?") || ["t=", "r=", "d="].any((e) => raw.contains(e)) == false) {
    return null;
  }

  final uri = Uri.parse("x:$raw"); 
  final filters = uri.queryParameters;

  String? termFilter = filters['t'];    // extract term filter
  String? readingFilter = filters['r']; // extract reading filter
  String? defFilter = filters['d'];     // extract definition filter

  return (
    termFilter,
    readingFilter,
    defFilter
  );

}
