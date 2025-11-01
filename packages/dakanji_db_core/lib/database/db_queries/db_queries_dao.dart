import "dart:convert";

import "package:dakanji_db_core/database/audio/audio_entry.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart";
import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";

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

  String buildQueryFilters(
    List<String> terms, List<List<String>> posTags
  ){
    List<Map<String, dynamic> > queryFilters = [];

    assert(terms.length == posTags.length);

    for (int i = 0; i < terms.length; i++) {
      queryFilters.add({
        "term": terms[i],
        "pos": posTags[i],
      });
    }

    return jsonEncode(queryFilters);
  }

  Future<DictionarySearchResult> dictionarySearch(
    String term,
    List<String> tags,
    bool convertRomajiToHiragana,
    {
      int limit=-1,
      int offset=0,
      int spellfixDistance = 150,
    }
  ) async {

    var (:normalizedTerms, :termVariants) = preprocessInput(term, convertRomajiToHiragana);
    
    bool isWildcardSearch = term.contains(RegExp(r'\*|\?'));
    int useGlobInt = isWildcardSearch ? 1 : 0;

    print("Searching $term (normalized: $normalizedTerms, variants: $termVariants)");

    // run the queries in parallel
    final results = (await Future.wait([

      _querySQLite([term], tags, useGlobInt, 0),
      _querySQLite(normalizedTerms, tags, useGlobInt, 1),
      _querySQLite(
        termVariants.map((e) => e.deconjugatedTerm).toList(), tags, useGlobInt, 1)
    ]));

    print("RESULTS: ${results}");


    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionarySearch(
        results[0], isWildcardSearch).firstOrNull ?? SearchMatchGroup.empty(),
      normalizedQueryMatchGroups: SearchMatchGroup.fromDictionarySearch(
        results[1], isWildcardSearch),
      queryVariantMatches: SearchMatchGroup.fromDictionarySearch(
        results[2], isWildcardSearch),
      fuzzyMatches: []
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