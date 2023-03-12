import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/model/tree_node.dart';

part 'word_lists.g.dart';



///
///
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable(explicitToJson: true)
class WordLists {

  /// The root node of the word lists
  TreeNode<String> root;

  WordLists(this.root);

  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('wordLists', toJson().toString());
  }

  Future<void> load() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // load values from shared preferences
    String tmp = prefs.getString('wordLists') ?? "";
    if(tmp != ""){
      root = TreeNode<String>.fromJson(jsonDecode(tmp));
    }
    else{
      root = TreeNode<String>("root");
    }
  }
  
  /// Instantiates a new instance from a json map
  factory WordLists.fromJson(Map<String, dynamic> json) 
    => _$WordListsFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$WordListsToJson(this);
}