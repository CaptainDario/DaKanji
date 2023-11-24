// Package imports:
import 'package:async/async.dart';
import 'package:database_builder/database_builder.dart';
import 'package:kana_kit/kana_kit.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dictionary/dictionary_search_util.dart';
import 'package:da_kanji_mobile/entities/dictionary_filters/filter_options.dart';
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
  String? _lastBlockedQuery;
  /// Should the search be converted to hiragana
  bool convertToHiragana;

  final KanaKit _kKitRomaji = const KanaKit();
  final KanaKit _kKitKanji = const KanaKit(
    config: KanaKitConfig(passRomaji: true, passKanji: true, upcaseKatakana: false)
  );


  DictionarySearch(
    this.noIsolates, this.languages, this.directory, this.name, this.convertToHiragana
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
  Future<List<JMdict>?> query (String queryText) async {
    _checkInitialized();

    // do not search if a search is already running but remember the last blocked query
    if(_isSearching){
      _lastBlockedQuery = queryText;
      return null;
    }
    _isSearching = true;

    // check if the message contains wildcards and replace them appropriately
    String query = queryText.replaceAll(RegExp(r"\?|\﹖|\︖|\？"), "???");
    
    // replace full-width chars with normal ones
    query = query.toHalfWidth();

    // extract filters from query, and remove them from the query
    List<String> filters = getFilters(query);
    query = query.split(" ").where((e) => !e.startsWith("#")).join(" ");

    // convert query to hiragana if it is Japanese
    if(_kKitKanji.isJapanese(query)) {
      query = _kKitKanji.toHiragana(query);
    }

    // if romaji conversion setting is enabled, convert query to hiragana
    String? queryKana;
    if(convertToHiragana) {
      queryKana = _kKitRomaji.toHiragana(query);
    }

    // search in `noIsolates` separte Isolates 
    FutureGroup<List> searchGroup = FutureGroup();
    for (var i = 0; i < noIsolates; i++) {
      searchGroup.add(_searchIsolates[i].query(
        query, queryKana, filters
      ));
    }
    searchGroup.close();

    // wait for all isolates to finish and merge the results to one list
    final searchResult =
      List<JMdict>.from((await searchGroup.future).expand((e) => e));
    // sort and merge the results
    final sortResult = sortJmdictList(
      searchResult, query, queryKana, languages, convertToHiragana
    );
    var result = sortResult.expand((element) => element).toList();
    _isSearching = false;

    // if one or more queries were made while this one was running, run the last
    // one
    if(_lastBlockedQuery != null){
      var t = _lastBlockedQuery;
      _lastBlockedQuery = null;
      result = (await this.query(t!)) ?? [];
      _lastBlockedQuery = null;
    }
    
    return result;
  }

  /// Extracts the filters from a query
  List<String> getFilters(String query){
    return query.split(" ")
      .where((e) => e.startsWith("#"))
      .map((e) => jmDictAllFilters[e.replaceFirst("#", "")].toString()).toList();
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
