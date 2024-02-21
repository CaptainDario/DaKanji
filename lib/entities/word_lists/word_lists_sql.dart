// Dart imports:
import 'dart:io';

// Package imports:
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

// Project imports:
import 'package:da_kanji_mobile/application/sqlite/sql_utils.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/default_names.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_tree.dart';

part 'word_lists_sql.g.dart';



/// SQLite table for the wordlists (ie.: folders and word list nodes)
/// NOT the actual word list entries
class WordListsSQL extends Table {
  
  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The name of this wordlist entry
  TextColumn get name => text()();
  /// All children IDs
  TextColumn get childrenIDs => text().map(const ListIntConverter())();
  /// The type of this entry
  IntColumn get type => intEnum<WordListNodeType>()();
  /// Is this entry currently expanded
  BoolColumn get isExpanded => boolean().clientDefault(() => false)();

}

/// Table of the actual dict entries that belong to a word lists in a
/// [WordListsSQL]
class WordListsNodeSQL extends Table {

  /// Id of this row
  IntColumn get id => integer().autoIncrement()();
  /// The id of the entry in the corresponding [WordListsSQL] 
  IntColumn get wordListID => integer()();
  /// The id of this entry in the dictionary
  IntColumn get dictEntryID => integer()();

}

@DriftDatabase(tables: [WordListsSQL, WordListsNodeSQL])
class WordListsSQLDatabase extends _$WordListsSQLDatabase {

  @override
  int get schemaVersion => 1;

  WordListsSQLDatabase(
    File databaseFile
  ) : super(openSqlite(databaseFile));


  // --- START : GENERAL ----------
  /// Initializes this instance by checking if is empty and if so adding a 
  /// root node
  Future init () async {

    int count = await wordListsSQL.count().getSingle();

    // when the DB is opened for the first time add a root and the default folders
    if(count == 0){
      TreeNode<WordListsData> root = TreeNode<WordListsData>(
        WordListsData("", WordListNodeType.root, [], true),
        id: 0,);
      await _addNode(root, true);
      await addDefaultsToRoot(root);
    }

  }

  /// Deletes every entry in this database
  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
  
  // --- END : GENERAL


  // --- START : WordListsSQL
  /// Instantiates a [WordListsSQLCompanion] from a [TreeNode<WordListsData>]
  WordListsSQLCompanion companionFromTreeNode(TreeNode<WordListsData> entry, bool useID){

    return WordListsSQLCompanion(
        id: useID ? Value(entry.id) : const Value.absent(),
        name: Value(entry.value.name),
        childrenIDs: Value(entry.children.map((e) => e.id).toList()),
        type: Value(entry.value.type),
        isExpanded: Value(entry.value.isExpanded),
      );

  }

  /// A stream that emits whenever a value of this database changes
  Stream<List<WordListsSQLData>> watchAllWordlists(){

    return select(wordListsSQL).watch();

  }

  /// Adds the defaults folder / lists
  Future addDefaultsToRoot(TreeNode<WordListsData> root) async {

    TreeNode<WordListsData> defaultsFolder = TreeNode<WordListsData>(
      WordListsData(DefaultNames.defaults.name, WordListNodeType.folderDefault, [], true),
    );

    transaction(() async {
      // add all default lists to the defaults folder
      for (var element in DefaultNames.values) {
        if(element == DefaultNames.defaults) continue;

        TreeNode<WordListsData> defaultNode = TreeNode(
            WordListsData(element.name, WordListNodeType.wordListDefault, [], true),
          );

        int id = await into(wordListsSQL).insert(companionFromTreeNode(defaultNode, false));
        defaultNode.id = id;

        defaultsFolder.addChild(defaultNode);
      }

      // add the defaults folder to SQLite
      int defaultsFolderSQLID = await _addNode(defaultsFolder, false);
      defaultsFolder.id = defaultsFolderSQLID;
      // update the root
      root.addChild(defaultsFolder);
      await updateNode(root);
    });

  }

