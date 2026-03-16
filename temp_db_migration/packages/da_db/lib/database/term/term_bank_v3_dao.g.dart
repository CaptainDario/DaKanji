// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_bank_v3_dao.dart';

// ignore_for_file: type=lint
mixin _$TermBankV3DaoMixin on DatabaseAccessor<DaDb> {
  $TermTableTable get termTable => attachedDatabase.termTable;
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $TermBankV3DefinitionJsonTableTable get termBankV3DefinitionJsonTable =>
      attachedDatabase.termBankV3DefinitionJsonTable;
  $ReadingTableTable get readingTable => attachedDatabase.readingTable;
  $TermBankV3TableTable get termBankV3Table => attachedDatabase.termBankV3Table;
  $TermBankV3RuleIdentifierTableTable get termBankV3RuleIdentifierTable =>
      attachedDatabase.termBankV3RuleIdentifierTable;
  $TagBankV3TableTable get tagBankV3Table => attachedDatabase.tagBankV3Table;
  TermBankV3DaoManager get managers => TermBankV3DaoManager(this);
}

class TermBankV3DaoManager {
  final _$TermBankV3DaoMixin _db;
  TermBankV3DaoManager(this._db);
  $$TermTableTableTableManager get termTable =>
      $$TermTableTableTableManager(_db.attachedDatabase, _db.termTable);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$TermBankV3DefinitionJsonTableTableTableManager
  get termBankV3DefinitionJsonTable =>
      $$TermBankV3DefinitionJsonTableTableTableManager(
        _db.attachedDatabase,
        _db.termBankV3DefinitionJsonTable,
      );
  $$ReadingTableTableTableManager get readingTable =>
      $$ReadingTableTableTableManager(_db.attachedDatabase, _db.readingTable);
  $$TermBankV3TableTableTableManager get termBankV3Table =>
      $$TermBankV3TableTableTableManager(
        _db.attachedDatabase,
        _db.termBankV3Table,
      );
  $$TermBankV3RuleIdentifierTableTableTableManager
  get termBankV3RuleIdentifierTable =>
      $$TermBankV3RuleIdentifierTableTableTableManager(
        _db.attachedDatabase,
        _db.termBankV3RuleIdentifierTable,
      );
  $$TagBankV3TableTableTableManager get tagBankV3Table =>
      $$TagBankV3TableTableTableManager(
        _db.attachedDatabase,
        _db.tagBankV3Table,
      );
}
