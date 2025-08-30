// Package imports:
import '/database/example/example_tables.dart';
import 'package:drift/drift.dart';


/// Contains the relationships between examples and their translations
class ExampleTranslationRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated example
  IntColumn get exampleId => integer().references(ExampleTable, #id)();
  /// the id of the associated translation
  IntColumn get translationId => integer().references(ExampleTranslationTable, #id)();

}
