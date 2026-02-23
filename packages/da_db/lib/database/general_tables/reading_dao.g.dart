// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_dao.dart';

// ignore_for_file: type=lint
mixin _$ReadingDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $ReadingTableTable get readingTable => attachedDatabase.readingTable;
  ReadingDaoManager get managers => ReadingDaoManager(this);
}

class ReadingDaoManager {
  final _$ReadingDaoMixin _db;
  ReadingDaoManager(this._db);
  $$ReadingTableTableTableManager get readingTable =>
      $$ReadingTableTableTableManager(_db.attachedDatabase, _db.readingTable);
}
