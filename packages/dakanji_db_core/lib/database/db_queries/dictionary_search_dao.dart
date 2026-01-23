import "dart:convert";

import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_params.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_util.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/grouping_rules.dart";
import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";
import "package:language_processing/japanese/conjugation/yomitan_deconjugate.dart";
import "package:language_processing/japanese/japanese_string_operations.dart";
import "package:language_processing/japanese/spellfix/spellfix.dart";

import "../dakanji_db.dart";

part "dictionary_search_dao.g.dart";

@DriftAccessor()
class DictionarySearchDao extends DatabaseAccessor<DaKanjiDB> with _$DictionarySearchDaoMixin {
  
  DictionarySearchDao(super.db);

  /// Searches the dictionary for the given [term] with various options.
  /// Read the documentation of [DictionarySearchParams] for details on each
  /// parameter.
  /// 
  //// [printDebugInfo] can be used to print debug information.
  Future<DictionarySearchResult> dictionarySearch(
    DictionarySearchParams dictionarySearchParams,
    {
      bool printDebugInfo = false,
    }) async {

    Stopwatch endToEndStopwatch = Stopwatch()..start();

    DictionarySearchParams sP = dictionarySearchParams;

    assert(([
      sP.indexesToInclude != null,
      sP.useOnlyEnabledIndexes,
      sP.useOnlyDefaultIndexes
    ].where((e) => e).length <= 1),
      "You can only use one of 'indexesToInclude', 'useOnlyEnabledDictionaries' or 'useOnlyDefaultDictionaries' at a time."
    );

    // Get all enabled indexes if set
    if(sP.useOnlyEnabledIndexes) 
      sP.indexesToInclude = (await db.indexDao.getAllEnabledIndexes())
        .map((e) => e.id).toList();
    // Get all default indexes if set
    if(sP.useOnlyDefaultIndexes) 
      sP.indexesToInclude = (await db.indexDao.getAllDefaultIndexes())
        .map((e) => e.id).toList();

    // Check for special argument syntax
    var filterParams = argumentParser(sP.query);

    // Preprocess input term (normalize, deconjugate, spellfix)
    var (:normalizedTerms, :termVariants) = preprocessInput(
      sP.query, sP.normalizedSearchConvertsRomajiToHiragana);
    List<String> spellingVariations = [];
    if(sP.spellfixSearch)
      spellingVariations = normalizedTerms.expand((e) => 
        generateSpellingVariations(word: e, n: sP.spellfixMaxResults, maxCost: sP.spellfixMaxCost)
      ).toList();
    
    bool isWildcardSearch = false;
    if(filterParams == null) isWildcardSearch = sP.query.contains(RegExp(r'[*?\[\]]'));

    if(printDebugInfo) printDictionarySearchDebugInfo(
      sP, normalizedTerms, termVariants, spellingVariations, isWildcardSearch, endToEndStopwatch);
    
    Stopwatch s = Stopwatch()..start();
    // Kanji lookup for single-character searches
    List<KanjiDictionarySearchResult> kanjiResults = [];
    if(sP.query.length == 1 && kanjiRegex.hasMatch(sP.query)) {
      kanjiResults = await db.kanjiSearchDao.kanjiDictionarySearch([sP.query]);
      print("Kanji lookup took ${s.elapsedMilliseconds}ms, found ${kanjiResults.length} entries.");
    }

    // 1. Run the lightweight search queries in parallel (IDs only)
    (s..reset()).start();
    final resultsRaw = await _runAllFindTermbankEntries(
      sP, filterParams: filterParams,
      normalizedTerms, termVariants, spellingVariations,
      isWildcardSearch: isWildcardSearch,
    );
    if(printDebugInfo)print("Phase 1 (Search IDs) completed in ${s.elapsedMilliseconds}ms.");

    // 2. Aggregate unique IDs and perform sequence lookups if needed
    (s..reset()).start();
    final (allTermBankIds, sequenceMatches) = await _aggregateUniqueIdsAndSequenceNumbers(
      resultsRaw, sP.groupingRules);
    if(printDebugInfo) print("Phase 2 (sequence lookup) conpleted in ${allTermBankIds.length}");

    // 3. Fetch details for ALL unique IDs found in any step
    (s..reset()).start();
    List<DictionarySearchDriftFindTermBankDetailsResult> allDetails = [];
    if (allTermBankIds.isNotEmpty) {
      allDetails = await db.dictionary_search_drift_find_term_bank_details(
        jsonEncode(allTermBankIds.toList())).get();
    }
    if(printDebugInfo){
      print("Phase 3 (Detail fetching) completed in ${s.elapsedMilliseconds}ms. Fetched details for ${allDetails.length} entries.");

    }
    s.stop();
    
    // 5. Assemble the result
    return DictionarySearchResult.fromSearchResults(
      kanjiResults: kanjiResults,
      resultsRaw: resultsRaw,
      sequenceMatches: sequenceMatches,
      allDetails: allDetails,
      isWildcardSearch: isWildcardSearch,
      groupingRules: sP.groupingRules,
    );
  }

