// Package imports:
import '/database/general_tables/definition_tables.dart';
import '/database/tag/tag_bank_v3_tables.dart';
import '/database/term/term_bank_v3_tables.dart';
import 'package:drift/drift.dart';



/// Contains the relationships between definition tags and terms
class TermBankV3DefinitionTagRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated defintion tag
  IntColumn get definitionTagId => integer().references(TermBankV3DefinitionTagsTable, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer().references(TermBankV3Table, #id)();

}

/// Contains the relationships between rule identifiers and terms
class TermBankV3RuleIdentifierRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated rule identifier reading
  IntColumn get ruleIdentifierId => integer().references(TermBankV3RuleIdentifierTable, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer().references(TermBankV3Table, #id)();

}

/// Contains the relationships between terms and definitions
class TermBankV3DefinitionsRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated definition
  IntColumn get definitionId => integer().references(DefinitionTable, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer().references(TermBankV3Table, #id)();

}

/// Contains the relationships between tag bank tags and terms
class TermBankV3TagBankRelationsTable extends Table {

  /// id of this relation
  IntColumn get id => integer().autoIncrement()();
  /// the id of the associated tag bank entry
  IntColumn get tagBankId => integer().references(TagBankV3Table, #id)();
  /// the id of the associated term in the term bank
  IntColumn get termBankId => integer().references(TermBankV3Table, #id)();

}