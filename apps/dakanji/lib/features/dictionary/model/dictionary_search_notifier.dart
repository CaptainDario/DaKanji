import 'package:da_db/database/db_queries/dictionary_search/dictionary_match.dart';
import 'package:flutter/material.dart';

import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';


class DictionarySearchNotifier with ChangeNotifier {

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