// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radical_dao.dart';

// ignore_for_file: type=lint
mixin _$RadicalDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $RadicalsTableTable get radicalsTable => attachedDatabase.radicalsTable;
  $KanjiTableTable get kanjiTable => attachedDatabase.kanjiTable;
  $Radical_X_KanjiRelationsTableTable get radicalXKanjiRelationsTable =>
      attachedDatabase.radicalXKanjiRelationsTable;
  RadicalDaoManager get managers => RadicalDaoManager(this);
}

class RadicalDaoManager {
  final _$RadicalDaoMixin _db;
  RadicalDaoManager(this._db);
  $$RadicalsTableTableTableManager get radicalsTable =>
      $$RadicalsTableTableTableManager(_db.attachedDatabase, _db.radicalsTable);
  $$KanjiTableTableTableManager get kanjiTable =>
      $$KanjiTableTableTableManager(_db.attachedDatabase, _db.kanjiTable);
  $$Radical_X_KanjiRelationsTableTableTableManager
  get radicalXKanjiRelationsTable =>
      $$Radical_X_KanjiRelationsTableTableTableManager(
        _db.attachedDatabase,
        _db.radicalXKanjiRelationsTable,
      );
}
