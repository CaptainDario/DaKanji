// Package imports:
import 'package:drift/drift.dart';



/// Contains the example sentences
@TableIndex(name: 'exampleSentence', columns: {#exampleSentence})
class ExampleTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleSentence => text().unique()();

}

/// Contains the example sentences' translations
@TableIndex(name: 'exampleSentenceTranslation', columns: {#exampleSentenceTranslation})
class ExampleTranslationTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleSentenceTranslation => text().unique()();

  /// The language of this entry
  IntColumn get languageId => integer()();

}
