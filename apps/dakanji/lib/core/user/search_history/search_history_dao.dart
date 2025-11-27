import 'package:da_kanji_mobile/core/user/search_history/search_history_tables.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:database_builder/database_builder.dart';
import 'package:drift/drift.dart';

part 'search_history_dao.g.dart';



@DriftAccessor(
  tables: [
    SearchHistoryTable
  ]
)
class SearchHistoryDao extends DatabaseAccessor<UserDataDB> with _$SearchHistoryDaoMixin {

  SearchHistoryDao(super.db);

  /// Adds a [JMdict] `entry` to the search history database
  Future<int> addEntry(JMdict entry) async {

    return await (into(searchHistoryTable)
      .insert(
        SearchHistoryTableCompanion(
          dateSearched: Value(DateTime.now().toUtc()),
          dictEntryID: Value(entry.id),
        )
      ));
  }

  /// Returns all dictionary IDs in the search history sorted by date
  Future<List<int>> getAllSearchHistoryIDs() async {

    List<int> dictIDs = (await ((select(searchHistoryTable)
      ..orderBy([
        (row) => OrderingTerm.desc(row.dateSearched)
      ])
    ).get()))
    .map((p0) => p0.dictEntryID).toList();

    return dictIDs;
  }

  /// Watches all search history entries sorted by date
  Stream<List<SearchHistoryTableData>> watchAllSearchHistoryIDs() {

    Stream<List<SearchHistoryTableData>> dictIDs = ((select(searchHistoryTable)
      ..orderBy([
        (row) => OrderingTerm.desc(row.dateSearched)
      ])
    ).watch());

    return dictIDs;
  }

  /// Watches all *unique* search history entries sorted by date
  Stream<List<int?>> watchAllUniqueSearchHistoryIDs() {

    Stream<List<int?>> dictIDs = ((selectOnly(searchHistoryTable, distinct: true)
      ..addColumns([searchHistoryTable.dictEntryID])
      ..orderBy([
        OrderingTerm.desc(searchHistoryTable.dateSearched)
      ])
    ).map((p0) => p0.read(searchHistoryTable.dictEntryID))
    .watch());

    return dictIDs;
  }

  /// Deletes an entry given by its ID
  Future deleteEntry(int id) async {

    await searchHistoryTable.deleteWhere((tbl) => tbl.id.equals(id));

  }

  /// Deletes everything in the search history
  Future<int> deleteSearchHistory() async {
    return await searchHistoryTable.deleteAll();
  }

}