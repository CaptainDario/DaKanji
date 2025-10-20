
import 'package:drift/drift.dart';

import '/database/term_meta/term_meta_bank_v3_tables.dart';

/// Relationship table between TermMetaBank and PitchTable
// ignore: camel_case_types
class TermMetaBankV3_X_PitchTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated devoice
  IntColumn get pitchId => integer().references(TermMetaBankV3PitchTable, #id)();
  /// the id of the associated term meta
  IntColumn get termMetaId => integer()
    .references(TermMetaBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Relationship table between TermMetaBank and IpaTable
// ignore: camel_case_types
class TermMetaBankV3_X_IpaTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated ipa entry
  IntColumn get ipaId => integer().references(TermMetaBankV3IpaTable, #id)();
  /// the id of the associated term meta
  IntColumn get termMetaId => integer()
    .references(TermMetaBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Relationship table between Ipa transcription and its tags
// ignore: camel_case_types
class TermMetaBankV3_X_IpaTagTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated ipa entry
  IntColumn get ipaId => integer()
    .references(TermMetaBankV3IpaTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the tag
  IntColumn get tagId => integer().references(TermMetaBankV3TagTable, #id)();

}

/// Relationship table between pitch and its tags
// ignore: camel_case_types
class TermMetaBankV3_X_PitchTagTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated pitch entry
  IntColumn get pitchId => integer()
    .references(TermMetaBankV3PitchTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the tag
  IntColumn get tagId => integer().references(TermMetaBankV3TagTable, #id)();

}
