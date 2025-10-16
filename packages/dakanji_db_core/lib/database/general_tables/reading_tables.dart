
import 'package:drift/drift.dart';

/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'reading', columns: {#reading})
class ReadingTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the reading of this entry
  TextColumn get reading => text().unique()();

}
