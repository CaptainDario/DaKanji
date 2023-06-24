import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';



/// Returns all radicals from the krad isar, sorted by the number of strokes.
List<Radk> getRadicals(IsarCollection<Radk> radkIsar) {

  List<Radk> radicals = radkIsar.where()
    .radicalNotEqualTo("")
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

  List<Radk> rads = getRadicals(radkIsar)
    ..sort((a, b) => a.strokeCount.compareTo(b.strokeCount));

  Map<int, List<String>> radicalsByStrokeOrder = {};

  for (Radk rad in rads) {

    if(!radicalsByStrokeOrder.containsKey(rad.strokeCount))
      radicalsByStrokeOrder[rad.strokeCount] = <String>[];

    radicalsByStrokeOrder[rad.strokeCount]!.add(rad.radical);
  }

  return radicalsByStrokeOrder;

}

/// Returns all kanjis that use all `radicals`
List<String> getKanjisByRadical(List<String> radicals, IsarCollection<Radk> radkIsar){

  // get the kanjis that use the selected radicals
  List<List<String>> kanjis = radkIsar
  .where()
    .anyOf(radicals, (q, radical) => 
      q.radicalEqualTo(radical)
    )
  .sortByStrokeCount()
  .kanjisProperty()
  .findAllSync();

  // find the kanjis that are in common
  List<String> uniqueKanjis = kanjis
    .map((e) => e.toSet())
    .reduce((value, element) => value.intersection(element))
    .toList();

  return uniqueKanjis;
}

/// Returns all radicals that can be used with the `radicals` to find other
/// kanjis
List<String> getPossibleRadicals(List<String> radicals, IsarCollection<Radk> radkIsar){

  List<String> possibleKanjis = getKanjisByRadical(radicals, radkIsar);

  // get the kanjis that use the selected radicals
  List<String> possiblRadicals = radkIsar.where()
      .anyOf(radicals, (q, radical) => q.radicalNotEqualTo(radical))
    .filter()
      .anyOf(possibleKanjis, (q, kanji) => q.kanjisElementEqualTo(kanji))
      
  .radicalProperty()
  .findAllSync();

  return possiblRadicals;

}