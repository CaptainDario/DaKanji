import "dart:convert";

import "package:dakanji_db_core/database/audio/audio_entry.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart";
import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";
import "package:language_processing/iso/iso_table.dart";

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
    List<Iso639_1> languages,
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

    // run the queries in parallel
    final results = (await Future.wait([

      db.dictionary_search_drift(
        jsonEncode([term])
        //buildQueryFilters([term], [[]]),
        //spellfixDistance,
        //useGlobInt,
        //0,
        //"$term *",
        //jsonEncode(tags)
      ).get(),

      /*if(normalizedTerms.isNotEmpty)
        db.dictionary_search_drift(
          buildQueryFilters(
            normalizedTerms.map((e) => e).toList(),
            normalizedTerms.map((e) => <String>[]).toList(),
          ),
          spellfixDistance,
          useGlobInt,
          1,
          normalizedTerms.map((e) => '$e *').join(" OR "),
          jsonEncode(tags)
        ).get()
      else Future.sync(() => <DictionarySearchDriftResult>[]),*/

      /*if(termVariants.isNotEmpty)
        db.dictionary_search_drift(
          buildQueryFilters(
            termVariants.map((e) => e.deconjugatedTerm).toList(),
            termVariants.map((e) => e.requiredPartsOfSpeech).toList(),
          ),
          0,
          useGlobInt,
          1,
          termVariants.map((e) => "${e.deconjugatedTerm} *").join(" OR "),
          jsonEncode(tags)
        ).get()
      else Future.sync(() => <DictionarySearchDriftResult>[])*/
    ]));

    // merge all normalized search results from the same normalized term
    /*final groupedNormalizedMatches = groupBy(results[1], (result) => result.queryTerm);
    final filteredQueryNormalizedMatches = <SearchMatchGroup>[];
    groupedNormalizedMatches.forEach((term, matches) {
      filteredQueryNormalizedMatches.add(
        SearchMatchGroup.fromDictionaryMatchList(
          matches, term, isWildcardSearch,),
      );
    });

    // merge all variant search results from the same variant term
    final groupedVariantMatches = groupBy(results[2], (result) => result.queryTerm);
    final filteredQueryVariantMatches = <SearchMatchGroup>[];
    groupedVariantMatches.forEach((term, matches) {
      filteredQueryVariantMatches.add(
        SearchMatchGroup.fromDictionaryMatchList(
          matches, term, isWildcardSearch,),
      );
    });*/

    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionaryMatchList(results[0], term, isWildcardSearch),
      normalizedQueryMatchGroups: [], //filteredQueryNormalizedMatches,
      queryVariantMatches: [], //filteredQueryVariantMatches
    );

    
  }

}