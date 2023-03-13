import 'dart:convert';
import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:tuple/tuple.dart';

part 'word_lists.g.dart';



/// types of nodes in the word lists
enum WordListNodeType{
  folder,
  folderDefault,
  wordList,
  wordListDefault,
  root
}

/// List containing all types that are a folders
List<WordListNodeType> get wordListFolderTypes => [
  WordListNodeType.folder,
  WordListNodeType.folderDefault,
];

/// List containing all types that are a word lists
List<WordListNodeType> get wordListListypes => [
  WordListNodeType.wordList,
  WordListNodeType.wordListDefault,
];

/// List containing all types that are a default nodes
List<WordListNodeType>  get wordListDefaultTypes => [
  WordListNodeType.folderDefault,
  WordListNodeType.wordListDefault,
];

/// List containing all types that are a user created nodes
List<WordListNodeType> get wordListUserTypes => [
  WordListNodeType.folder,
  WordListNodeType.wordList,
];

enum WordListsDefaults{
  searchHistory,
}

/// The tree of word lists and folders that the user has created
///
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable(explicitToJson: true)
class WordLists {

  /// The root node of the word lists
  late TreeNode<Tuple3<String, WordListNodeType, List<int>>> root;

  WordLists(){
    root = TreeNode<Tuple3<String, WordListNodeType, List<int>>>(
      Tuple3("Word Lists", WordListNodeType.root, []),
    );
    
    addDefaults();
  }

  /// Addes the default folder and lists to the word lists
  void addDefaults(){
    /// add the defaults folder
    TreeNode<Tuple3<String, WordListNodeType, List<int>>> defaults =
      TreeNode<Tuple3<String, WordListNodeType, List<int>>>(
        Tuple3("Defaults", WordListNodeType.folderDefault, []),
      );
    root.addChild(defaults);

    // add defaults lists
    for (var element in WordListsDefaults.values) {
      defaults.addChild(
        TreeNode<Tuple3<String, WordListNodeType, List<int>>>(
          Tuple3(element.name, WordListNodeType.wordListDefault, []),
        )
      );
    }
  }

  /// Saves the word lists to shared preferences
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('wordLists', toJson().toString());
  }

  /// Loads the word lists from shared preferences.
  /// Returns true if the word lists were loaded successfully, false otherwise.
  Future<bool> load() async {

    bool loaded = false;

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // load values from shared preferences
    String tmp = prefs.getString('wordLists') ?? "";
    if(tmp != ""){
      root = TreeNode.fromJson(jsonDecode(tmp));
      loaded = true;
    }
    
    return loaded;
  }
  
  /// Instantiates a new instance from a json map
  factory WordLists.fromJson(Map<String, dynamic> json) 
    => _$WordListsFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$WordListsToJson(this);
}