import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
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

  /// Initializes this instance by checking if is empty and if so adding a 
  /// root node
  Future init () async {

    int count = await wordListsSQL.count().getSingle();

    if(count == 0){
      await addNode(TreeNode<WordListsData>(
        WordListsData("", WordListNodeType.root, [], true),
        id: 0,
      ));
    }

  }

  /// A stream that emits whenever a value of this database changes
  Stream<List<WordListsSQLData>> watchAllWordlists(){

    return select(wordListsSQL).watch();

  }

  /// Instantiates a [WordListsSQLCompanion] from a [TreeNode<WordListsData>]
  WordListsSQLCompanion companionFromTreeNode(TreeNode<WordListsData> entry, bool useID){

    return WordListsSQLCompanion(
        id: useID ? Value(entry.id) : const Value.absent(),
        name: Value(entry.value.name),
        childrenIDs: Value(entry.children.map((e) => e.id).toList()),
        type: Value(entry.value.type),
        dictIDs: Value(entry.value.wordIds),
        isExpanded: Value(entry.value.isExpanded),
        isChecked: Value(entry.value.isChecked)
      );

  }

  /// Adds the given `node` to the database
  /// returns the generated id
  Future<int> addNode(TreeNode<WordListsData> node) async {

    final sqlEntry = companionFromTreeNode(node, false);

    int i = await into(wordListsSQL).insert(sqlEntry);

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
  Future<int> updateNode(TreeNode<WordListsData> entry) {

    final sqlEntry = companionFromTreeNode(entry, true);

    return (update(wordListsSQL)
      ..where((tbl) => tbl.id.equals(entry.id)))
      .write(sqlEntry);

  }

  /// Adds `folder` as a new folder to the database and adds all `subNodes` as
  /// children to `folder`
  Future addFolderWithNodes(TreeNode<WordListsData> folder,
    List<TreeNode<WordListsData>?> subNodes) async {

    return transaction(() async {
      // first, add the folder and await its ID
      int folderId = await into(wordListsSQL)
        .insert(companionFromTreeNode(folder, false));
      folder.id = folderId;

      // update the remaining affected nodes
      await batch((batch) {
        for (var node in (subNodes..add(folder.parent)).whereNotNull()){
          var sqlNode = companionFromTreeNode(node, true);
          batch.update(
            wordListsSQL, sqlNode,
            where: (table) => table.id.equals(node.id),
          );
        }
      });
    });

  }

  /// Updates the SQL using the given entries.
  Future<void> updateNodes(List<TreeNode<WordListsData>?> entries) async {

    await batch((batch) {
      for (var node in entries.whereNotNull()){
        var sqlNode = companionFromTreeNode(node, true);
        batch.update(
          wordListsSQL, sqlNode,
          where: (table) => table.id.equals(node.id),
        );
      }
    });

  }

  @override
  int get schemaVersion => 1;

}

