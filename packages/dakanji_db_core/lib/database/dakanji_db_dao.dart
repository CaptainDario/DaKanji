import "dart:async";
import "dart:convert";
// Package imports:
import "package:collection/collection.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search_result.dart";
import "package:dakanji_db_core/database/db_queries/dictionary_search_utils.dart";
import "package:drift/drift.dart";
import "package:language_processing/iso/iso_table.dart";

// Project imports:
import "dakanji_db.dart";

part 'dakanji_db_dao.g.dart';

// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor()
class DaKanjiDBDao extends DatabaseAccessor<DaKanjiDB> with _$DaKanjiDBDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  DaKanjiDBDao(super.db);

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

    final (:hiraganaTerm, :termVariants) = preprocessInput(term, convertRomajiToHiragana);
    print("$term -> $hiraganaTerm, $termVariants");

    // check laguages are set and parse 
    assert (languages.isNotEmpty);
    List<String> langs = languages.map((e) => e.name).toList();

    bool isWildcardSearch = term.contains(RegExp(r'\*|\?'));
    int useGlobInt = isWildcardSearch ? 1 : 0;

    // run the queries in parallel
    final results = (await Future.wait([
      db.dictionary_search_fts5_drift(term, spellfixDistance, useGlobInt,
                                      "$term *", "[]").get(),

      if(hiraganaTerm != null)
        db.dictionary_search_fts5_drift(hiraganaTerm, spellfixDistance, useGlobInt,
                                      "$hiraganaTerm *", "[]").get(),
      if(hiraganaTerm == null) Future.sync(() => <DictionarySearchFts5DriftResult>[]),
      
      if(termVariants != null && !isWildcardSearch)
        for (final variant in termVariants) 
          db.dictionary_search_fts5_drift(
            variant.deconjugatedTerm, 0, useGlobInt, "${variant.deconjugatedTerm} *",
            jsonEncode(variant.requiredPartsOfSpeech) 
          ).get()
    ]));

    print("RRRRRRRRRESULTS $results");

    // process all variant search results
    List<SearchMatchGroup> filteredQueryVariantMatches = [];
    final queryVariantMatches = results.length > 2 ? results.sublist(2) : [];
    for (var i = 0; i < queryVariantMatches.length; i++) {
      if(results[i+2].isNotEmpty) {
        filteredQueryVariantMatches.add(SearchMatchGroup.fromDictionaryMatchList(
          results[i+2], termVariants![i].deconjugatedTerm, isWildcardSearch,
          variantReason: termVariants[i].transformRules.join(" -> ")
        ));
      }
    }

    return DictionarySearchResult(
      queryMatches: SearchMatchGroup.fromDictionaryMatchList(results[0], term, isWildcardSearch),
      hiraganaQueryMatches: results.length >= 2 && results[1].isNotEmpty
        ? SearchMatchGroup.fromDictionaryMatchList(results[1], hiraganaTerm!, isWildcardSearch)
        : SearchMatchGroup.empty(),
      queryVariantMatches: filteredQueryVariantMatches
    );

    
  }
  
}
