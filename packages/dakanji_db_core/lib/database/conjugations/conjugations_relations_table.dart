import 'package:dakanji_db_core/database/conjugations/conjugations_table.dart';
import 'package:dakanji_db_core/database/general_tables/term_tables.dart';
import 'package:drift/drift.dart';



class ConjugationsRelationsTable extends Table {

  /// Define the columns for the conjugations_relations table
  IntColumn get id => integer().autoIncrement()();
  /// The ID of the conjugation from the ConjugationsTable
  IntColumn get conjugationId => integer().references(ConjugationsTable, #id)();
  /// The ID of the term from the TermTable to which this conjugation applies
  IntColumn get termId => integer().references(TermTable, #id)();
}