// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/general_tables/reading_tables.dart";
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

  /// Get all readings and their ids 
  Future<List<ReadingTableData>> getAllReadings() async {
    return await select(readingTable).get();
  }
  
  /// Get the maximum id of the reading table
  Future<int> maxReadingId() async {
    
    final query = await (selectOnly(readingTable)
        ..addColumns([readingTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(readingTable.id.max()) ?? 0;

  }

}
