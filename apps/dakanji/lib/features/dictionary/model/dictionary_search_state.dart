import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:flutter/material.dart';

import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';


class DictionarySearchState with ChangeNotifier {

  Set<String> _activeFilters = {};
  Set<String> get activeFilters => _activeFilters;
  set activeFilters(Set<String> filters){
    _activeFilters = filters;
    notifyListeners();
  }

  String _currentSearch = "";
  set currentSearch(String newSearch){
    _currentSearch = newSearch;
    notifyListeners();
  }
  String get currentSearch => _currentSearch;

  DictionarySearchResult? _results;
  set results(DictionarySearchResult newResults){
    _results = newResults;
    notifyListeners();
  }
  DictionarySearchResult? get results => _results;

  DictionaryMatch? _selectedResult;
  set selectedResult(DictionaryMatch? newSelectedResult){
    _selectedResult = newSelectedResult;
    notifyListeners();
  }  
  DictionaryMatch? get selectedResult => _selectedResult;

}