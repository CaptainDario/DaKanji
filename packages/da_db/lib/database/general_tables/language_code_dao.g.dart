// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_code_dao.dart';

// ignore_for_file: type=lint
mixin _$LanguageCodeDaoMixin on DatabaseAccessor<DaKanjiDB> {
  $LanguageCodeTableTable get languageCodeTable =>
      attachedDatabase.languageCodeTable;
  LanguageCodeDaoManager get managers => LanguageCodeDaoManager(this);
}

class LanguageCodeDaoManager {
  final _$LanguageCodeDaoMixin _db;
  LanguageCodeDaoManager(this._db);
  $$LanguageCodeTableTableTableManager get languageCodeTable =>
      $$LanguageCodeTableTableTableManager(
        _db.attachedDatabase,
        _db.languageCodeTable,
      );
}
