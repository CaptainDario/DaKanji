// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';

/// Class to store information about a dictionary search.
/// Notifies its listeners when the selected results changes.
class DictSearch with ChangeNotifier {

  /// the string that is currently searched
  String currentSearch = "";

  /// a list of all search results
  List<JMdict> _searchResults = [];
  List<JMdict> get searchResults => _searchResults;
  set searchResults(List<JMdict> newResults){
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
