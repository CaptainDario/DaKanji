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
  
    final query = (selectOnly(termMetaBankV3Table)
      .join([
        // onyomi
        innerJoin(
          termMetaBankV3TypeTable,
          termMetaBankV3TypeTable.id.equalsExp(termMetaBankV3Table.typeId)
        ),
      ]))
      ..where(db.termMetaBankV3Table.term.isIn(terms))
      ..addColumns([
        db.termMetaBankV3Table.term,
        db.termMetaBankV3TypeTable.type,
        db.termMetaBankV3Table.freqValue,
        db.termMetaBankV3Table.freqDisplayValue
      ]);

    // Fetching data from the query
    final result = await query.get();

    // Process and return the result
    return (await Future.wait(result.map((row) async {

      final term         = row.read<String>(termMetaBankV3Table.term);
      final type         = row.read<String>(termMetaBankV3TypeTable.type);
      final value        = row.read<int>(termMetaBankV3Table.freqValue);
      final displayValue = row.read<String>(termMetaBankV3Table.freqDisplayValue);

      return TermMetaBankV3Entry(
        term: term!,
        type: type!,
        value: value,
        displayValue: displayValue
      );
    }))).toList();

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