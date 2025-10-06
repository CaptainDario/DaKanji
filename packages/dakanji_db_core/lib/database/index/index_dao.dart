// Package imports:
import "package:drift/drift.dart";

// Project imports:
import "/database/index/index_tables.dart";
import "../dakanji_db.dart";

part 'index_dao.g.dart';



/// Class that contains all queries for the dictionary index table
@DriftAccessor(tables: [IndexTable])
class IndexDao extends DatabaseAccessor<DaKanjiDB> with _$IndexDaoMixin {
  
  // this constructor is required so that the main database can create an
  // instance of this object.
  IndexDao(super.db);

  /// returns the entry with `title` if found otherwise `null`
  Future<IndexTableData?> getByTitle(String title) async {

    final query = select(db.indexTable)..where((tbl) => tbl.title.equals(title));

    // Fetch the first result that matches the condition
    final result = query.getSingleOrNull();

    return result;

  }

  /// returns the entry with `id` if found otherwise `null`
  Future<IndexTableData?> getById(int id) async {

    final query = select(db.indexTable)..where((tbl) => tbl.id.equals(id));

    // Fetch the first result that matches the condition
    final result = query.getSingleOrNull();

    return result;

  }
  
}
