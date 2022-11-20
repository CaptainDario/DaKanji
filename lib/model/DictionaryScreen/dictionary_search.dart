import 'package:async/async.dart';

import 'search_isolate.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;



/// Class that spawns a number of isolates to search efficiently in the dictionary
class DictionarySearch {

  /// Number of isolates that should be created for searching in the dictionary
  int noIsolates;
  /// A list of languages that should be included when searching in the dictionary
  List<String> languages;
  /// list of all search isolats used for searching in the dictionary
  List<SearchIsolate> _searchIsolates = [];
  /// Has this object been initialized
  bool _initialized = false;

  DictionarySearch(this.noIsolates, this.languages);

  /// Needs to be called before using this object
  void init () async {
    
    for (var i = 0; i < noIsolates; i++) {
      _searchIsolates.add(SearchIsolate(languages)..init(i, noIsolates));
    }

    _initialized = true;
  }

  Future<List<isar_jm.Entry>> query (String queryText) async {
    _checkInitialized();

    FutureGroup<List<isar_jm.Entry>> searchGroup = FutureGroup();

    for (var i = 0; i < noIsolates; i++) {
      searchGroup.add(_searchIsolates[i].query(queryText));
    }
    searchGroup.close();

    print((await searchGroup.future).length);
    
    return [];//searchGroup.future;
  }

  /// terminates all isolates and cleans memory
  void kill() {
    for (var searchIsolate in _searchIsolates) {
      searchIsolate.kill();
    }
    _initialized = false;
  }

  /// convenience function to check if `init()` was called.
  /// Throws an Exxception if it was not initialized.
  void _checkInitialized() {
    if(!_initialized) throw Exception("The isolate needs to be ");
  }

}