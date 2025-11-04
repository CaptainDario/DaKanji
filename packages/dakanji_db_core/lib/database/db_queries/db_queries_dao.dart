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

    // run the queries in parallel
    final emptyResult = (<DictionarySearchDriftFindTermBankEntriesResult>[],
      <DictionarySearchDriftFindTermBankSequencesResult>[],
      <DictionarySearchDriftFindTermBankDetailsResult>[]);
    final results = (await Future.wait([
      // exact query
      _querySQLite([term], tags, useGlobInt, 0, groupSequences),
      // normalized terms
      normalizedSearch ? _querySQLite(normalizedTerms, tags, useGlobInt, 1, groupSequences)
        : Future.value(emptyResult),
      // term variants (deconjugated forms)
      deconjugationSearch ? _querySQLite(
        termVariants.map((e) => e.deconjugatedTerm).toList(), tags, useGlobInt, 1, groupSequences)
        : Future.value(emptyResult),
      // spellfix / fuzzy search
      spellfixSearch ? _querySQLite(spellingVariations, tags, useGlobInt, 1, groupSequences)
        : Future.value(emptyResult)
    ]));
    
    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionarySearch(
        results[0], isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading)
        .firstOrNull ?? SearchMatchGroup.empty(),
      normalizedQueryMatchGroups: SearchMatchGroup.fromDictionarySearch(
        results[1], isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading),
      queryVariantMatches: SearchMatchGroup.fromDictionarySearch(
        results[2], isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading),
      fuzzyMatches: SearchMatchGroup.fromDictionarySearch(
        results[3], isWildcardSearch,
        groupSequences: groupSequences, groupByTermAndReading: groupByTermAndReading)
    );

    
  }

  /// Helper method to run the the SQLite queries for term, normalized terms, 
  /// variants and sllfix searches in parallel (async)
  Future<(
    List<DictionarySearchDriftFindTermBankEntriesResult> results,
    List<DictionarySearchDriftFindTermBankSequencesResult> sequenceMatches,
    List<DictionarySearchDriftFindTermBankDetailsResult> resultDetails
  )> _querySQLite(
    List<String> terms,
    List<String> tags,
    int useGlob,
    int searchNormalized,
    bool groupSequences
  ) async {

    // 1. Run Query 1 to get matching term bank entries
    final searchResults = await db.dictionary_search_drift_find_term_bank_entries(
      jsonEncode(terms),
      jsonEncode(tags),
      useGlob,
      searchNormalized
    ).get();

    // Get all term bank entries that belong to any sequence of any of the results
    final foundTermBankIds = searchResults.map((e) => e.termBankId).toSet().toList();
    late final List<DictionarySearchDriftFindTermBankSequencesResult> sequenceMatches;
    if(groupSequences)
      sequenceMatches = await db.dictionary_search_drift_find_term_bank_sequences(
        jsonEncode(searchResults.map((e) => e.sequenceNumber).toSet().toList()), 
        jsonEncode(foundTermBankIds)
      ).get();
    else sequenceMatches = <DictionarySearchDriftFindTermBankSequencesResult>[];

    // Run third query to get details for all results from Query 1
    final getDetailsIds = jsonEncode(foundTermBankIds..addAll(
      sequenceMatches.map((e) => e.termBankId)));
    List<DictionarySearchDriftFindTermBankDetailsResult> details;
    if (searchResults.isEmpty) details = <DictionarySearchDriftFindTermBankDetailsResult>[];
    else {
      details = await db.dictionary_search_drift_find_term_bank_details(getDetailsIds).get();
    }
    return (searchResults, sequenceMatches, details);

  }

}