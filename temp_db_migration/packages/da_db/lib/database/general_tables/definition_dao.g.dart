// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition_dao.dart';

// ignore_for_file: type=lint
mixin _$DefinitionDaoMixin on DatabaseAccessor<DaDb> {
  $DefinitionTableTable get definitionTable => attachedDatabase.definitionTable;
  DefinitionDaoManager get managers => DefinitionDaoManager(this);
}

class DefinitionDaoManager {
  final _$DefinitionDaoMixin _db;
  DefinitionDaoManager(this._db);
  $$DefinitionTableTableTableManager get definitionTable =>
      $$DefinitionTableTableTableManager(
        _db.attachedDatabase,
        _db.definitionTable,
      );
}
