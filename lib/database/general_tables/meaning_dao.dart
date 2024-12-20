import "package:dakanji_db/database/general_tables/meaning_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'meaning_dao.g.dart';



// Dao class that contains all queries related to the `KanjiTable`
@DriftAccessor(tables: [
  MeaningTable
])
class MeaningDao extends DatabaseAccessor<DaKanjiDB> with _$MeaningDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  MeaningDao(super.db);

  /// Get all kanjis and their ids 
  Future<List<MeaningTableData>> getAllMeanings() async {
    return await select(meaningTable).get();
  }

  /// Get the maximum id of the kanji table
  Future<int> maxMeaningId() async {
    
    final query = await (selectOnly(meaningTable)
        ..addColumns([meaningTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(meaningTable.id.max()) ?? 0;

  }
  
}