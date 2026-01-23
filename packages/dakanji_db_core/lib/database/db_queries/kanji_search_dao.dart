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
    final ids =
      await db.kanji_dictionary_find_kanji_bank_entries_drift(kanjis)
      .get();
    final details = 
      await db.kanji_dictionary_find_kanji_details_drift(ids).get();
    final convertedResults = details.map((result) =>
      KanjiDictionarySearchResult.fromKanjiDictionarySearchViewData(result)
    ).toList();

    return convertedResults;

  }
}