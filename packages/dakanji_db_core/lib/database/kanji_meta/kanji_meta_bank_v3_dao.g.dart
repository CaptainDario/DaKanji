// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_meta_bank_v3_dao.dart';

// ignore_for_file: type=lint
mixin _$KanjiMetaBankV3DaoMixin on DatabaseAccessor<DaKanjiDB> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $KanjiTableTable get kanjiTable => attachedDatabase.kanjiTable;
  $KanjiMetaBankV3TypeTableTable get kanjiMetaBankV3TypeTable =>
      attachedDatabase.kanjiMetaBankV3TypeTable;
  $KanjiMetaBankV3TableTable get kanjiMetaBankV3Table =>
      attachedDatabase.kanjiMetaBankV3Table;
  KanjiMetaBankV3DaoManager get managers => KanjiMetaBankV3DaoManager(this);
}

class KanjiMetaBankV3DaoManager {
  final _$KanjiMetaBankV3DaoMixin _db;
  KanjiMetaBankV3DaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$KanjiTableTableTableManager get kanjiTable =>
      $$KanjiTableTableTableManager(_db.attachedDatabase, _db.kanjiTable);
  $$KanjiMetaBankV3TypeTableTableTableManager get kanjiMetaBankV3TypeTable =>
      $$KanjiMetaBankV3TypeTableTableTableManager(
        _db.attachedDatabase,
        _db.kanjiMetaBankV3TypeTable,
      );
  $$KanjiMetaBankV3TableTableTableManager get kanjiMetaBankV3Table =>
      $$KanjiMetaBankV3TableTableTableManager(
        _db.attachedDatabase,
        _db.kanjiMetaBankV3Table,
      );
}
