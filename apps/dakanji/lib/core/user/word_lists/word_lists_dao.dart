import 'package:da_kanji_mobile/core/tree/tree_node.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/core/user/word_lists/word_lists_tables.dart';
import 'package:da_kanji_mobile/features/word_lists/controller/default_word_lists_queries.dart';
import 'package:da_kanji_mobile/features/word_lists/model/default_names.dart';
import 'package:da_kanji_mobile/features/word_lists/model/word_list_types.dart';
import 'package:da_kanji_mobile/features/word_lists/model/word_lists_data.dart';
import 'package:da_kanji_mobile/features/word_lists/model/word_lists_tree.dart';
import 'package:drift/drift.dart';

part 'word_lists_dao.g.dart';


@DriftAccessor(
  tables: [
    WordListNodesTable, WordListEntriesTable
  ]
)
class WordListsDao extends DatabaseAccessor<UserDataDB> with _$WordListsDaoMixin {

  WordListsDao(super.db);

    // --- START : GENERAL ----------
  /// Initializes this instance by checking if is empty and if so adding a 
  /// root node
  Future init () async {

    int count = await wordListNodesTable.count().getSingle();

    // when the DB is opened for the first time add a root and the default folders
    if(count == 0){
      TreeNode<WordListsData> root = TreeNode<WordListsData>(
        WordListsData("", WordListNodeType.root, [], true),
        id: 0,);
      await _addNode(root, true);
      await addDefaultsToRoot(root);
    }

  }

  Future deleteAllWordLists() async {

    await transaction(() async {
      await delete(wordListEntriesTable).go();
      await delete(wordListNodesTable).go();
    });

  }

  
  // --- END : GENERAL


  // --- START : WordListsSQL
  /// Instantiates a [WordListsSQLCompanion] from a [TreeNode<WordListsData>]
  WordListNodesTableCompanion companionFromTreeNode(TreeNode<WordListsData> entry, bool useID){

    return WordListNodesTableCompanion(
        id: useID ? Value(entry.id) : const Value.absent(),
        name: Value(entry.value.name),
        childrenIDs: Value(entry.children.map((e) => e.id).toList()),
        type: Value(entry.value.type),
        isExpanded: Value(entry.value.isExpanded),
      );

  }

  /// A stream that emits whenever a value of this database changes
  Stream<List<WordListNodesTableData>> watchAllWordlists(){

    return select(wordListNodesTable).watch();

  }

