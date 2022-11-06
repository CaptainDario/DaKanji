import 'package:flutter/foundation.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as _isar;



/// Class to store information about a dictionary search.
/// Notifies its listeners when the selected results changes.
class DictSearch with ChangeNotifier {

  /// the string that is currently searched
  String currentSearch = "";

  /// a list of all search results
  List<_isar.Entry> searchResults = [];

  /// the selected search Result
  _isar.Entry? _selectedResult;

  set selectedResult (_isar.Entry? newEntry){
    _selectedResult = newEntry;
    notifyListeners();
  }

  _isar.Entry? get selectedResult {
    return _selectedResult;
  }

}