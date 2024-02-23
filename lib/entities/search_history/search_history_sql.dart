// Dart imports:
import 'dart:io';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:drift/drift.dart';

// Project imports:
import 'package:da_kanji_mobile/application/sqlite/sql_utils.dart';

part 'search_history_sql.g.dart';



/// SQLite table for the search history of a user
class SearchHistorySQL extends Table {
  
  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The timestamp of when this entry was searched
  DateTimeColumn get dateSearched => dateTime()();
  /// The id of the dictionary entry that has been looked up
  IntColumn get dictEntryID => integer()();

}


@DriftDatabase(tables: [SearchHistorySQL])
class SearchHistorySQLDatabase extends _$SearchHistorySQLDatabase {

  SearchHistorySQLDatabase(
    File databaseFile
  ) : super(openSqlite(databaseFile));

 
  @override
  int get schemaVersion => 1;


  /// Adds a [JMdict] `entry` to the search history database
  Future<int> addEntry(JMdict entry) async {

    return await (into(searchHistorySQL)
      .insert(
        SearchHistorySQLCompanion(
          dateSearched: Value(DateTime.now().toUtc()),
          dictEntryID: Value(entry.id),
        )
      ));
  }

  /// Returns all dictionary IDs in the search history sorted by date
  Future<List<int>> getAllSearchHistoryIDs() async {

    List<int> dictIDs = (await ((select(searchHistorySQL)
      ..orderBy([
        (row) => OrderingTerm.desc(row.dateSearched)
      ])
    ).get()))
    .map((p0) => p0.dictEntryID).toList();

    return dictIDs;
  }

  /// Watches all search history entries sorted by date
  Stream<List<SearchHistorySQLData>> watchAllSearchHistoryIDs() {

    Stream<List<SearchHistorySQLData>> dictIDs = ((select(searchHistorySQL)
      ..orderBy([
        (row) => OrderingTerm.desc(row.dateSearched)
      ])
    ).watch());

    return dictIDs;
  }

  /// Watches all *unique* search history entries sorted by date
  Stream<List<int?>> watchAllUniqueSearchHistoryIDs() {

    Stream<List<int?>> dictIDs = ((selectOnly(searchHistorySQL, distinct: true)
      ..addColumns([searchHistorySQL.dictEntryID])
      ..orderBy([
        OrderingTerm.desc(searchHistorySQL.dateSearched)
      ])
    ).map((p0) => p0.read(searchHistorySQL.dictEntryID))
    .watch());

    return dictIDs;
  }

  /// Deletes an entry given by its ID
  Future deleteEntry(int id) async {

    await searchHistorySQL.deleteWhere((tbl) => tbl.id.equals(id));

  }

  /// Deletes every entry in this database
  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

}

