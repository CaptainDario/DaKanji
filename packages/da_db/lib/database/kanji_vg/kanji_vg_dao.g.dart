// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_vg_dao.dart';

// ignore_for_file: type=lint
mixin _$KanjiVGDaoMixin on DatabaseAccessor<DaDb> {
  $KanjiTableTable get kanjiTable => attachedDatabase.kanjiTable;
  $KanjiVGTableTable get kanjiVGTable => attachedDatabase.kanjiVGTable;
  KanjiVGDaoManager get managers => KanjiVGDaoManager(this);
}

class KanjiVGDaoManager {
  final _$KanjiVGDaoMixin _db;
  KanjiVGDaoManager(this._db);
  $$KanjiTableTableTableManager get kanjiTable =>
      $$KanjiTableTableTableManager(_db.attachedDatabase, _db.kanjiTable);
  $$KanjiVGTableTableTableManager get kanjiVGTable =>
      $$KanjiVGTableTableTableManager(_db.attachedDatabase, _db.kanjiVGTable);
}
