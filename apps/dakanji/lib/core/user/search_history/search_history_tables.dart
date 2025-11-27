import 'package:drift/drift.dart';



/// SQLite table for the search history of a user
class SearchHistoryTable extends Table {
  
  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The timestamp of when this entry was searched
  DateTimeColumn get dateSearched => dateTime()();
  /// The id of the dictionary entry that has been looked up
  IntColumn get dictEntryID => integer()();

}
