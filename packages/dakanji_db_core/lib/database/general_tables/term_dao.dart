// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/general_tables/term_tables.dart";
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

  // ---------------------------------------------------------------------------
  /// Get all terms and their ids 
  Future<List<TermTableData>> getAllTerms() async {
    return await select(termTable).get();
  }

  // ---------------------------------------------------------------------------
  /// Get the maximum id of the term table
  Future<int> maxTermId() async {
    
    final query = await (selectOnly(termTable)
        ..addColumns([termTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termTable.id.max()) ?? 0;

  }
  
}
