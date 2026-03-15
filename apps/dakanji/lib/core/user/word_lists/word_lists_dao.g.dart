// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lists_dao.dart';

// ignore_for_file: type=lint
mixin _$WordListsDaoMixin on DatabaseAccessor<UserDataDB> {
  $WordListNodesTableTable get wordListNodesTable =>
      attachedDatabase.wordListNodesTable;
  $WordListEntriesTableTable get wordListEntriesTable =>
      attachedDatabase.wordListEntriesTable;
  WordListsDaoManager get managers => WordListsDaoManager(this);
}

class WordListsDaoManager {
  final _$WordListsDaoMixin _db;
  WordListsDaoManager(this._db);
  $$WordListNodesTableTableTableManager get wordListNodesTable =>
      $$WordListNodesTableTableTableManager(
        _db.attachedDatabase,
        _db.wordListNodesTable,
      );
  $$WordListEntriesTableTableTableManager get wordListEntriesTable =>
      $$WordListEntriesTableTableTableManager(
        _db.attachedDatabase,
        _db.wordListEntriesTable,
      );
}