  /// Adds the defaults folder / lists
  Future addDefaultsToRoot(TreeNode<WordListsData> root) async {

    TreeNode<WordListsData> defaultsFolder = TreeNode<WordListsData>(
      WordListsData("Defaults", WordListNodeType.folder, [], true),
    );

    transaction(() async {
      // add all default lists to the defaults folder
      for (var element in DefaultNames.values) {

        TreeNode<WordListsData> defaultNode = TreeNode(
            WordListsData(element.name, WordListNodeType.wordList, [], true),
          );

        int id = await into(wordListNodesTable).insert(
          companionFromTreeNode(defaultNode, false));
        defaultNode.id = id;

        defaultsFolder.addChild(defaultNode);

        // add the actual entries to this list
        addEntriesToWordLists(
          [defaultNode.id],
          getEntryIDsOfDefaultList(defaultNode.value.name));
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

    // load word lists from sql
    final tree = WordListsTree.fromWordListsSQL(
      (await select(wordListNodesTable).get())
    );
    // readd the defaults
    addDefaultsToRoot(tree.root);
    
  }

  /// Adds the given `node` to the database, if `useID == true` use the id of
  /// the given `node`, otherwise SQLite will assign an ID
  /// returns the generated id
  Future<int> _addNode(TreeNode<WordListsData> node, bool useID) async {

    final sqlEntry = companionFromTreeNode(node, useID);

    int i = await into(wordListNodesTable).insert(sqlEntry);

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
      int folderId = await into(wordListNodesTable)
        .insert(companionFromTreeNode(folder, false));
      folder.id = folderId;

      // update the remaining affected nodes
      await batch((batch) {
        for (var node in (affectedNodes).nonNulls){
          var sqlNode = companionFromTreeNode(node, true);
          batch.update(
            wordListNodesTable, sqlNode,
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

    return (update(wordListNodesTable)
      ..where((tbl) => tbl.id.equals(node.id)))
      .write(sqlEntry);

  }

  /// Updates the SQL using the given entries.
  Future<void> updateNodes(List<TreeNode<WordListsData>?> nodes) async {

    await batch((batch) {
      for (var node in nodes.nonNulls){
        var sqlNode = companionFromTreeNode(node, true);
        batch.update(
          wordListNodesTable, sqlNode,
          where: (table) => table.id.equals(node.id),
        );
      }
    });

  }

  /// Deletes the given `entry` and the whole subtree
  Future deleteNodeAndSubTree(TreeNode<WordListsData> node) async {

    // remove node from its parent
    final parent = node.parent!;
    parent.removeChild(node);
    
    await transaction(() async {
      // update the parent
      await updateNode(parent);

      // delete all child nodes
      List<int> entries = node.dfs().map((e) => e.id).toList();
      entries.add(node.id);

      await (delete(wordListNodesTable)
        ..where((tbl) => tbl.id.isIn(entries)))
        .go();

      // remove all dictionary entries that belonged to a now deleted node
      await (delete(wordListEntriesTable)
        ..where((tbl) => tbl.wordListID.isIn(entries))
      ).go();

    });
    

  }
  
  /// Get all IDs of all nodes that the user defined
  Future<List<int>> getAllNodeIDs(){

    final idColumn = wordListNodesTable.id; 
    final query = selectOnly(wordListNodesTable)
      ..addColumns([idColumn]);
      
    return query.map(
      (row) => row.read(idColumn)!)
      .get();

  } 
  // --- END : WordLists 


  // --- START : WordListsNode
  /// Returns a list of WordIDs that belong to the word list given by
  /// `wordListID`
  Future<List<int>> getEntryIDsOfWordList(int wordListID) async {

    return (await (select(wordListEntriesTable)
      ..where((tbl) => tbl.wordListID.equals(wordListID)))
      .get())
      .map((p0) => p0.dictEntryID).toList();

  }

  /// A stream that emits whenever a value of the given word list changes
  Stream<List<WordListEntriesTableData>> watchWordlistEntries(int wordListID){

    return (select(wordListEntriesTable)
      ..where((tbl) => tbl.wordListID.equals(wordListID),))
      .watch();

  }

  /// Adds the words given by `wordIDs` to every word list given by `listIDs`
  Future addEntriesToWordLists(List<int> listIDs, List<int> wordIDs) async {

    await transaction(() async {

      // add to every list ...
      for (int listID in listIDs ) {
        await batch((batch) async {
          // ... all IDs
          for (int wordID in wordIDs){
            await wordListEntriesTable.insertOnConflictUpdate(
              WordListEntriesTableCompanion(
                wordListID : Value(listID),
                dictEntryID: Value(wordID),
                timeAdded  : Value(DateTime.now())
              )
            );
          }
        });
      }

    });

  }
 
  /// Copies all entries from each word list given by the list `fromID` to
  /// the list `toID`
  Future copyEntriesFromListsToList(Iterable<int> fromIDs, int toID) async {

    await transaction(() async {
      for (int fromID in fromIDs) {
        List<int> wordIDs = await getEntryIDsOfWordList(fromID);
        await addEntriesToWordLists([toID], wordIDs);
      }
    });

  }

  /// Deletes the entries given by their IDs, from the word list given by its
  /// ID
  Future deleteEntriesFromWordList(Iterable<int> entriesIDs, int wordListID) async {

    await wordListEntriesTable.deleteWhere((tbl) {
      return Expression.and([
        tbl.dictEntryID.isIn(entriesIDs),
        tbl.wordListID.equals(wordListID),
      ]);
    });

  }
  // --- END : WordListsNode

}