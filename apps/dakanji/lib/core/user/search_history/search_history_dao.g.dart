// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_dao.dart';

// ignore_for_file: type=lint
mixin _$SearchHistoryDaoMixin on DatabaseAccessor<UserDataDB> {
  $SearchHistoryTableTable get searchHistoryTable =>
      attachedDatabase.searchHistoryTable;
  SearchHistoryDaoManager get managers => SearchHistoryDaoManager(this);
}

class SearchHistoryDaoManager {
  final _$SearchHistoryDaoMixin _db;
  SearchHistoryDaoManager(this._db);
  $$SearchHistoryTableTableTableManager get searchHistoryTable =>
      $$SearchHistoryTableTableTableManager(
        _db.attachedDatabase,
        _db.searchHistoryTable,
      );
}
