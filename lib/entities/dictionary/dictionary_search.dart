// Dart imports:
import 'dart:math';

// Package imports:
import 'package:async/async.dart';
import 'package:database_builder/database_builder.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dictionary/dictionary_search_sorting.dart';
import 'package:da_kanji_mobile/application/japanese_text_processing/japanese_string_operations.dart';
import 'search_isolate.dart';

/// Class that spawns a number of isolates to search multi-processed in the
/// dictionary.
class DictionarySearch {

  /// Number of isolates that should be created for searching in the dictionary
  int noIsolates;
  /// A list of languages that should be included when searching in the dictionary
  List<String> languages;
  /// list of all search isolats used for searching in the dictionary
  List<DictionarySearchIsolate> _searchIsolates = [];
  /// Has the dictionary search been initialized
  bool _initialized = false;
  /// Has the dictionary search been initialized
  get initialized => _initialized;
  /// The directory of the ISAR file of the dictionary
  String directory;
  /// The name of the ISAR file of the dictionary
  String name;
  /// Is a search currently running
  bool _isSearching = false;
  /// The last query that was blocked by a running search
  /// Consists of <query, kana query, deconjugated query>
  Tuple2<List<String>, List<String>>? _lastBlockedQuery;
  /// Should the search be converted to hiragana
  bool convertToHiragana;
  


  DictionarySearch(
    this.noIsolates, this.languages, this.directory, this.name,
    this.convertToHiragana,
  );


  /// Needs to be called before using this object
  Future<void> init () async {
    
    for (var i = 0; i < noIsolates; i++) {
      _searchIsolates.add(DictionarySearchIsolate(
        languages, directory, name,
      ));
      await _searchIsolates[i].init(i, noIsolates);
    }

    _initialized = true;
  }

  /// Queries the database and sorts the results using multiple isolates.
  Future<List<List<JMdict>>?> search(List<String> allQueries,
    List<String> filters, int limitSearchResults) async {
    _checkInitialized();

    // do not search if a search is already running but remember the last blocked query
    if(_isSearching){
      _lastBlockedQuery = Tuple2(allQueries, filters);
      return null;
    }
    _isSearching = true;

    // check if the message contains wildcards and replace them appropriately
    allQueries = allQueries.map((e) =>
      e.replaceAll(questionMarkRegex, "???")).toList();
    
    // replace full-width chars with normal ones
    allQueries = allQueries.map((e) => e.toHalfWidth()).toList();

    // search in `noIsolates` separte Isolates 
    FutureGroup<List> searchGroup = FutureGroup();
    for (var i = 0; i < noIsolates; i++) {
      searchGroup.add(_searchIsolates[i].query(
        allQueries, filters, limitSearchResults
      ));
    }
    searchGroup.close();

    // wait for all isolates to finish and merge the results to one list
    final searchResult =
      List<JMdict>.from((await searchGroup.future).expand((e) => e));
    // sort and merge the results
    List<List<JMdict>> sortResult = sortJmdictList(
      searchResult, allQueries, languages);
    sortResult = sortResult.map((e) => 
      e.sublist(0, min(200, e.length))).toList();
    
    //var result = sortResult.expand((element) => element).toList();
    _isSearching = false;

    // if one or more queries were made while this one was running, run the last
    // one
    if(_lastBlockedQuery != null){
      List<String>? allQueries = _lastBlockedQuery!.item1;
      List<String>? filters = _lastBlockedQuery!.item2;
      _lastBlockedQuery = null;
      sortResult = (await search(allQueries, filters, limitSearchResults)) ?? [];
      _lastBlockedQuery = null;
    }
    
    return sortResult;
  }

  /// terminates all isolates and cleans memory
  Future<void> kill() async {
    for (var searchIsolate in _searchIsolates) {
      await searchIsolate.kill();
    }
    _searchIsolates = [];
    _initialized = false;
  }

  /// convenience function to check if `init()` was called.
  /// Throws an Exxception if it was not initialized.
  void _checkInitialized() {
    if(!_initialized) throw Exception("The isolate needs to be initilized");
  }

}
