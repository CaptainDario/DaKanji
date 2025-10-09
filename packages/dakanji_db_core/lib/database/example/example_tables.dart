// Package imports:
import 'package:dakanji_db_core/database/index/index_tables.dart';
import 'package:dakanji_db_core/helper/zlib_text_converter.dart';

import '/database/general_tables/language_code_table.dart';
import 'package:drift/drift.dart';



/// Contains the example sentences
class ExampleTable extends Table {
  
  /// id of this entry
  IntColumn get id => integer().autoIncrement()();

  /// The id of the dictionary this entry belongs to
  IntColumn get indexId => integer().references(IndexTable, #id)();

  /// the example of this entry
  BlobColumn get exampleSentence => blob().map(const ZlibStringConverter())();
  
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
