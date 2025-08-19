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
  $MeaningTableTable get meaningTable => attachedDatabase.meaningTable;
  $TermBankV3MeaningsRelationsTableTable get termBankV3MeaningsRelationsTable =>
      attachedDatabase.termBankV3MeaningsRelationsTable;
  $TagBankV3TableTable get tagBankV3Table => attachedDatabase.tagBankV3Table;
  $TermBankV3TagBankRelationsTableTable get termBankV3TagBankRelationsTable =>
      attachedDatabase.termBankV3TagBankRelationsTable;
  FullTermView get fullTermView => attachedDatabase.fullTermView;
  $TagBankV3CategoryTableTable get tagBankV3CategoryTable =>
      attachedDatabase.tagBankV3CategoryTable;
  $TagBankV3TagCategoryRelationsTableTable
  get tagBankV3TagCategoryRelationsTable =>
      attachedDatabase.tagBankV3TagCategoryRelationsTable;
  Selectable<FullTermViewData> term_search(
    String? query,
    int limit,
    int offset,
  ) {
    return customSelect(
      'SELECT * FROM full_term_view WHERE term = ?1 LIMIT ?2 OFFSET ?3',
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
        termBankV3MeaningsRelationsTable,
        meaningTable,
        termBankV3TagBankRelationsTable,
        tagBankV3Table,
      },
    ).asyncMap(fullTermView.mapFromRow);
  }
}
