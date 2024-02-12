import 'dart:io';

import 'package:drift/drift.dart';

import 'package:da_kanji_mobile/application/sqlite/utils.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';

part 'word_lists_sql.g.dart';



/// SQLite table for the wordlists
class WordListsSQL extends Table {
  
  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The name of this entry
  TextColumn get name => text()();
  /// The type of this entry
  IntColumn get type => intEnum<WordListNodeType>()();
  /// all dictionary ids in this list
  TextColumn get ids => text()();
  /// Is this entry currently expanded
  BoolColumn get isExpanded => boolean()();
  /// Is this entry currently checked
  BoolColumn get isChecked => boolean()();

}

@DriftDatabase(tables: [WordListsSQL])
class WordListsSQLDatabase extends _$WordListsSQLDatabase {

  WordListsSQLDatabase(
    File databaseFile
  ) : super(openSqlite(databaseFile));

  @override
  int get schemaVersion => 1;

}

