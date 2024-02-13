import 'dart:convert';
import 'dart:io';

import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:drift/drift.dart';

import 'package:da_kanji_mobile/application/sqlite/sql_utils.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';

part 'word_lists_sql.g.dart';



/// SQLite table for the wordlists
class WordListsSQL extends Table {
  
  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The name of this wordlist entry
  TextColumn get name => text()();
  /// The parent's ID
  IntColumn get parentID => integer().nullable()();
  /// All children IDs
  TextColumn get childrenIDs => text().map(const ListIntConverter())();
  /// The type of this entry
  IntColumn get type => intEnum<WordListNodeType>()();
  /// All dictionary ids in this list
  TextColumn get dictIDs => text().map(const ListIntConverter())();
  /// Is this entry currently expanded
  BoolColumn get isExpanded => boolean().clientDefault(() => false)();
  /// Is this entry currently checked
  BoolColumn get isChecked => boolean().clientDefault(() => false)();

}

@DriftDatabase(tables: [WordListsSQL])
class WordListsSQLDatabase extends _$WordListsSQLDatabase {

  WordListsSQLDatabase(
    File databaseFile
  ) : super(openSqlite(databaseFile));


  /// A stream that emits whenever a value of this database changes
  Stream<List<WordListsSQLData>> watchAllWordlists(){

    return select(wordListsSQL).watch();

  }

  // returns the generated id
  Future<int> addEntry(TreeNode<WordListsData> entry) {

    final sqlEntry = WordListsSQLCompanion(
        name: Value("New ${entry.value.type.name}"),
        parentID: Value(entry.id),
        childrenIDs: Value(entry.children.map((e) => e.id).toList()),
        dictIDs: Value(entry.value.wordIds),
        type: Value(entry.value.type),
      );

    return into(wordListsSQL).insert(sqlEntry);
  }

  @override
  int get schemaVersion => 1;

}

