// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_bank_v3_dao.dart';

// ignore_for_file: type=lint
mixin _$TermBankV3DaoMixin on DatabaseAccessor<DaKanjiDB> {
  $TermTableTable get termTable => attachedDatabase.termTable;
  $ReadingTableTable get readingTable => attachedDatabase.readingTable;
  $TermBankV3TableTable get termBankV3Table => attachedDatabase.termBankV3Table;
  $TermBankV3DefinitionTagsTableTable get termBankV3DefinitionTagsTable =>
      attachedDatabase.termBankV3DefinitionTagsTable;
  $TermBankV3DefinitionTagRelationsTableTable
  get termBankV3DefinitionTagRelationsTable =>
      attachedDatabase.termBankV3DefinitionTagRelationsTable;
  $TermBankV3RuleIdentifierTableTable get termBankV3RuleIdentifierTable =>
      attachedDatabase.termBankV3RuleIdentifierTable;
  $TermBankV3RuleIdentifierRelationsTableTable
  get termBankV3RuleIdentifierRelationsTable =>
      attachedDatabase.termBankV3RuleIdentifierRelationsTable;
  $DefinitionTableTable get definitionTable => attachedDatabase.definitionTable;
  $TermBankV3DefinitionsRelationsTableTable
  get termBankV3DefinitionsRelationsTable =>
      attachedDatabase.termBankV3DefinitionsRelationsTable;
  $TagBankV3TableTable get tagBankV3Table => attachedDatabase.tagBankV3Table;
  $TermBankV3TagBankRelationsTableTable get termBankV3TagBankRelationsTable =>
      attachedDatabase.termBankV3TagBankRelationsTable;
  TermBankV3SearchView get termBankV3SearchView =>
      attachedDatabase.termBankV3SearchView;
  Selectable<TermBankV3SearchViewData> term_bank_v3_search(
    String? query,
    int limit,
    int offset,
  ) {
    return customSelect(
      'SELECT * FROM term_bank_v3_search_view WHERE term = ?1 LIMIT ?2 OFFSET ?3',
      variables: [
        Variable<String>(query),
        Variable<int>(limit),
        Variable<int>(offset),
      ],
      readsFrom: {
        termBankV3Table,
        termTable,
        readingTable,
        termBankV3DefinitionTagRelationsTable,
        termBankV3DefinitionTagsTable,
        termBankV3RuleIdentifierRelationsTable,
        termBankV3RuleIdentifierTable,
        termBankV3DefinitionsRelationsTable,
        definitionTable,
        termBankV3TagBankRelationsTable,
        tagBankV3Table,
      },
    ).asyncMap(termBankV3SearchView.mapFromRow);
  }
}
