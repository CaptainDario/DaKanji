import 'package:flutter/foundation.dart';

import 'package:database_builder/database_builder.dart';



/// Class to store information about a dictionary search.
/// Notifies its listeners when the selected results changes.
class DictSearch with ChangeNotifier {

  /// the string that is currently searched
  String currentSearch = "";

  /// a list of all search results
  List searchResults = [];

  /// the selected search Result
  JMdict? _selectedResult;
  set selectedResult (JMdict? newEntry){
    _selectedResult = newEntry;
    notifyListeners();
  }
  JMdict? get selectedResult {
    return _selectedResult;
  }

  /// the KanjiVG entries matching `selectedResult`
  List<KanjiSVG> kanjiVGs = [];

  /// the KanjiDic entries matching `selectedResult`
  List<Kanjidic2> kanjiDic2s = [];
}