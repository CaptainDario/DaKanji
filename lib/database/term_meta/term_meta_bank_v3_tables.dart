// Package imports:
import 'package:dakanji_db/database/tag/tag_bank_v3_tables.dart';
import 'package:drift/drift.dart';

// Project imports:
import 'package:dakanji_db/database/general_tables/reading_tables.dart';
import 'package:dakanji_db/database/general_tables/term_tables.dart';
import 'package:dakanji_db/database/index/index_tables.dart';

/// Table that store the main term of a meta term bank and links to its data
class TermMetaBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// id of the dictionary this entry belongs to
  IntColumn get dictId => integer().references(IndexTable, #id)();

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

  /// the ID of the pitch of this term
  IntColumn get pitchId => integer().references(TermMetaBankV3PitchTable, #id).nullable()();

  /// the ID of the id of this term
  IntColumn get ipaId => integer().references(TermMetaBankV3IpaTable, #id).nullable()();
  
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

/// Class that stores the meta term tags
class TermMetaBankV3TagTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The tag of this table transcription
  TextColumn get tag => text().unique()();

}