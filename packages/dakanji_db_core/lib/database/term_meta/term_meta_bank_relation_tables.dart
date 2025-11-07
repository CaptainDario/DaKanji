
import 'package:dakanji_db_core/database/tag/tag_bank_v3_tables.dart';
import 'package:drift/drift.dart';

import '/database/term_meta/term_meta_bank_v3_tables.dart';

/// Relationship table between TermMetaBank and PitchTable
@TableIndex(name: 'TermMetaBankV3_X_PitchTable_pitchIdIndex', columns: {#pitchId})
@TableIndex(name: 'TermMetaBankV3_X_PitchTable_termMetaIdIndex', columns: {#termMetaId})
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
@TableIndex(name: 'TermMetaBankV3_X_IpaTable_ipaIdIndex', columns: {#ipaId})
@TableIndex(name: 'TermMetaBankV3_X_IpaTable_termMetaIdIndex', columns: {#termMetaId})
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
@TableIndex(name: 'TermMetaBankV3IpaTable_X_TagBankV3Table_ipaIdIndex', columns: {#ipaId})
@TableIndex(name: 'TermMetaBankV3IpaTable_X_TagBankV3Table_tagIdIndex', columns: {#tagId})
// ignore: camel_case_types
class TermMetaBankV3IpaTable_X_TagBankV3Table extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated ipa entry
  IntColumn get ipaId => integer()
    .references(TermMetaBankV3IpaTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the tag
  IntColumn get tagId => integer().references(TagBankV3Table, #id)();

}

/// Relationship table between pitch and its tags
@TableIndex(name: 'TermMetaBankV3PitchTable_X_TagBankV3Table_pitchIdIndex', columns: {#pitchId})
@TableIndex(name: 'TermMetaBankV3PitchTable_X_TagBankV3Table_tagIdIndex', columns: {#tagId})
// ignore: camel_case_types
class TermMetaBankV3PitchTable_X_TagBankV3Table extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated pitch entry
  IntColumn get pitchId => integer()
    .references(TermMetaBankV3PitchTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the tag
  IntColumn get tagId => integer().references(TagBankV3Table, #id)();

}
