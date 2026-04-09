// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_dao.dart';

// ignore_for_file: type=lint
mixin _$TermDaoMixin on DatabaseAccessor<DaDb> {
  $TermTableTable get termTable => attachedDatabase.termTable;
  TermDaoManager get managers => TermDaoManager(this);
}

class TermDaoManager {
  final _$TermDaoMixin _db;
  TermDaoManager(this._db);
  $$TermTableTableTableManager get termTable =>
      $$TermTableTableTableManager(_db.attachedDatabase, _db.termTable);
}