  /// Readds the defaults folde to the root
  Future readdDefaultsToRoot() async {

    // check if the defaults folder still exists
    bool containsDefaults = (
      await (select(wordListsSQL)
        ..where((tbl) => tbl.type.equals(WordListNodeType.folderDefault.index)))
        .get()
    ).isNotEmpty;

    // if not, readd it
    if(!containsDefaults){
      // load word lists from sql
      final tree = WordListsTree.fromWordListsSQL(
        (await select(wordListsSQL).get())
      );
      // readd the defaults
      addDefaultsToRoot(tree.root);
    }
  }

  /// Adds the given `node` to the database, if `useID == true` use the id of
  /// the given `node`, otherwise SQLite will assign an ID
  /// returns the generated id
  Future<int> _addNode(TreeNode<WordListsData> node, bool useID) async {

    final sqlEntry = companionFromTreeNode(node, useID);

    int i = await into(wordListsSQL).insert(sqlEntry);

    return i;
  }

  /// Adds the given `node` to the given `root` updating the IDs correctly 
  Future addNodeToRoot(TreeNode<WordListsData> node, TreeNode<WordListsData> root) async {
    
    transaction(() async {

      int addedNodeID = await _addNode(node, false);

      node.id = addedNodeID;
      root.addChild(node);

      await updateNode(root);

    });

  }

  /// Adds `folder` as a new folder to the database and udpates all
  /// `affectedNodes`
  Future addFolderWithNodes(TreeNode<WordListsData> folder,
    List<TreeNode<WordListsData>?> affectedNodes) async {

    return transaction(() async {
      // first, add the folder and await its ID
      int folderId = await into(wordListsSQL)
        .insert(companionFromTreeNode(folder, false));
      folder.id = folderId;

      // update the remaining affected nodes
      await batch((batch) {
        for (var node in (affectedNodes).whereNotNull()){
          var sqlNode = companionFromTreeNode(node, true);
          batch.update(
            wordListsSQL, sqlNode,
            where: (table) => table.id.equals(node.id),
          );
        }
      });
    });
  }

  /// Updates the SQL using the given entry.
  /// The entry must exist in the database
  /// Returns the amount of rows that have been affected by this operation.
  Future<int> updateNode(TreeNode<WordListsData> node) {

    final sqlEntry = companionFromTreeNode(node, true);

    return (update(wordListsSQL)
      ..where((tbl) => tbl.id.equals(node.id)))
      .write(sqlEntry);

  }

  /// Updates the SQL using the given entries.
  Future<void> updateNodes(List<TreeNode<WordListsData>?> nodes) async {

    await batch((batch) {
      for (var node in nodes.whereNotNull()){
        var sqlNode = companionFromTreeNode(node, true);
        batch.update(
          wordListsSQL, sqlNode,
          where: (table) => table.id.equals(node.id),
        );
      }
    });

  }

  /// Deletes the given `entry` and the whole subtree
  Future deleteNodeAndSubTree(TreeNode<WordListsData> node) {

    List<int> entries = node.dfs().map((e) => e.id).toList();
    entries.add(node.id);

    return (delete(wordListsSQL)
      ..where((tbl) => tbl.id.isIn(entries)))
      .go();

  }
  // --- END : WordLists 


  // --- START : WordListsNode
  /// Returns a list of WordIDs that belong to the word list given by
  /// `wordListID`
  Future<List<int>> getEntryIDsOfWordList(int wordListID) async {

    return (await (select(wordListsNodeSQL)
      ..where((tbl) => tbl.wordListID.equals(wordListID)))
      .get())
      .map((p0) => p0.dictEntryID).toList();

  }

  /// Adds the words given by `wordIDs` to every word list given by `listIDs`
  Future addEntriesToWordLists(List<int> listIDs, List<int> wordIDs) async {

    await transaction(() async {

      // add to every list ...
      for (int listID in listIDs ) {
        await batch((batch) async {
          // ... all IDs
          await wordListsNodeSQL.insertAll(
            [
              for (int wordID in wordIDs)
                WordListsNodeSQLCompanion(
                  wordListID: Value(listID),
                  dictEntryID: Value(wordID)
                )
            ]
          );
        });
      }

    });

  }
  // --- END : WordListsNode

}

