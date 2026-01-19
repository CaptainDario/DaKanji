
import "package:dakanji_db_core/database/index/index_table_entry.dart";
import "package:drift/drift.dart";

import "/database/index/index_tables.dart";
import "../dakanji_db.dart";

part 'index_dao.g.dart';



/// Class that contains all queries for the dictionary index table
@DriftAccessor(tables: [IndexTable])
class IndexDao extends DatabaseAccessor<DaKanjiDB> with _$IndexDaoMixin {
  
  // this constructor is required so that the main database can create an
  // instance of this object.
  IndexDao(super.db);


  /// Set the sorting order of an index (order in which results are displayed)
  Future setSortingOrders(List<int> indexIds, List<int> newSortingOrders) async {

    assert(indexIds.length == newSortingOrders.length);
    
    // do this in a transaction
    await db.transaction(() async {
      for (int i = 0; i < indexIds.length; i++) {
        final updateQuery = update(indexTable)
          ..where((tbl) => tbl.id.equals(indexIds[i]));
        await updateQuery.write(IndexTableCompanion(
          currentSortingOrder: Value(newSortingOrders[i]),
        ));
      }
    });

  }

  /// Enable or disable an index
  Future setEnabled(int indexId, bool enabled) async {

    final updateQuery = update(indexTable)
      ..where((tbl) => tbl.id.equals(indexId));
    await updateQuery.write(IndexTableCompanion(enabled: Value(enabled),));

  }

  /// Get all indexes
  Future<List<IndexEntry>> getAllIndexes() async {
    final query = select(db.indexTable);
    final results = await query.get();

    return results.map((e) => IndexEntry.fromIndexTableData(e)).toList();

  }

  /// Watch all indexes
  Stream<List<IndexEntry>> watchAllIndexes() {
    final query = select(db.indexTable);
    return query.watch().map((e1) => 
      e1.map((e2) => IndexEntry.fromIndexTableData(e2)).toList());
  }

  /// Get all default indexes
  Future<List<IndexEntry>> getAllDefaultIndexes() async {

    final query = select(db.indexTable)
      ..where((tbl) => tbl.isDefaultDictionary.equals(true)); 
    final results = await query.get();

    return results.map((e) => IndexEntry.fromIndexTableData(e)).toList();

  }

  /// Get all enabled indexes
  Future<List<IndexEntry>> getAllEnabledIndexes() async {

    final query = select(db.indexTable)
      ..where((tbl) => tbl.enabled.equals(true)); 
    final results = await query.get();

    return results.map((e) => IndexEntry.fromIndexTableData(e)).toList();

  }

  /// Clears any frequency dictionary override currently set
  Future clearFrequencyOverride() async {

    final resetQuery = update(indexTable);
    await resetQuery.write(
      IndexTableCompanion(currentFrequencyDictionary: Value(false),),
    );

  }

  /// Sets the current frequency dictionary to the entry with
  /// `newOverrideIndexId`
  Future updateFrequencyOverride(int newOverrideIndexId) async {

    await clearFrequencyOverride();

    final updateQuery = update(indexTable)
      ..where((tbl) => tbl.id.equals(newOverrideIndexId));
    await updateQuery.write(
      IndexTableCompanion(currentFrequencyDictionary: Value(true),),
    );

  }

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
    final result = await query.getSingleOrNull();

    return result;

  }


  // ---------------------------------------------------------------------------

  /// Get the maximum index id
  Future<int> maxIndexId() async {
    
    final query = await (selectOnly(indexTable)
        ..addColumns([indexTable.id.max()]))
      .getSingle();

    // Extract the max ID value, defaulting to 0 if null
    return query.read(indexTable.id.max()) ?? 0;

  }
  
}
