import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';



/// Returns the entry IDs of a default list given by its `listName`
List<int> getEntryIDsOfDefaultList(String listName){

  List<int> entries = [];

  if(listName.contains("jlpt")){

    entries = jlptList(listName);

  }

  return entries;

}

/// Returns a list with the elements of a JLPT word list
List<int> jlptList(String listName){

  String jlptLevel = listName.replaceAll("jlpt", "");

  return GetIt.I<Isars>().dictionary.jmdict.filter()
    .jlptLevelElementContains(jlptLevel)
    .sortByFrequencyDesc()
    .idProperty()
    .findAllSync();

}