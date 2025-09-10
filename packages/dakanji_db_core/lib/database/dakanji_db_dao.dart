// Package imports:
import "package:dakanji_db_core/database/term/term_bank_v3_entry.dart";
import "package:dakanji_db_core/queries/term_search.dart";
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

  Future<List<TermBankV3Entry>> searchTerm(
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

    List<TermBankV3SearchViewData> t = 
      await db.term_bank_v3_search(preprocessedTerm, limit, offset).get();

    List<TermBankV3Entry> results = t
      .map((e) => TermBankV3Entry.fromTermBankV3SearchViewData(e))
      .toList();

    return results;

    
  }
  
}
