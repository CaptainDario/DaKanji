import 'package:flutter/foundation.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_db/data_classes.dart' as Jmdict;



/// Class to store information about a dictionary search.
/// Notifies its listeners when the selected results changes.
class DictSearch with ChangeNotifier {

  /// the string that is currently searched
  String currentSearch = "";

  /// a list of all search results
  List<Jmdict.Entry> searchResults = [];

  /// the selected search Result
  Jmdict.Entry? _selectedResult;

  set selectedResult (Jmdict.Entry? newEntry){
    _selectedResult = newEntry;
    notifyListeners();
  }

  Jmdict.Entry? get selectedResult {
    return _selectedResult;
  }

}