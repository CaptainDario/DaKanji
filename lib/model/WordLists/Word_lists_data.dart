import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';



/// The data of a word list node
class WordListsData {

  /// The name of the word list node
  String name;
  /// The type of the word list node
  WordListNodeType type;
  /// The ids of the words in this word list (has no effect if `type` is folder)
  List<int> wordIds;
  /// Is this node's UI is expanded (has no effect if `type` is list)
  bool isExpanded;

  WordListsData(
    this.name,
    this.type,
    this.wordIds,
    this.isExpanded
  );

}