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
  IntColumn get parentID => integer()();
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

  /// Instantiates a [WordListsSQLCompanion] from a [TreeNode<WordListsData>]
  WordListsSQLCompanion companionFromTreeNode(TreeNode<WordListsData> entry, bool useID){

    return WordListsSQLCompanion(
        id: useID ? Value(entry.id) : const Value.absent(),
        name: Value(entry.value.name),
        parentID: Value(entry.parent == null ? 0 : entry.parent!.id),
        childrenIDs: Value(entry.children.map((e) => e.id).toList()),
        type: Value(entry.value.type),
        dictIDs: Value(entry.value.wordIds),
        isExpanded: Value(entry.value.isExpanded),
        isChecked: Value(entry.value.isChecked)
      );

  }

  // returns the generated id
  Future<int> addEntry(TreeNode<WordListsData> entry) async {

    final sqlEntry = companionFromTreeNode(entry, false);

    int i = await into(wordListsSQL).insert(sqlEntry);

    List items = ( await (select(wordListsSQL)).get());
    for (var i in items){
      //print(i);
    }

    return i;
  }

  /// deletes all entries given by `entries`
  Future deleteEntries(List<TreeNode<WordListsData>> entries) {

    return (delete(wordListsSQL)
      ..where((tbl) => tbl.id.isIn(entries.map((e) => e.id))))
      .go();

  }

  /// Updates the SQL using the given entry.
  /// The entry must exist in the database
  /// Returns the amount of rows that have been affected by this operation.
  Future<int> updateEntry(TreeNode<WordListsData> entry) {

    final sqlEntry = companionFromTreeNode(entry, true);

    return (update(wordListsSQL)
      ..where((tbl) => tbl.id.equals(entry.id)))
      .write(sqlEntry);

  }

  /// Updates the SQL using the given entries.
  /// The entries must exist in the database
  /// Returns a list of amount of rows that have been affected by this operation.
  Future<List<int>> updateEntries(List<TreeNode<WordListsData>> entries) async {

    List<int> updated = [];

    for(var entry in entries){
      var sqlEntry = companionFromTreeNode(entry, true);

      updated.add(await (update(wordListsSQL)
        ..where((tbl) => tbl.id.equals(entry.id)))
        .write(sqlEntry));
    }

    return updated;
  }

  @override
  int get schemaVersion => 1;

}

