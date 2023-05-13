import 'package:database_builder/database_builder.dart';
import 'package:isar/isar.dart';



/// Returns all radicals from the krad isar, sorted by the number of strokes.
List<Krad> getRadicals(Isar kradIsar) {

  List<Krad> radicals = kradIsar.krads.where()
    .characterNotEqualTo("")
  .findAllSync();

  return radicals;

}

/// Finds all radicals, sorts them by stroke order and returns a map of this
Map<int, List<String>> getRadicalsByStrokeOrder(Isar kradIsar) {

  List<Krad> rads = getRadicals(kradIsar)
    ..sort((a, b) => a.strokeCount.compareTo(b.strokeCount));

  Map<int, List<String>> radicalsByStrokeOrder = {};

  for (Krad rad in rads) {

    if(!radicalsByStrokeOrder.containsKey(rad.strokeCount))
      radicalsByStrokeOrder[rad.strokeCount] = <String>[];

    radicalsByStrokeOrder[rad.strokeCount]!.add(rad.character);
  }

  return radicalsByStrokeOrder;

}

/// Returns all kanjis that use all `radicals`
List<String> getKanjisByRadical(List<String> radicals, Isar kradIsar){

  // get the kanjis that are use the selected radicals
  List<List<String>> kanjis = kradIsar.krads.filter()
    .anyOf(radicals, (q, radical) => 
      q.characterEqualTo(radical)
    )
    .kanjisProperty()
  .findAllSync();

  // find the kanjis that are in common
  return kanjis
    .map((e) => e.toSet())
    .reduce((value, element) => value.intersection(element))
    .toList();

}

/// Returns all radicals that can be used with the `radicals` to find other
/// kanjis
List<String> getPossibleRadicals(List<String> radicals, Isar kradIsar){

  List<String> possibleKanjis = getKanjisByRadical(radicals, kradIsar);

  // get the kanjis that are use the selected radicals
  List<String> possiblRadicals = kradIsar.krads.filter()
    .anyOf(possibleKanjis, (q, kanji) => 
      q.kanjisElementContains(kanji)
        .and()
      .not()
        .anyOf(radicals, (q, radical) => q.characterEqualTo(radical))
    )
  .characterProperty()
  .findAllSync();

  return possiblRadicals;

}