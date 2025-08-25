


// Package imports:
import 'package:isar_community/isar.dart';

/// class to bundle all instances of isar
class Isars {
  /// Isar instace that contains all data of the dictionary
  Isar dictionary;
  /// Isar instace that contains all example sentences
  Isar examples;
  /// Isar instance that contains the kanji -> radical data
  Isar krad;
  /// Isar instance that contains the radical -> kanji data
  Isar radk;
  /// Isar instance that contains the DoJG data if it has been imported
  Isar? dojg;

  Isars(
    {
      required this.dictionary,
      required this.examples,
      required this.krad,
      required this.radk,
      this.dojg
    }
  );
}
