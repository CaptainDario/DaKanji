// Package imports:
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';
import 'package:isar_community/isar.dart';

/// Finds all radicals used in the given `kanji` and returns them. Optionally
/// if `radkIsar` si given, sorts the radicals by stroke number.
List<String> getRadicalsOf(String kanji, IsarCollection<Krad> kradIsar, {IsarCollection<Radk>? radkIsar}){

  // get all radicals of this kanji using krad
  List<List<String>> kanjis = kradIsar
    .where()
      .kanjiEqualTo(kanji)
    .radicalsProperty()
    .findAllSync();

  List<String> radicals = [];
  if(kanjis.isNotEmpty) {
    radicals = kanjis.first;

    // sort radicals by stroke order
    if(radkIsar != null) {
      radicals = radkIsar.where()
          .anyOf(radicals, (q, radical) => q.radicalEqualTo(radical))
        .sortByRadicalStrokeCount()
        .radicalProperty()
        .findAllSync();
    }
  }
  
  return radicals;
}

/// Returns all radicals from the krad isar
List<Radk> getAllRadicals(IsarCollection<Radk> radkIsar) {

  List<Radk> radicals = radkIsar.where()
    .radicalNotEqualTo("")
  .findAllSync();

  return radicals;

}

/// Returns all radicals from the krad isar as a List of strings
List<String> getAllRadicalsString(IsarCollection<Radk> radkIsar) {

  List<String> radicals = radkIsar.where()
    .radicalNotEqualTo("")
    .radicalProperty()
  .findAllSync();

  return radicals;

}

/// Returns all radicals (as String) from the krad isar, sorted by the number of strokes.
List<String> getRadicalsString(IsarCollection<Radk> radkIsar) {

  List<String> radicals = radkIsar.where()
    .radicalNotEqualTo("")
    .radicalProperty()
  .findAllSync();

  return radicals;

}

/// Finds all radicals, sorts them by stroke order and returns a map of this
Map<int, List<String>> getRadicalsByStrokeOrder(IsarCollection<Radk> radkIsar) {

  List<Radk> rads = getAllRadicals(radkIsar)
    ..sort((a, b) => a.radicalStrokeCount.compareTo(b.radicalStrokeCount));

  Map<int, List<String>> radicalsByStrokeOrder = {};

  for (Radk rad in rads) {

    if(!radicalsByStrokeOrder.containsKey(rad.radicalStrokeCount)) {
      radicalsByStrokeOrder[rad.radicalStrokeCount] = <String>[];
    }

    radicalsByStrokeOrder[rad.radicalStrokeCount]!.add(rad.radical);
  }

  return radicalsByStrokeOrder;

}


/// Returns all kanjis that use all `radicals`, sorted by stroke count.
/// For each 
List<List<String>> getKanjisByRadical(List<String> radicals, IsarCollection<Krad> kradIsar) {

  List<List<String>> ret = [];

  if(radicals.isNotEmpty) {

    List<Krad> kanjisThatUseAllRadicals = kradIsar
      .where()
        .anyKanjiStrokeCount()
      .filter()
        .allOf(radicals, (q, radical) => q.radicalsElementEqualTo(radical))
      .sortByKanjiStrokeCount()
      .thenByKanji()
      .limit(250)
      .findAllSync();

    ret = List.generate(kanjisThatUseAllRadicals.last.kanjiStrokeCount, (i) => []);
    for (var krad in kanjisThatUseAllRadicals) {
      ret[krad.kanjiStrokeCount-1].add(krad.kanji);
    }

  }
  
  return ret;
}

/// Returns all radicals that can be used with the `radicals` to find other
/// kanjis
List<String> getPossibleRadicals(List<String> radicals,
  IsarCollection<Krad> kradIsar, IsarCollection<Radk> radkIsar){

  List<String> possiblRadicals;

  if(radicals.isNotEmpty){
    // get the kanjis that use the selected radicals
    possiblRadicals = kradIsar.where()
        // quickly (where) filter out all that do not have any matching radical
        .anyOf(radicals, (q, radical) => q.radicalsElementEqualTo(radical))
      .filter()
        // from the remaining ones, find the ones where all radicals match
        .allOf(radicals, (q, radical) => q.radicalsElementEqualTo(radical))
    .radicalsProperty()
    .findAllSync()
    .flattened.toSet().toList();
  }
  else{
    possiblRadicals = getAllRadicalsString(radkIsar);
  }

  return possiblRadicals;

}
