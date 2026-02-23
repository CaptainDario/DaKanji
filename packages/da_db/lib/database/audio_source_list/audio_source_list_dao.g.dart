// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_source_list_dao.dart';

// ignore_for_file: type=lint
mixin _$AudioSourceListDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $AudioSourceListTableTable get audioSourceListTable =>
      attachedDatabase.audioSourceListTable;
  AudioSourceListDaoManager get managers => AudioSourceListDaoManager(this);
}

class AudioSourceListDaoManager {
  final _$AudioSourceListDaoMixin _db;
  AudioSourceListDaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$AudioSourceListTableTableTableManager get audioSourceListTable =>
      $$AudioSourceListTableTableTableManager(
        _db.attachedDatabase,
        _db.audioSourceListTable,
      );
}
