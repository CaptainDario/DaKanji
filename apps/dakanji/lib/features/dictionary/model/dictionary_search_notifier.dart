import 'package:flutter/material.dart';

import 'package:da_db/database/db_queries/dictionary_search/dictionary_search_result.dart';


class DictionarySearchNotifier with ChangeNotifier {

  String currentSearch = "";

  DictionarySearchResult? results;

  void updateResults(DictionarySearchResult newResults){
    results = newResults;
    notifyListeners();
  }
  

}