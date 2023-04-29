


import 'package:isar/isar.dart';

/// class to bundle all instances of isar
class Isars {
  /// Isar instace that contains all data of the dictionary
  Isar dictionary;
  /// Isar instace that contains all example sentences
  Isar examples;
  /// Isar instance that contains the search history
  Isar searchHistory;
  /// Isar instance that contains the kanji radical data
  Isar krad;

  Isars(
    {
      required this.dictionary,
      required this.examples,
      required this.searchHistory,
      required this.krad
    }
  );
}