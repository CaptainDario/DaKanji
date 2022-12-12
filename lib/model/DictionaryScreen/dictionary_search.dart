import 'package:async/async.dart';

import 'search_isolate.dart';



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

  /// 
  Future<List> query (String queryText) async {
    _checkInitialized();

    FutureGroup<List> searchGroup = FutureGroup();

    for (var i = 0; i < noIsolates; i++) {
      searchGroup.add(_searchIsolates[i].query(queryText));
    }
    searchGroup.close();

    final result = (await searchGroup.future).expand((x) => x).toList();

    return result;
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
    if(!_initialized) throw Exception("The isolate needs to be initilized");
  }

}