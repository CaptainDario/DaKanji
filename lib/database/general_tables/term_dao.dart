// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "package:dakanji_db/database/general_tables/kanji_tables.dart";
import "package:dakanji_db/database/general_tables/term_tables.dart";
import "../dakanji_db.dart";

part 'term_dao.g.dart';



// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor(tables: [
  TermTable
])
class TermDao extends DatabaseAccessor<DaKanjiDB> with _$TermDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  TermDao(super.db);

  /// Get all terms and their ids 
  Future<List<TermTableData>> getAllTerms() async {
    return await select(termTable).get();
  }
  
}
