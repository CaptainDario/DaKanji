import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';



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
        .sortByStrokeCount()
        .radicalProperty()
        .findAllSync();
    }
  }
  
  return radicals;
}

/// Returns all radicals from the krad isar, sorted by the number of strokes.
List<Radk> getAllRadicals(IsarCollection<Radk> radkIsar) {

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

  List<Radk> rads = getAllRadicals(radkIsar)
    ..sort((a, b) => a.strokeCount.compareTo(b.strokeCount));

  Map<int, List<String>> radicalsByStrokeOrder = {};

  for (Radk rad in rads) {

    if(!radicalsByStrokeOrder.containsKey(rad.strokeCount)) {
      radicalsByStrokeOrder[rad.strokeCount] = <String>[];
    }

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

  // sort by stroke order
  List<String> kanjiByStrokeOrder = GetIt.I<Isars>().dictionary.kanjidic2s
    .where()
      .anyOf(uniqueKanjis, (q, kanji) => q.characterEqualTo(kanji))
    .sortByStrokeCount()
    .characterProperty()
    .findAllSync();

  return kanjiByStrokeOrder;
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