  /// Aggregates all unique term bank IDs from the initial search results and
  /// performs specific sequence lookups based on the provided [groupingRules].
  ///
  /// This method performs two main tasks:
  /// 1. Collects all `termBankId`s from [resultsRaw] into a Set to ensure
  ///    we fetch details for every found entry.
  /// 2. Iterates through any [SequenceGroupingRule]s. For each rule:
  ///    - Finds entries in [resultsRaw] that belong to the rule's `primaryDictId`.
  ///    - Generates specific lookup pairs (Seq # + Target Dict ID).
  ///    - Queries the database for these precise pairs to prevent cross-dictionary contamination.
  ///
  /// Returns a tuple containing:
  /// - [allTermBankIds]: The complete set of IDs to fetch details for.
  /// - [sequenceMatches]: The list of additional entries found via sequence expansion.
  Future<(Set<int> allTermBankIds, List<DictionarySearchDriftFindTermBankSequencesByPairsResult> sequenceMatches)>
    _aggregateUniqueIdsAndSequenceNumbers(
      List<List<DictionarySearchDriftFindTermBankEntriesResult>> resultsRaw,
      List<DictionaryGroupingRule> groupingRules,
  ) 
  async {
    final Set<int> allTermBankIds = {};
    final List<DictionarySearchDriftFindTermBankSequencesByPairsResult> allSequenceMatches = [];

    // 1. Collect IDs from the initial text search (Phase 1)
    for (final group in resultsRaw) {
      for (final entry in group) {
        allTermBankIds.add(entry.termBankId);
      }
    }

    // 2. Process Sequence Grouping Rules
    // Process each rule independently to ensure that sequence IDs from one
    // source dictionary don't incorrectly trigger matches in unrelated targets.
    for (final rule in groupingRules.whereType<SequenceGroupingRule>()) {
      final Set<int> sourceSequenceNumbers = {};

      // Find sequences in the raw results that match this rule's Source Dictionary
      for (final group in resultsRaw) {
        for (final entry in group) {
          if (entry.indexId == rule.sourceDictId) {
            sourceSequenceNumbers.add(entry.sequenceNumber);
          }
        }
      }

      // If source sequences found, fetch the corresponding targets
      if (sourceSequenceNumbers.isNotEmpty && rule.targetDictIds.isNotEmpty) {
        
        // 1. Construct the precise pairs: (Sequence + TargetDictionary)
        // This creates a cross-product of (Found Sequences) x (Target Dictionaries)
        final List<Map<String, int>> lookupPairs = [];
        for (final seq in sourceSequenceNumbers) {
          for (final targetId in rule.targetDictIds) {
            lookupPairs.add({'s': seq, 'd': targetId});
          }
        }

        // 2. Pass the pairs list to the database to ensure to only get 
        // Seq X from Dict Y, not Seq X from Dict Z.
        if (lookupPairs.isNotEmpty) {
          final matches = await db.dictionary_search_drift_find_term_bank_sequences_by_pairs(
            jsonEncode(lookupPairs),             // Arg 1: The Pairs [{"s":1, "d":2}, ...]
            jsonEncode(allTermBankIds.toList()), // Arg 2: IDs to exclude (already found)
          ).get();

          if (matches.isNotEmpty) {
            allSequenceMatches.addAll(matches);
            // Add the new IDs to the set to fetch details for them later
            allTermBankIds.addAll(matches.map((e) => e.termBankId));
          }
        }
      }
    }

    return (allTermBankIds, allSequenceMatches);
  }

