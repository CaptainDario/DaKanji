import "package:dakanji_db/database/term_meta/term_meta_bank_entry.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";
import "package:dakanji_db/database/term_meta/term_meta_bank_v3_tables.dart";

part 'term_meta_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    TermMetaBankV3Table,
])
class TermMetaBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$TermMetaBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  TermMetaBankV3Dao(super.db);
  

  /// Returns all term entries that match contain any of the given terms
  Future<List<TermMetaBankV3Entry>?> getTermMetaBankEntriesFromTerms(List<String> terms) async {
  


  }

  // ---------------------------------------------------------------------------
  /// Get all types and their ids 
  Future<List<TermMetaBankV3TypeTableData>> getAllTypes() async {
    return await select(termMetaBankV3TypeTable).get();
  }

    // ---------------------------------------------------------------------------
  /// Get the maximum id of the kanji table
  Future<int> maxTermMetaBankV3TypeId() async {
    
    final query = await (selectOnly(termMetaBankV3TypeTable)
        ..addColumns([termMetaBankV3TypeTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(termMetaBankV3TypeTable.id.max()) ?? 0;

  }

}