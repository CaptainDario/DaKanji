// Dart imports:
import 'dart:io';

// Package imports:
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

}

