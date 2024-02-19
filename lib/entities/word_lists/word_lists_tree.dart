// Package imports:
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';



/// The tree of word lists and folders that the user has created
///
/// To update the toJson code run
class WordListsTree {

  /// The root node of the word lists
  late TreeNode<WordListsData> root;

  /// Initializes an empty word lists tree
  WordListsTree();

  /// Constructs a wordlist tree from a SQL WordList database
  WordListsTree.fromWordListsSQL(List<WordListsSQLData> sqlList){

    // assure that the root is in the DB and set it
    if(sqlList.isEmpty){
      throw Exception("No root in SQL!");
    }
    
    // Parse the data from SQL to a list
    // format: {own_id : (parent id, [children ids], parsed node)}
    Map<int, Tuple2<List<int>, TreeNode<WordListsData>>> nodes = {};
    for (var data in sqlList) {
      nodes[data.id] = Tuple2(data.childrenIDs, treeNodeWordListFromSQLData(data));
    }

    // iterate over the items and build the tree recursevily
    for (Tuple2<List<int>, TreeNode<WordListsData>> value in nodes.values) {

      List<int> childIDs = value.item1;
      TreeNode<WordListsData> node = value.item2;

      for(int childID in childIDs){
        node.addChild(nodes[childID]!.item2);
      }
    }

    // set the root
    root = nodes[0]!.item2;

  }
  
  /// Parses a [WordListsSQLData] into a [TreeNode<WordListsData>] and returns
  /// it
  static TreeNode<WordListsData> treeNodeWordListFromSQLData(WordListsSQLData data){

    return TreeNode(
      WordListsData(
        data.name, data.type, data.dictIDs, data.isExpanded
      ),
      id: data.id,
    );

  }
  
}
