import 'package:tuple/tuple.dart';

import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/word_lists.dart';



/// Class to store arguments for navigating with named routs
class NavigationArguments{

  /// was the route opened by the navigation drawer
  final bool navigatedByDrawer;

  // DRAWING
  /// prefix that should be prepended to every search query
  final String drawSearchPrefix;
  /// postfix that should be appended to every search query
  final String drawSearchPostfix;

  //DICT
  /// query that should be searched when navigating the dictionary screen
  final String dictSearch;

  // WORD LISTS
  /// node of the word list screen that should be opened
  final TreeNode<Tuple3<String, WordListNodeType, List<int>>>? wordListScreenNode;
  

  NavigationArguments(
    this.navigatedByDrawer,
    {
      this.drawSearchPrefix = "",
      this.drawSearchPostfix = "",

      this.dictSearch = "",

      this.wordListScreenNode = null
    }
  );

}