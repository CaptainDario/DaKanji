import 'package:dakanji_db/database/term_meta/term_meta_bank_v3_tables.dart';
import 'package:drift/drift.dart';



/// Relationship table between TermMetaBank and PitchTable
class TermMetaBankV3PitchRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated devoice
  IntColumn get pitchId => integer().references(TermMetaBankV3PitchTable, #id)();
  /// the id of the associated term meta
  IntColumn get termMetaId => integer().references(TermMetaBankV3Table, #id)();

}

/// Relationship table between TermMetaBank and IpaTable
class TermMetaBankV3IpaRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated ipa entry
  IntColumn get ipaId => integer().references(TermMetaBankV3IpaTable, #id)();
  /// the id of the associated term meta
  IntColumn get termMetaId => integer().references(TermMetaBankV3Table, #id)();

}
