part of 'stats_database.dart';



/// All stats about the dictionary use
class DictStatsTable extends Table {
  
  IntColumn get id => integer().autoIncrement()();
  
}
