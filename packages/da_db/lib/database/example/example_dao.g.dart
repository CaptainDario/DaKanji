// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_dao.dart';

// ignore_for_file: type=lint
mixin _$ExampleDaoMixin on DatabaseAccessor<DaDb> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $ExampleTableTable get exampleTable => attachedDatabase.exampleTable;
  $LanguageCodeTableTable get languageCodeTable =>
      attachedDatabase.languageCodeTable;
  $ExampleTranslationTableTable get exampleTranslationTable =>
      attachedDatabase.exampleTranslationTable;
  ExampleDaoManager get managers => ExampleDaoManager(this);
}

class ExampleDaoManager {
  final _$ExampleDaoMixin _db;
  ExampleDaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$ExampleTableTableTableManager get exampleTable =>
      $$ExampleTableTableTableManager(_db.attachedDatabase, _db.exampleTable);
  $$LanguageCodeTableTableTableManager get languageCodeTable =>
      $$LanguageCodeTableTableTableManager(
        _db.attachedDatabase,
        _db.languageCodeTable,
      );
  $$ExampleTranslationTableTableTableManager get exampleTranslationTable =>
      $$ExampleTranslationTableTableTableManager(
        _db.attachedDatabase,
        _db.exampleTranslationTable,
      );
}
