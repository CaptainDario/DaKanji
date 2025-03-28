// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';

/// Class to store information about a dictionary search.
/// Notifies its listeners when the selected results changes.
class DictSearch with ChangeNotifier {

  /// the string that is currently searched
  String currentSearch = "";
  /// the string (converted to kana) that is currently searched
  String currentKanaSearch = "";
  /// the strings (alternatives such as misspellings and deconjugations) that
  /// are curreently searched
  List<String> currentAlternativeSearches = [];

  /// a list of all search results
  List<List<JMdict>> _searchResults = [];
  List<List<JMdict>> get searchResults => _searchResults;
  set searchResults(List<List<JMdict>> newResults){
    _searchResults = newResults;
    notifyListeners();
  }

  /// the selected search Result
  JMdict? _selectedResult;
  set selectedResult (JMdict? newEntry){
    _selectedResult = newEntry;
    notifyListeners();
  }
  JMdict? get selectedResult {
    return _selectedResult;
  }
}
