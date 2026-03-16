
import 'package:drift/drift.dart';

import '/database/general_tables/definition_tables.dart';
import '/database/tag/tag_bank_v3_tables.dart';
import '/database/term/term_bank_v3_tables.dart';



/// Contains the relationships between definition tags and terms
@TableIndex(name: 'TermBankV3_X_DefinitionTagTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_DefinitionTagTable extends Table {

  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {definitionTagId, termBankId};

  /// the id of the associated defintion tag
  IntColumn get definitionTagId => integer()
    .references(TagBankV3Table, #id, onDelete: KeyAction.cascade)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Contains the relationships between rule identifiers and terms
@TableIndex(name: 'TermBankV3_X_RuleIdentifierTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_RuleIdentifierTable extends Table {

  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {ruleIdentifierId, termBankId};

  /// the id of the associated rule identifier reading
  IntColumn get ruleIdentifierId => integer()
    .references(TermBankV3RuleIdentifierTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Contains the relationships between terms and definitions
@TableIndex(name: 'TermBankV3_X_DefinitionTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_DefinitionTable extends Table {

  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {definitionId, termBankId};

  /// the id of the associated definition
  IntColumn get definitionId => integer()
    .references(DefinitionTable, #id, onDelete: KeyAction.cascade)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();
  /// the rank of this definition as they are in the source dictionary
  /// (lower is more important)
  IntColumn get rank => integer().withDefault(const Constant(0))();

}

/// Contains the relationships between tag bank tags and terms
@TableIndex(name: 'TermBankV3_X_TagBankTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_TagBankTable extends Table {

  @override
  bool get withoutRowId => true;

  @override
  Set<Column> get primaryKey => {tagBankId, termBankId};

  /// the id of the associated tag bank entry
  IntColumn get tagBankId => integer()
    .references(TagBankV3Table, #id, onDelete: KeyAction.cascade)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}