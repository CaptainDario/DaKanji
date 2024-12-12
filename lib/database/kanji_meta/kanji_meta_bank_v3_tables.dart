import 'package:drift/drift.dart';



/// Table that store the main term of a meta term bank and links to its data
@TableIndex(name: 'kanji', columns: {#kanji})
class KanjiMetaBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// id of the dictionary this entry belongs to
  IntColumn get dictId => integer()();

  /// the kanji this meta entry belongs to
  TextColumn get kanji => text().withLength(min: 1)();

  /// the id of this term's type entry
  IntColumn get typeId => integer().references(KanjiMetaBankV3TypeTable, #id)();

  /// the value of this entry
  IntColumn get value => integer().nullable()();

  /// the display value of this entry
  TextColumn get displayValue => text().nullable()();
  
}

/// Class that stores the type data for meta bank entries
class KanjiMetaBankV3TypeTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// the type of this meta information
  TextColumn get type => text().withLength(min: 1)();

}