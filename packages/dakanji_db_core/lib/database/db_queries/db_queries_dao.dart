import "dart:convert";

import "package:dakanji_db_core/database/audio/audio_entry.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart";
import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";
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
      int spellfixMaxResults=10,
      int limit=-1,
      int offset=0,
    }
  ) async {

    var (:normalizedTerms, :termVariants) = preprocessInput(term, normalizedSearchConvertsRomajiToHiragana);
    List<String> spellingVariations = [];
    if(spellfixSearch)
      spellingVariations = normalizedTerms.expand((e) => 
        generateSpellingVariations(word: e, n: spellfixMaxCost, maxCost: spellfixMaxCost)
      ).toList();
    
    bool isWildcardSearch = term.contains(RegExp(r'\*|\?'));
    int useGlobInt = isWildcardSearch ? 1 : 0;

    Stopwatch s = Stopwatch()..start();

    // 1. Run the lightweight search queries in parallel (IDs only)
    final resultsRaw = await Future.wait([
      // exact query
      _findTermBankEntries([term], tags, useGlobInt, 0),
      // normalized terms
      normalizedSearch ? _findTermBankEntries(normalizedTerms, tags, useGlobInt, 1)
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[]),
      // term variants (deconjugated forms)
      deconjugationSearch
        ? _findTermBankEntries(
          termVariants.map((e) => e.deconjugatedTerm).toList(), tags, useGlobInt, 1)
        : Future.value(<DictionarySearchDriftFindTermBankEntriesResult>[]),
      // spellfix / fuzzy search
      spellfixSearch
        ? _findTermBankEntries(spellingVariations, tags, useGlobInt, 1)
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
    print(searchInputs);

    return await db.dictionary_search_drift_find_term_bank_entries(
      jsonEncode(searchInputs),
      jsonEncode(tags),
      useGlob ? 1 : 0,
      searchNormalized ? 1 : 0,
      limit,
      offset
    ).get();
  }

}