


import 'package:isar/isar.dart';

/// class to bundle all instances of isar
class Isars {
  /// Isar instace that contains all data of the dictionary
  Isar dictionary;
  /// Isar instance that contains the search history
  Isar searchHistory;

  Isars(
    {
      required this.dictionary,
      required this.searchHistory
    }
  );
}