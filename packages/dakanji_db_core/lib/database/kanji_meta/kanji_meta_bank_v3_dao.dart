// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/kanji_meta/kanji_meta_bank_v3_entry.dart";
import "/database/kanji_meta/kanji_meta_bank_v3_tables.dart";
import "../dakanji_db.dart";

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
  Future<List<KanjiMetaBankV3Entry>?> search(String kanji) async {
  
    List<KanjiMetaBankV3EntryViewData> results =
      await db.kanji_meta_bank_v3_search_drift(kanji).get();

    return results.map((e) =>
      KanjiMetaBankV3Entry.fromKanjiMetaBankV3EntryViewData(e)
    ).toList();

  }

  // ---------------------------------------------------------------------------
  /// Get all types and their ids 
  Future<List<KanjiMetaBankV3TypeTableData>> getAllTypes() async {
    return await select(kanjiMetaBankV3TypeTable).get();
  }

    // ---------------------------------------------------------------------------
  /// Get the maximum id of the type table
  Future<int> maxKanjiMetaBankV3TypeId() async {
    
    final query = await (selectOnly(kanjiMetaBankV3TypeTable)
        ..addColumns([kanjiMetaBankV3TypeTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(kanjiMetaBankV3TypeTable.id.max()) ?? 0;

  }

}
