
import 'package:drift/drift.dart';

import '/database/general_tables/definition_tables.dart';
import '/database/tag/tag_bank_v3_tables.dart';
import '/database/term/term_bank_v3_tables.dart';



/// Contains the relationships between definition tags and terms
@TableIndex(name: 'TermBankV3_X_DefinitionTagTable_definitionTagIdIndex', columns: {#definitionTagId})
@TableIndex(name: 'TermBankV3_X_DefinitionTagTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_DefinitionTagTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated defintion tag
  IntColumn get definitionTagId => integer().references(TermBankV3DefinitionTagsTable, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Contains the relationships between rule identifiers and terms
@TableIndex(name: 'TermBankV3_X_RuleIdentifierTable_ruleIdentifierIdIndex', columns: {#ruleIdentifierId})
@TableIndex(name: 'TermBankV3_X_RuleIdentifierTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_RuleIdentifierTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated rule identifier reading
  IntColumn get ruleIdentifierId => integer().references(TermBankV3RuleIdentifierTable, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Contains the relationships between terms and definitions
@TableIndex(name: 'TermBankV3_X_DefinitionTable_definitionIdIndex', columns: {#definitionId})
@TableIndex(name: 'TermBankV3_X_DefinitionTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_DefinitionTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated definition
  IntColumn get definitionId => integer().references(DefinitionTable, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}

/// Contains the relationships between tag bank tags and terms
@TableIndex(name: 'TermBankV3_X_TagBankTable_tagBankIdIndex', columns: {#tagBankId})
@TableIndex(name: 'TermBankV3_X_TagBankTable_termBankIdIndex', columns: {#termBankId})
// ignore: camel_case_types
class TermBankV3_X_TagBankTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated tag bank entry
  IntColumn get tagBankId => integer().references(TagBankV3Table, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer()
    .references(TermBankV3Table, #id, onDelete: KeyAction.cascade)();

}