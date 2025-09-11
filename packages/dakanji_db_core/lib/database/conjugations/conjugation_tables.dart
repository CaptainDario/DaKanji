import 'package:drift/drift.dart';



class ConjugationTable extends Table {

  /// Define the columns for the conjugations table
  IntColumn get id => integer().autoIncrement()();
  /// The form of the conjugation (e.g., "食べます", "食べない", etc.)
  TextColumn get conjugation => text().withLength(min: 1)();

}