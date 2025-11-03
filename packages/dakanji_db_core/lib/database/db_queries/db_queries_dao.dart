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

      bool joinSequences=false,
      bool joinOnTermAndReading=false,
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
    final emptyResult = (<DictionarySearchDriftFindTermBankEntriesResult>[], <DictionarySearchDriftFindTermBankDetailsResult>[]);
    final results = (await Future.wait([
      // exact query
      _querySQLite([term], tags, useGlobInt, 0),
      // normalized terms
      normalizedSearch ? _querySQLite(normalizedTerms, tags, useGlobInt, 1)
        : Future.value(emptyResult),
      // term variants (deconjugated forms)
      deconjugationSearch ? _querySQLite(termVariants.map((e) => e.deconjugatedTerm).toList(), tags, useGlobInt, 1)
        : Future.value(emptyResult),
      // spellfix / fuzzy search
      spellfixSearch ? _querySQLite(spellingVariations, tags, useGlobInt, 1)
        : Future.value(emptyResult)
    ]));
    
    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionarySearch(
        results[0], isWildcardSearch).firstOrNull ?? SearchMatchGroup.empty(),
      normalizedQueryMatchGroups: SearchMatchGroup.fromDictionarySearch(
        results[1], isWildcardSearch),
      queryVariantMatches: SearchMatchGroup.fromDictionarySearch(
        results[2], isWildcardSearch),
      fuzzyMatches: SearchMatchGroup.fromDictionarySearch(
        results[3], isWildcardSearch)
    );

    
  }

  /// Helper method to run the the SQLite queries for term, normalized terms, 
  /// variants and sllfix searches in parallel (async)
  Future<(
    List<DictionarySearchDriftFindTermBankEntriesResult> results,
    List<DictionarySearchDriftFindTermBankDetailsResult> resultDetails
  )> _querySQLite(
    List<String> terms,
    List<String> tags,
    int useGlob,
    int searchNormalized
  ) async {

    // 1. Run Query 1 to get matching term bank entries
    final searchResults = await db.dictionary_search_drift_find_term_bank_entries(
      jsonEncode(terms),
      jsonEncode(tags),
      useGlob,
      searchNormalized
    ).get();

    // 2. Run Query 2 to get details for all results from Query 1
    List<DictionarySearchDriftFindTermBankDetailsResult> details;
    if (searchResults.isEmpty) details = <DictionarySearchDriftFindTermBankDetailsResult>[];
    else {
      final idJson = jsonEncode(searchResults.map((e) => e.termBankId).toList());
      details = await db.dictionary_search_drift_find_term_bank_details(idJson).get();
    }
    return (searchResults, details);

  }

  

}