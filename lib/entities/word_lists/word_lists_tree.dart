// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/default_names.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:tuple/tuple.dart';

part 'word_lists_tree.g.dart';



/// The tree of word lists and folders that the user has created
///
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable(explicitToJson: true)
class WordListsTree {

  /// The root node of the word lists
  @JsonKey(includeFromJson: false, includeToJson: false)
  late TreeNode<WordListsData> root = TreeNode<WordListsData>(
      WordListsData("", WordListNodeType.root, [], true),
      id: 0,
      automaticallyUpdateIDs: false
    );

  @JsonKey(includeFromJson: true, includeToJson: true)
  List<TreeNode<WordListsData>> userCreatedLists = [];


  WordListsTree(){
    
    addDefaultsToRoot();

    // always save when the lists tree changes
    //root.addListener(() async {
    //  await save();
    //});
  }

  /// Constructs a wordlist tree from a SQL WordList database
  WordListsTree.fromWordListsSQL(List<WordListsSQLData> sqlList){

    root.automaticallyUpdateIDs = false;

    addDefaultsToRoot();

    // Parse the data from SQL to a list
    // format: {own_id : (parent id, [children ids], parsed node)}
    Map<int, Tuple3<int, List<int>, TreeNode<WordListsData>>> nodes = {};
    for (var data in sqlList) {
      nodes[data.id] = Tuple3(
        data.parentID, data.childrenIDs, treeNodeWordListFromSQLData(data));
    }

    // iterate over the items and build the tree recursevily
    for (Tuple3<int, List<int>, TreeNode<WordListsData>> value in nodes.values) {

      int parentID = value.item1;
      List<int> childIDs = value.item2;
      TreeNode<WordListsData> node = value.item3;

      // add top level lists
      if(parentID == 0) {
        root.addChild(node);
      }
      // add children
      for (int childID in childIDs) {
        node.addChild(nodes[childID]!.item3);
      }

    }
    root.updateLevel();

  }
  
  /// Parses a [WordListsSQLData] into a [TreeNode<WordListsData>] and returns
  /// it
  TreeNode<WordListsData> treeNodeWordListFromSQLData(WordListsSQLData data){

    return TreeNode(
      WordListsData(
        data.name, data.type, data.dictIDs, data.isExpanded
      ),
      id: data.id,
      automaticallyUpdateIDs: false,
    );

  }

  /// Adds the defaults folder / lists
  void addDefaultsToRoot(){

    TreeNode<WordListsData> defaults = TreeNode<WordListsData>(
      WordListsData(DefaultNames.defaults.name, WordListNodeType.folderDefault, [], false),
    );

    root.addChild(defaults);
    for (var element in DefaultNames.values) {
      if(element == DefaultNames.defaults) continue;

      defaults.addChild(
        TreeNode<WordListsData>(
          WordListsData(element.name, WordListNodeType.wordListDefault, [], false),
        )
      );
    }

  }

  /// Saves the word lists to shared preferences
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // get the user created lists
    userCreatedLists = root.children.where(
      (element) => wordListUserTypes.contains(element.value.type)
    ).toList();

    // set value in shared preferences
    String encoded = jsonEncode(toJson());
    await prefs.setString('wordLists', encoded);
  }

  /// Loads the word lists from shared preferences.
  /// Returns `true` if loading was successful, `false` otherwise.
  Future<bool> load() async {

    bool loaded = false;

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // load values from shared preferences
    String tmp = prefs.getString('wordLists') ?? "";
    if(tmp != ""){
      WordListsTree wL = WordListsTree.fromJson(jsonDecode(tmp));
      root.addChildren(wL.userCreatedLists);

      // add save listeners to all nodes
      for (var node in root.bfs()) {
        node.value.addListener(() {
          save();
        });
      }

      loaded = true;
    }

    return loaded;
  }
  
  /// Instantiates a new instance from a json map
  factory WordListsTree.fromJson(Map<String, dynamic> json) 
    => _$WordListsTreeFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() {

    Map<String, dynamic> jsonMap = _$WordListsTreeToJson(this);

    return jsonMap;
  }
}
