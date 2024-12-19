import 'package:drift/drift.dart';



/// Contains the kanji entries and links to the radicals table
@TableIndex(name: 'term', columns: {#term})
class TermTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the term of this entry
  TextColumn get term => text().unique()();

}
