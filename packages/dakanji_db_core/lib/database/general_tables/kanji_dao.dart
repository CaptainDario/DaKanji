// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/general_tables/kanji_tables.dart";
import "../dakanji_db.dart";

part 'kanji_dao.g.dart';



// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor(tables: [
  KanjiTable
])
class KanjiDao extends DatabaseAccessor<DaKanjiDB> with _$KanjiDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  KanjiDao(super.db);

  /// Get all kanjis and their ids 
  Future<List<KanjiTableData>> getAllKanjis() async {
    return await select(kanjiTable).get();
  }

  /// Get the maximum id of the kanji table
  Future<int> maxKanjiId() async {
    
    final query = await (selectOnly(kanjiTable)
        ..addColumns([kanjiTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(kanjiTable.id.max()) ?? 0;

  }
  
}
