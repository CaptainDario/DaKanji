


import 'package:flutter/material.dart';

/// Riverpod provider that stores information about the DoJG search
class DojgSearch extends ChangeNotifier{


  String _currentSearchTerm = "";

  String get currentSearchTerm {
    return _currentSearchTerm;
  }

  set currentSearchTerm(String newSearchTerm){
    _currentSearchTerm = newSearchTerm;
    notifyListeners();
  }

}
