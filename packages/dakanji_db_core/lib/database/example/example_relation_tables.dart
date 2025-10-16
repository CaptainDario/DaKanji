
import 'package:drift/drift.dart';

import '/database/example/example_tables.dart';


/// Contains the relationships between examples and their translations
// ignore: camel_case_types
class ExampleTable_X_ExampleTranslationTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated example
  IntColumn get exampleId => integer().references(ExampleTable, #id)();
  /// the id of the associated translation
  IntColumn get translationId => integer().references(ExampleTranslationTable, #id)();

}
