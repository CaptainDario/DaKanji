import 'dart:async';

import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:flutter/material.dart';

import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';


class DictionarySearchState with ChangeNotifier {

  /// Filters that are currently applied to the search.
  Set<String> _activeFilters = {};
  Set<String> get activeFilters => _activeFilters;
  set activeFilters(Set<String> filters){
    _activeFilters = filters;
    notifyListeners();
  }

  /// The current search query in the search bar.
  String _currentSearch = "";
  set currentSearch(String newSearch){
    _currentSearch = newSearch;
    notifyListeners();
  }
  String get currentSearch => _currentSearch;

  /// Is the dictionary currently searching for results.
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  set isSearching(bool value){
    if(isSearching == value) return;
    _isSearching = value;
    notifyListeners();
  }

  /// Indicates if the loading indictaor should be shown.
  /// This happens after ``
  bool _showLoading = false;
  bool get showLoading => _showLoading;
  set showLoading(bool value) {
    if(showLoading == value) return;
    _showLoading = value;
    notifyListeners();
  }

  /// The duration after which the loading indicator should be shown, if the
  /// search is still running.
  int loadingTimerDuration = 1000;
  /// Starts the loading timer, which will set `showLoading` to true after
  /// `loadingTimerDuration` milliseconds.
  Timer? _loadingTimer;
  void startLoadingTimer() {
    _loadingTimer?.cancel();
    _loadingTimer = Timer(Duration(milliseconds: loadingTimerDuration), () {
      showLoading = true;
    });
  }
  void cancelLoadingTimer() {
    _loadingTimer?.cancel();
  }

  /// The current search results for the query.
  DictionarySearchResult _results = DictionarySearchResult.empty();
  set results(DictionarySearchResult newResults){
    _results = newResults;
    notifyListeners();
  }
  DictionarySearchResult get results => _results;

  /// The search result that is cuurrently shown in the detail.
  DictionaryMatch? _selectedResult;
  set selectedResult(DictionaryMatch? newSelectedResult){
    _selectedResult = newSelectedResult;
    notifyListeners();
  }  
  DictionaryMatch? get selectedResult => _selectedResult;


  // -- Search histories --

  /// The search histories for the last searches.
  /// 
  /// Each entry is one "search tab" in the search view. Inside of each tab a 
  /// user can navigate by tapping on links in the detailed view.
  /// A new tab can either manually be be created or by double tapping a search
  /// result, which will open the result in a new tab.
  List<List<DictionaryMatch>> _searchHistories = [];
  List<List<DictionaryMatch>> get searchHistories => _searchHistories;
  set searchHistories(List<List<DictionaryMatch>> newSearchHistories){
    _searchHistories = newSearchHistories;
    notifyListeners();
  }

  /// The index of the currently active search history tab.
  int _currentSearchHistoryTabIdx = 0;
  int get currentSearchHistoryTabIdx => _currentSearchHistoryTabIdx;
  set currentSearchHistoryTabIdx(int newIdx){
    _currentSearchHistoryTabIdx = newIdx;
    notifyListeners();
  }

  /// The index of the currently active search history entry in the current
  /// search history tab.
  int _currentSearchHistoryIdx = 0;
  int get currentSearchHistoryIdx => _currentSearchHistoryIdx;
  set currentSearchHistoryIdx(int newIdx){
    _currentSearchHistoryIdx = newIdx;
    notifyListeners();
  }

  @override
  void dispose() {
    cancelLoadingTimer();
    super.dispose();
  }

}