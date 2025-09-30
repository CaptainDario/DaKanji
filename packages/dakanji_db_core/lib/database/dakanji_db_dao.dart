import "dart:async";
// Package imports:
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
      int offset=0
    }
  ) async {

    final (:hiraganaTerm, :termVariants) = preprocessInput(term, convertRomajiToHiragana);
    print("$term -> $hiraganaTerm, $termVariants");

    // check laguages are set and parse 
    assert (languages.isNotEmpty);
    List<String> langs = languages.map((e) => e.name).toList();

    // run the queries in parallel
    final results = await Future.wait([
      db.dictionary_search_fts5_drift(term, "$term *").get(),
      if(hiraganaTerm != null) db.dictionary_search_fts5_drift(hiraganaTerm, "$hiraganaTerm *").get()
    ]);

    return DictionarySearchResult(
      termMatches: SearchMatchGroup.fromDictionaryMatchList(results[0]),
      hiraganaMatches: results.length >= 2
        ? SearchMatchGroup.fromDictionaryMatchList(results[1])
        : SearchMatchGroup.empty(),
      variantTermMatches: results.length >= 3 
        ? results.sublist(2).map(
          (r) => SearchMatchGroup.fromDictionaryMatchList(r)
        ).toList()
        : []
    );

    
  }
  
}
