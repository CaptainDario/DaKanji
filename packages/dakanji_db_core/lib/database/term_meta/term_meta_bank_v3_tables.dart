
import 'package:drift/drift.dart';

import '/database/general_tables/reading_tables.dart';
import '/database/general_tables/term_tables.dart';
import '/database/index/index_tables.dart';

/// Table that store the main term of a meta term bank and links to its data
@TableIndex(name: 'TermMetaBankV3Table_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'TermMetaBankV3Table_termIdIndex', columns: {#termId})
@TableIndex(name: 'TermMetaBankV3Table_readingIdIndex', columns: {#readingId})
@TableIndex(name: 'TermMetaBankV3Table_typeIdIndex', columns: {#typeId})
class TermMetaBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// id of the index (dictionary) this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// the ID of the term this meta data belongs to
  IntColumn get termId => integer().references(TermTable, #id)();

  /// the ID of the reading of this term
  IntColumn get readingId => integer().references(ReadingTable, #id).nullable()();

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
  TextColumn get type => text().unique()();

}

/// Class that stores the pitch data for meta bank entries
class TermMetaBankV3PitchTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The position of the pitch accent
  IntColumn get position => integer()();

  /// the nasal value of this pitch entry
  IntColumn get nasal => integer().nullable()();

  /// the devoice value of this pitch entry
  IntColumn get devoice => integer().nullable()();

}

/// Class that stores the ipa reading data for meta bank entries
class TermMetaBankV3IpaTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The ipa transcription
  TextColumn get ipa => text()();

}
