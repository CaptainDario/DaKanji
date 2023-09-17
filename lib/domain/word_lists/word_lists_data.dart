// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/domain/tree/tree_node_serializable.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists.dart';

part 'word_lists_data.g.dart';



/// The data of a word list node, notifiers listeners when the data changes
/// 
/// To update the toJson code run
/// `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class WordListsData with ChangeNotifier implements TreeNodeSerializable {

  /// The name of the word list node
  String _name;
  /// The name of the word list node
  String get name => _name;
  /// The name of the word list node
  set name(String value){
    _name = value;
    notifyListeners();
  }

  /// The type of the word list node
  final WordListNodeType type;

  /// The ids of the words in this word list (has no effect if `type` is folder)
  List<int> _wordIds;
  /// The ids of the words in this word list (has no effect if `type` is folder)
  List<int> get wordIds => _wordIds;
  /// The ids of the words in this word list (has no effect if `type` is folder)
  set wordIds(List<int> value){
    _wordIds = value;
    notifyListeners();
  }

  /// Is this node's UI is expanded (has no effect if `type` is list)
  bool _isExpanded;
  /// Is this node's UI is expanded (has no effect if `type` is list)
  bool get isExpanded => _isExpanded;
  /// Is this node's UI is expanded (has no effect if `type` is list)
  set isExpanded(bool value){
    _isExpanded = value;
    notifyListeners();
  }

  /// Is this node's checkbox checked
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool _isChecked = false;
  /// Is this node's checkbox checked
  bool get isChecked => _isChecked;
  /// Is this node's checkbox checked
  set isChecked(bool value){
    _isChecked = value;
    notifyListeners();
  }


  WordListsData(
    String name,
    this.type,
    List<int> wordIds,
    bool isExpanded
  ):
    _name = name,
    _wordIds = wordIds,
    _isExpanded = isExpanded;

  /// Create a new WordListsData object from a JSON object.
  factory WordListsData.fromJson(Map<String, dynamic> json)
    => _$WordListsDataFromJson(json);

  /// Convert this object to a JSON object.
  Map<String, dynamic> toJson()
    => _$WordListsDataToJson(this);
}
