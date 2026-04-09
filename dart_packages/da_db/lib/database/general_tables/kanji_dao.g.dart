// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji_dao.dart';

// ignore_for_file: type=lint
mixin _$KanjiDaoMixin on DatabaseAccessor<DaDb> {
  $KanjiTableTable get kanjiTable => attachedDatabase.kanjiTable;
  KanjiDaoManager get managers => KanjiDaoManager(this);
}

class KanjiDaoManager {
  final _$KanjiDaoMixin _db;
  KanjiDaoManager(this._db);
  $$KanjiTableTableTableManager get kanjiTable =>
      $$KanjiTableTableTableManager(_db.attachedDatabase, _db.kanjiTable);
}
