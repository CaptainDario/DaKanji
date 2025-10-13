// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "package:dakanji_db_core/database/general_tables/media_tables.dart";
import "../dakanji_db.dart";

part 'media_dao.g.dart';



// Dao class that contains all queries related to the `ReadingTable`
@DriftAccessor(tables: [
  MediaTable
])
class MediaDao extends DatabaseAccessor<DaKanjiDB> with _$MediaDaoMixin {
  
  // this constructor is required so that the main database can create an instance
  // of this object.
  MediaDao(super.db);
  
  /// Get the maximum id of the media table
  Future<int> maxMediaId() async {
    
    final query = await (selectOnly(mediaTable)
        ..addColumns([mediaTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(mediaTable.id.max()) ?? 0;

  }

}
