// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import '/database/term_meta/term_meta_bank_v3_tables.dart';

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

/// Relationship table between Ipa transcription and its tags
class TermMetaBankV3IpaTagRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated ipa entry
  IntColumn get ipaId => integer().references(TermMetaBankV3IpaTable, #id)();
  /// the id of the tag
  IntColumn get tagId => integer().references(TermMetaBankV3TagTable, #id)();

}

/// Relationship table between pitch and its tags
class TermMetaBankV3PitchTagRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated pitch entry
  IntColumn get pitchId => integer().references(TermMetaBankV3PitchTable, #id)();
  /// the id of the tag
  IntColumn get tagId => integer().references(TermMetaBankV3TagTable, #id)();

}