  /// Helper method to run the parallel termBankId-search (all 4 queries):
  ///   1. Exact match
  ///   2. Normalized match
  ///   3. Deconjugated variants
  ///   4. Spellfix / fuzzy match
  /// Returns a list of 4 lists, each containing the results of one query.
  Future<List<List<DictionarySearchDriftFindTermBankEntriesResult>>> _runAllFindTermbankEntries(
    DictionarySearchParams dictionarySearchParams,
    List<String> normalizedTerms,
    List<DeconjugationResult> termVariants,
    List<String> spellingVariations,
    {
      required bool isWildcardSearch,
      ({String? term, String? reading, String? definition})? filterParams,
    }
  ) async {

    DictionarySearchParams sP = dictionarySearchParams;

    final exactTerms = filterParams != null
      ? [filterParams.term, filterParams.reading, filterParams.definition].nonNulls.toList()
      : [sP.query];

    return await Future.wait([
      // exact query
      _findTermBankEntries(
        terms: exactTerms,
        tags: List.filled(exactTerms.length, sP.tags),
        pos: List.filled(exactTerms.length, sP.pos),
        filterParams: filterParams,
        useGlob: isWildcardSearch, searchNormalized: false,
        indexesToInclude: sP.indexesToInclude,
        limit: sP.limit, offset: sP.offset,
      ),
      // normalized terms
      sP.normalizedSearch && filterParams == null
        ? _findTermBankEntries(
          terms: normalizedTerms,
          tags: List.filled(normalizedTerms.length, sP.tags),
          pos: List.filled(normalizedTerms.length, sP.pos),
          useGlob: isWildcardSearch, searchNormalized: true,
          indexesToInclude: sP.indexesToInclude,
          limit: sP.limit, offset: sP.offset,
        )
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[]),
      // term variants (deconjugated forms)
      sP.deconjugationSearch && filterParams == null
        ? _findTermBankEntries(
          terms: termVariants.map((e) => e.deconjugatedTerm).toList(),
          tags: List.filled(termVariants.length, sP.tags),
          pos: termVariants.map((e) => sP.pos+e.requiredPartsOfSpeech).toList(),
          useGlob: isWildcardSearch, searchNormalized: true,
          indexesToInclude: sP.indexesToInclude,
          limit: sP.limit, offset: sP.offset,
        )
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[]),
      // spellfix / fuzzy search
      sP.spellfixSearch && filterParams == null
        ? _findTermBankEntries(
          terms: spellingVariations,
          tags: List.filled(spellingVariations.length, sP.tags),
          pos: List.filled(spellingVariations.length, sP.pos),
          useGlob: isWildcardSearch, searchNormalized: true,
          indexesToInclude: sP.indexesToInclude,
          limit: sP.limit, offset: sP.offset,
        )
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[])
    ]);
  }

    /// Helper method to run ONLY the ID search (Query 1)
  Future<List<DictionarySearchDriftFindTermBankEntriesResult>> _findTermBankEntries(
    {
    required List<String> terms,
    required bool useGlob,
    required bool searchNormalized,
    List<List<String>> tags = const [],
    List<List<String>> pos = const [],
    ({String? term, String? reading, String? definition})? filterParams,
    List<int>? indexesToInclude = const [],
    int limit = -1,
    int offset = 0,
  }) async {

    if (terms.isEmpty) return [];

    // only run prefix search for terms longer than 2 characters or containing kanji
    List<List<dynamic>> searchInputs = [];
    for (final term in terms) {
      int runPrefixSearch = term.length > 1 || kanjiRegex.hasMatch(term) ? 1 : 0;
      searchInputs.add([term, runPrefixSearch]);
    }

    return await db.dictionary_search_drift_find_term_bank_entries(
      buildSearchInputJson(searchInputs, tags: tags, pos: pos),
      jsonEncode(indexesToInclude ?? []),
      useGlob ? 1 : 0,
      searchNormalized ? 1 : 0,
      filterParams?.term, filterParams?.reading, filterParams?.definition,
      indexesToInclude == null ? 0 : 1,
      limit, offset
    ).get();
  }


}


