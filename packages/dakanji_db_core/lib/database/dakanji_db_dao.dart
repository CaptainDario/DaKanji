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

  Future<DictionarySearchResults> searchTerm(
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

    List<TermBankV3Entry> termExactMatches =
      (await db.dictionary_search_fts5_drift(term).get())
      .map((e) => TermBankV3Entry.fromSearchTermDriftResult(e))
      .toList();

    List<TermBankV3Entry> termPrefixMatches =
      (await db.dictionary_search_fts5_drift("$term * NOT $term").get())
      .map((e) => TermBankV3Entry.fromSearchTermDriftResult(e))
      .toList();

    return DictionarySearchResults(
      termMatches: DictionarySearchResult(
        exactMatch: termExactMatches,
        prefixMatch: termPrefixMatches,
        tokenMatch: [],
        wildcardMatch: []
      ),
      hiraganaTermMatches: DictionarySearchResult(
        exactMatch: [],
        prefixMatch: [],
        tokenMatch: [],
        wildcardMatch: []
      ),
      preprocessedTermsMatches: []
    );

    
  }
  
}
