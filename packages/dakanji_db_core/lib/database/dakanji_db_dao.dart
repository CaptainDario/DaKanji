// Package imports:
import "package:dakanji_db_core/database/db_queries/dictionary_search_result.dart";
import "package:dakanji_db_core/database/term/term_bank_v3_entry.dart";
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

  Future<DictionarySearchResults> dictionarySearch(
    String term,
    List<Iso639_1> languages,
    List<String> tags,
    bool convertRomajiToHiragana,
    {
      int limit=-1,
      int offset=0
    }
  ) async {

    final (:hiraganaTerm, term: preprocessedTerm) =
      preprocessInput(term, convertRomajiToHiragana);

    // check laguages are set and parse 
    assert (languages.isNotEmpty);
    List<String> langs = languages.map((e) => e.name).toList();

    List<DictionarySearchFts5DriftResult> driftResults =
      (await db.dictionary_search_fts5_drift(term, "$term *").get());

    List<DictionarySearchResult> exactMatches = [], prefixMatches = [], tokenMatches = [];
    for (var driftResult in driftResults) {
      DictionarySearchResult r = DictionarySearchResult(
        match: driftResult.highlightedText!,
        entry: TermBankV3Entry.fromSearchTermDriftResult(driftResult)
      );

      if(driftResult.matchTypePriority == 1) exactMatches.add(r);
      else if(driftResult.matchTypePriority == 2) prefixMatches.add(r);
      else if(driftResult.matchTypePriority == 3) tokenMatches.add(r);

    }

    return DictionarySearchResults(
        exactMatchs: exactMatches,
        prefixMatchs: prefixMatches,
        tokenMatchs: [],
        fuzzyMatchs: [],
        wildcardMatchs: []
    );

    
  }
  
}
