import 'package:drift/drift.dart';



/// Table that store the main term of a meta term bank and links to its data
@TableIndex(name: 'term', columns: {#term})
class TermMetaBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// id of the dictionary this entry belongs to
  IntColumn get dictId => integer()();

  /// the term this meta entry belongs to
  TextColumn get term => text().withLength(min: 1)();

  /// the reading of this term
  TextColumn get reading => text().withLength(min: 1).nullable()();

  /// the id of this term's type entry
  IntColumn get typeId => integer().references(TermMetaBankV3TypeTable, #id)();

  /// the value of this entry
  IntColumn get freqValue => integer().nullable()();

  /// the display value of this entry
  TextColumn get freqDisplayValue => text().nullable()();
  
}

/// Class that stores the type data for meta bank entries
class TermMetaBankV3TypeTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// the type of this meta information
  TextColumn get type => text().withLength(min: 1)();

}
