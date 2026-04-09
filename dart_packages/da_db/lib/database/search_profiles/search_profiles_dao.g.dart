// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_profiles_dao.dart';

// ignore_for_file: type=lint
mixin _$SearchProfilesDaoMixin on DatabaseAccessor<DaDb> {
  $SearchProfilesTableTable get searchProfilesTable =>
      attachedDatabase.searchProfilesTable;
  SearchProfilesDaoManager get managers => SearchProfilesDaoManager(this);
}

class SearchProfilesDaoManager {
  final _$SearchProfilesDaoMixin _db;
  SearchProfilesDaoManager(this._db);
  $$SearchProfilesTableTableTableManager get searchProfilesTable =>
      $$SearchProfilesTableTableTableManager(
        _db.attachedDatabase,
        _db.searchProfilesTable,
      );
}
