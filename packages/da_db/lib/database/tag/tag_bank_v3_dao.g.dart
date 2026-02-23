// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_bank_v3_dao.dart';

// ignore_for_file: type=lint
mixin _$TagBankV3DaoMixin on DatabaseAccessor<DaKanjiDB> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $TagBankV3TableTable get tagBankV3Table => attachedDatabase.tagBankV3Table;
  TagBankV3DaoManager get managers => TagBankV3DaoManager(this);
}

class TagBankV3DaoManager {
  final _$TagBankV3DaoMixin _db;
  TagBankV3DaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$TagBankV3TableTableTableManager get tagBankV3Table =>
      $$TagBankV3TableTableTableManager(
        _db.attachedDatabase,
        _db.tagBankV3Table,
      );
}
