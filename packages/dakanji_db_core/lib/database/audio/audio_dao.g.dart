// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_dao.dart';

// ignore_for_file: type=lint
mixin _$AudioDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $ReadingTableTable get readingTable => attachedDatabase.readingTable;
  $MediaTableTable get mediaTable => attachedDatabase.mediaTable;
  $AudioTableTable get audioTable => attachedDatabase.audioTable;
  AudioDaoManager get managers => AudioDaoManager(this);
}

class AudioDaoManager {
  final _$AudioDaoMixin _db;
  AudioDaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$ReadingTableTableTableManager get readingTable =>
      $$ReadingTableTableTableManager(_db.attachedDatabase, _db.readingTable);
  $$MediaTableTableTableManager get mediaTable =>
      $$MediaTableTableTableManager(_db.attachedDatabase, _db.mediaTable);
  $$AudioTableTableTableManager get audioTable =>
      $$AudioTableTableTableManager(_db.attachedDatabase, _db.audioTable);
}
