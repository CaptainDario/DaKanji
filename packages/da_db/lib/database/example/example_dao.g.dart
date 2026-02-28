// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_dao.dart';

// ignore_for_file: type=lint
mixin _$ExampleDaoMixin on DatabaseAccessor<DaDb> {
  $IndexTableTable get indexTable => attachedDatabase.indexTable;
  $ExampleSentenceTableTable get exampleSentenceTable =>
      attachedDatabase.exampleSentenceTable;
  $LanguageCodeTableTable get languageCodeTable =>
      attachedDatabase.languageCodeTable;
  $ExampleTableTable get exampleTable => attachedDatabase.exampleTable;
  $ExampleAudioTableTable get exampleAudioTable =>
      attachedDatabase.exampleAudioTable;
  ExampleDaoManager get managers => ExampleDaoManager(this);
}

class ExampleDaoManager {
  final _$ExampleDaoMixin _db;
  ExampleDaoManager(this._db);
  $$IndexTableTableTableManager get indexTable =>
      $$IndexTableTableTableManager(_db.attachedDatabase, _db.indexTable);
  $$ExampleSentenceTableTableTableManager get exampleSentenceTable =>
      $$ExampleSentenceTableTableTableManager(
        _db.attachedDatabase,
        _db.exampleSentenceTable,
      );
  $$LanguageCodeTableTableTableManager get languageCodeTable =>
      $$LanguageCodeTableTableTableManager(
        _db.attachedDatabase,
        _db.languageCodeTable,
      );
  $$ExampleTableTableTableManager get exampleTable =>
      $$ExampleTableTableTableManager(_db.attachedDatabase, _db.exampleTable);
  $$ExampleAudioTableTableTableManager get exampleAudioTable =>
      $$ExampleAudioTableTableTableManager(
        _db.attachedDatabase,
        _db.exampleAudioTable,
      );
}
