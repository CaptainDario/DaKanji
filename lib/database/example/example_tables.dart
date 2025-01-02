// Package imports:
import 'package:dakanji_db/database/general_tables/language_code_table.dart';
import 'package:drift/drift.dart';



/// Contains the example sentences
@TableIndex(name: 'exampleSentence', columns: {#exampleSentence})
class ExampleTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleSentence => text()();

}

/// Contains the example sentences' translations
@TableIndex(name: 'exampleTranslation', columns: {#exampleTranslation})
class ExampleTranslationTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleTranslation => text()();

  /// The id of the language code (iso 639 2T) of this translation
  IntColumn get languageCodeId => integer().references(LanguageCodeTable, #id)();

}
