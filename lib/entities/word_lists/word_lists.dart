// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/default_names.dart';

part 'word_lists.g.dart';



/// The tree of word lists and folders that the user has created
///
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable(explicitToJson: true)
class WordLists {

  /// The root node of the word lists
  @JsonKey(includeFromJson: false, includeToJson: false)
  late TreeNode<WordListsData> root = TreeNode<WordListsData>(
      WordListsData("", WordListNodeType.root, [], true),
    );

  /// the node that contains the default word lists
  @JsonKey(includeFromJson: false, includeToJson: false)
  TreeNode<WordListsData> defaults = TreeNode<WordListsData>(
      WordListsData(DefaultNames.defaults.name, WordListNodeType.folderDefault, [], false),
    );

  @JsonKey(includeFromJson: true, includeToJson: true)
  List<TreeNode<WordListsData>> userCreatedLists = [];


  WordLists(){
    
    /// add the defaults folder / lists
    root.addChild(defaults);
    for (var element in DefaultNames.values) {
      if(element == DefaultNames.defaults) continue;

      defaults.addChild(
        TreeNode<WordListsData>(
          WordListsData(element.name, WordListNodeType.wordListDefault, [], false),
        )
      );
    }

    // always save when the lists tree changes
    root.addListener(() async {
      await save();
    });
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
      WordLists wL = WordLists.fromJson(jsonDecode(tmp));
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
  factory WordLists.fromJson(Map<String, dynamic> json) 
    => _$WordListsFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() {

    Map<String, dynamic> jsonMap = _$WordListsToJson(this);

    return jsonMap;
  }
}