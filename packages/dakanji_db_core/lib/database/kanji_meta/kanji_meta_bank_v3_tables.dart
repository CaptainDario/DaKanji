
import 'package:drift/drift.dart';

import '/database/general_tables/kanji_tables.dart';
import '/database/index/index_tables.dart';

/// Table that store the main term of a meta term bank and links to its data
@TableIndex(name: 'KanjiMetaBankV3Table_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'KanjiMetaBankV3Table_kanjiIdIndex', columns: {#kanjiId})
@TableIndex(name: 'KanjiMetaBankV3Table_typeIdIndex', columns: {#typeId})
class KanjiMetaBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// the kanji this meta entry belongs to
  IntColumn get kanjiId => integer().references(KanjiTable, #id)();

  /// the id of this term's type entry
  IntColumn get typeId => integer().references(KanjiMetaBankV3TypeTable, #id)();

  /// this entry's numeric frequency value
  IntColumn get freqValue => integer().nullable()();

  /// this entry's dispaly frequency value
  TextColumn get freqDisplayValue => text().nullable()();
  
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
