import 'package:async/async.dart';

import 'package:database_builder/database_builder.dart';

import 'dictionary_search_util.dart';
import 'search_isolate.dart';



/// Class that spawns a number of isolates to search efficiently in the dictionary.
class DictionarySearch {

  /// Number of isolates that should be created for searching in the dictionary
  int noIsolates;
  /// A list of languages that should be included when searching in the dictionary
  List<String> languages;
  /// list of all search isolats used for searching in the dictionary
  List<SearchIsolate> _searchIsolates = [];
  /// Has this object been initialized
  bool _initialized = false;
  /// The directory of the ISAR file of the dictionary
  String directory;
  /// The name of the ISAR file of the dictionary
  String name;
  /// Is a search currently running
  bool _isSearching = false;
  /// The last query that was blocked by a running search
  String? _lastBlockedQuery;
  /// Should the search be converted to hiragana
  bool convertToHiragana;


  DictionarySearch(
    this.noIsolates, this.languages, this.directory, this.name, this.convertToHiragana
  );


  /// Needs to be called before using this object
  void init () async {
    
    for (var i = 0; i < noIsolates; i++) {
      _searchIsolates.add(SearchIsolate(
        languages, directory, name, convertToHiragana,
      )
      ..init(i, noIsolates));
    }

    _initialized = true;
  }

  /// Queries the database and sorts the results using multiple isolates.
  Future<List<JMdict>?> query (String queryText) async {
    _checkInitialized();

    // do not search if a search is already running but remember the last blocked query
    if(_isSearching){
      _lastBlockedQuery = queryText;
      return null;
    }
    _isSearching = true;

    // search in `noIsolates` separte Isolates 
    FutureGroup<List> searchGroup = FutureGroup();
    for (var i = 0; i < noIsolates; i++) {
      searchGroup.add(_searchIsolates[i].query(queryText));
    }
    searchGroup.close();

    // wait for all isolates to finish and merge the results to one list
    final search_result =
      List<JMdict>.from((await searchGroup.future).expand((e) => e));
    // sort and merge the results
    final sort_result = sortJmdictList(
      search_result, queryText, this.languages, this.convertToHiragana
    );
    var result = sort_result.expand((element) => element).toList();
    _isSearching = false;

    // if one or more queries were made while this one was running, run the last
    // one
    if(_lastBlockedQuery != null){
      var t = _lastBlockedQuery;
      _lastBlockedQuery = null;
      result = (await query(t!)) ?? [];
      _lastBlockedQuery = null;
    }
    
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