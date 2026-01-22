import "package:dakanji_db_core/database/db_queries/kanji_dictionary_search/kanji_dictionary_search_result.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part "kanji_search_dao.g.dart";

@DriftAccessor()
class KanjiSearchDao extends DatabaseAccessor<DaKanjiDB> with _$KanjiSearchDaoMixin {
  
  KanjiSearchDao(super.db);
  
  /// Search for kanji dictionary entries matching any of the given kanjis.
  Future<List<KanjiDictionarySearchResult>> kanjiDictionarySearch(List<String> kanjis) async {

    if(kanjis.isEmpty) return [];

    // run the query
    final searchResults = await db.kanji_dictionary_search_drift(kanjis).get();
    final convertedResults = searchResults.map((result) =>
      KanjiDictionarySearchResult.fromKanjiDictionarySearchViewData(result)
    ).toList();

    return convertedResults;

  }
}