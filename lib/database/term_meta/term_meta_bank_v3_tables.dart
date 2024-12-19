import 'package:drift/drift.dart';



/// Table that store the main term of a meta term bank and links to its data
class TermMetaBankV3Table extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// id of the dictionary this entry belongs to
  IntColumn get dictId => integer()();

  /// TODO link to term table
  /// the term
  IntColumn get termId => integer()();

  // TODO link to readings table
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

/// Class that stores the pitch data for meta bank entries
class TermMetaBankV3PitchTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The position of the pitch accent
  IntColumn get position => integer()();

  /// TODO link to tag table
  /// the tag of this pitch entry
  IntColumn get tagId => integer().nullable()();

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
  TextColumn get ipa => text().withLength(min: 1)();

}

/// Class that stores the ipa reading tag data for meta bank entries
class TermMetaBankV3IpaTagTable extends Table {

  @override
  Set<Column> get primaryKey => {id};
  
  /// id of this entry
  IntColumn get id => integer()();

  /// The ipa tag
  TextColumn get tag => text().withLength(min: 1)();

}