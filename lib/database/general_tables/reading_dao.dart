import "package:dakanji_db/database/general_tables/reading_tables.dart";
import "package:drift/drift.dart";

import "../dakanji_db.dart";

part 'reading_dao.g.dart';



// Dao class that contains all queries related to the `ReadingTable`
@DriftAccessor(tables: [
  ReadingTable
])
class ReadingDao extends DatabaseAccessor<DaKanjiDB> with _$ReadingDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  ReadingDao(super.db);

  /// Get all terms and their ids 
  Future<List<ReadingTableData>> getAllTerms() async {
    return await select(readingTable).get();
  }
  
}