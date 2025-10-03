// Package imports:
import 'package:html/dom.dart';

import '/database/general_tables/language_code_table.dart';
import '/helper/zlib_text_converter.dart';
import 'package:drift/drift.dart';



/// Contains the example sentences
class ExampleTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleSentence => text()();
  
  /// the example of this entry tokenized
  TextColumn get exampleSentenceTokenized => text()();

}

/// Contains the example sentences' translations
class ExampleTranslationTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// the example of this entry
  TextColumn get exampleTranslation => text()();

  /// The id of the language code (iso 639 2T) of this translation
  IntColumn get languageCodeId => integer().references(LanguageCodeTable, #id)();

}
