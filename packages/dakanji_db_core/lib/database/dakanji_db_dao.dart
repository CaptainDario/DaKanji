import "dart:async";
import "dart:convert";

import "package:dakanji_db_core/database/audio/audio_entry.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search/dictionary_search_utils.dart";
import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";
import "package:language_processing/iso/iso_table.dart";

import "dakanji_db.dart";

part 'dakanji_db_dao.g.dart';

// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor()
class DaKanjiDBDao extends DatabaseAccessor<DaKanjiDB> with _$DaKanjiDBDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  DaKanjiDBDao(super.db);

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
        db.dictionary_search_drift(term, spellfixDistance, useGlobInt, 0,
                                  "$term *", jsonEncode([]), jsonEncode(tags)).get(),

      if(normalizedTerms.isNotEmpty)
        for (final normalizedTerm in normalizedTerms) 
          db.dictionary_search_drift(normalizedTerm, spellfixDistance, useGlobInt, 1,
                                    "$normalizedTerm *", jsonEncode([]), jsonEncode(tags)).get(),

      
      if(termVariants.isNotEmpty && !isWildcardSearch)
        for (final variant in termVariants) 
          db.dictionary_search_drift(
            variant.deconjugatedTerm, 0, useGlobInt, 1,
            "${variant.deconjugatedTerm} *", jsonEncode(variant.requiredPartsOfSpeech), jsonEncode(tags)
          ).get()
    ]));

    // process all normalized term search results
    List<SearchMatchGroup> filteredQueryNormalizedMatches = [];
    final queryNormalizedMatches = results.length > 1
      ? results.sublist(1, 1+normalizedTerms.length)
      : List<List<DictionarySearchDriftResult>>.from([]);
    for (var i = 0; i < queryNormalizedMatches.length; i++) {
      if(queryNormalizedMatches[i].isNotEmpty) {
        filteredQueryNormalizedMatches.add(SearchMatchGroup.fromDictionaryMatchList(
          queryNormalizedMatches[i],
          normalizedTerms[i],
          isWildcardSearch,
        ));
      }
    }

    // process all variant search results
    List<SearchMatchGroup> filteredQueryVariantMatches = [];
    final queryVariantMatches = results.length > 2
      ? results.sublist(1+normalizedTerms.length)
      : List<List<DictionarySearchDriftResult>>.from([]);
    for (var i = 0; i < queryVariantMatches.length; i++) {
      if(queryVariantMatches[i].isNotEmpty) {
        filteredQueryVariantMatches.add(SearchMatchGroup.fromDictionaryMatchList(
          queryVariantMatches[i],
          termVariants[i].deconjugatedTerm,
          isWildcardSearch,
          variantReason: termVariants[i].transformRules.join(" -> ")
        ));
      }
    }

    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionaryMatchList(results[0], term, isWildcardSearch),
      normalizedQueryMatchGroups: filteredQueryNormalizedMatches,
      queryVariantMatches: filteredQueryVariantMatches
    );

    
  }
  
}
