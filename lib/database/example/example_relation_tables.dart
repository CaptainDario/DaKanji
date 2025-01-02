// Package imports:
import 'package:dakanji_db/database/example/example_tables.dart';
import 'package:dakanji_db/database/general_tables/term_tables.dart';
import 'package:drift/drift.dart';



/// Contains the relationships between examples and the terms that the examples
/// contain
class ExampleTermRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated example
  IntColumn get exampleId => integer().references(ExampleTable, #id)();
  /// the id of the associated term
  IntColumn get termId => integer().references(TermTable, #id)();

}

/// Contains the relationships between examples and their translations
class ExampleTranslationRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated example
  IntColumn get exampleId => integer().references(ExampleTable, #id)();
  /// the id of the associated translation
  IntColumn get translationId => integer().references(ExampleTranslationTable, #id)();

}
