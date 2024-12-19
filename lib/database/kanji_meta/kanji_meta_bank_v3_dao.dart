import "package:dakanji_db/database/kanji_meta/kanji_meta_bank_entry.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";
import "package:dakanji_db/database/kanji_meta/kanji_meta_bank_v3_tables.dart";

part 'kanji_meta_bank_v3_dao.g.dart';



// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [
    KanjiMetaBankV3Table,
])
class KanjiMetaBankV3Dao extends DatabaseAccessor<DaKanjiDB> with _$KanjiMetaBankV3DaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiMetaBankV3Dao(super.db);
  

  /// Returns all kanji entries that match contain any of the given Kanji
  Future<List<KanjiMetaBankV3Entry>?> getKanjiMetaBankEntriesFromKanji(List<String> kanji) async {
  
    /*
    final query = (selectOnly(kanjiMetaBankV3Table)
      .join([
        // onyomi
        innerJoin(
          kanjiMetaBankV3TypeTable,
          kanjiMetaBankV3TypeTable.id.equalsExp(kanjiMetaBankV3Table.typeId)
        ),
      ]))
      ..where(db.kanjiMetaBankV3Table.kanjiId.isIn(kanji))
      ..addColumns([
        db.kanjiMetaBankV3Table.kanjiId,
        db.kanjiMetaBankV3TypeTable.type,
        db.kanjiMetaBankV3Table.freqValue,
        db.kanjiMetaBankV3Table.freqDisplayValue
      ]);

    // Fetching data from the query
    final result = await query.get();

    // Process and return the result
    return (await Future.wait(result.map((row) async {

      final kanji            = row.read<String>(kanjiMetaBankV3Table.kanjiId);
      final type             = row.read<String>(kanjiMetaBankV3TypeTable.type);
      final freqValue        = row.read<int>(kanjiMetaBankV3Table.freqValue);
      final freqDisplayValue = row.read<String>(kanjiMetaBankV3Table.freqDisplayValue);

      return KanjiMetaBankV3Entry(
        kanji: kanji!,
        type: type!,
        freqValue: freqValue,
        freqDisplayValue: freqDisplayValue
      );
    }))).toList();

    */
  }

  // ---------------------------------------------------------------------------
  /// Get all types and their ids 
  Future<List<KanjiMetaBankV3TypeTableData>> getAllTypes() async {
    return await select(kanjiMetaBankV3TypeTable).get();
  }

    // ---------------------------------------------------------------------------
  /// Get the maximum id of the kanji table
  Future<int> maxKanjiMetaBankV3TypeId() async {
    
    final query = await (selectOnly(kanjiMetaBankV3TypeTable)
        ..addColumns([kanjiMetaBankV3TypeTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(kanjiMetaBankV3TypeTable.id.max()) ?? 0;

  }

}