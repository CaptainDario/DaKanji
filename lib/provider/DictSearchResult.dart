import 'package:database_builder/src/jm_enam_and_dict_to_hive/dataClasses_objectbox.dart';
import 'package:flutter/foundation.dart';



/// Class to store information about a dictionary search
/// Notifies its listeners when the selected results changes
class DictSearch with ChangeNotifier {

  /// the string that is currently searched
  String currentSearch = "";

  /// a list of all search results
  List<Jm_enam_and_dict_Entry> searchResults = [];

  /// the selected search Result
  Jm_enam_and_dict_Entry? _selectedResult;

  set selectedResult (Jm_enam_and_dict_Entry? newEntry){
    _selectedResult = newEntry;
    notifyListeners();
  }

  Jm_enam_and_dict_Entry? get selectedResult {
    return _selectedResult;
  }

}