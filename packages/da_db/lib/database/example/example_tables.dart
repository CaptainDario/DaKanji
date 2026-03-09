
import 'package:da_db/database/index/index_tables.dart';
import 'package:drift/drift.dart';

import '/database/general_tables/language_code_table.dart';



/// Contains the example sentences
@TableIndex(name: 'ExampleTable_indexIdIndex', columns: {#indexId})
@TableIndex(name: 'ExampleSentencesTable_languageCodeIdIndex', columns: {#languageCodeId})
@TableIndex(name: 'ExampleSentencesTable_groupIdIndex', columns: {#groupId})
@TableIndex(name: 'ExampleTable_exampleSentenceIdIndex', columns: {#exampleSentenceId})
class ExampleTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id,
    onDelete: KeyAction.cascade
  )();

  /// The id of the group this entry belongs to. Can be used to group example
  /// sentences of the same entry together
  IntColumn get groupId => integer()();

  IntColumn get exampleSentenceId => integer()
    .references(ExampleSentenceTable, #id)();

  /// The id of the language code (iso 639 2T) of this translation
  IntColumn get languageCodeId => integer().references(LanguageCodeTable, #id)();

}

/// Contains the actual example sentences
class ExampleSentenceTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleSentence => text()();

  /// `exampleSentence` tokenized for looking up term -> example
  TextColumn get exampleSentenceTokenized => text().nullable()();

}

/// Contains the audio data for example sentences
class ExampleAudioTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the path to the audio file
  TextColumn get path => text()();

  /// the name of this audio
  TextColumn get name => text()();

}
