// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_dao.dart';

// ignore_for_file: type=lint
mixin _$MediaDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $MediaTableTable get mediaTable => attachedDatabase.mediaTable;
  MediaDaoManager get managers => MediaDaoManager(this);
}

class MediaDaoManager {
  final _$MediaDaoMixin _db;
  MediaDaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$MediaTableTableTableManager get mediaTable =>
      $$MediaTableTableTableManager(_db.attachedDatabase, _db.mediaTable);
}
