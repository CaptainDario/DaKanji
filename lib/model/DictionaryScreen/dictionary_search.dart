import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:isar/isar.dart';
import 'package:tuple/tuple.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:get_it/get_it.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_jm;
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;
import 'package:database_builder/src/kanjidic2_to_Isar/data_classes.dart' as isar_kanjidic;

import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/helper/iso/iso_table.dart';



bool isSearching = false;

String currentSearch = "";


/// Searches `queryText` in the database
Future<List<isar_jm.Entry>> searchInDict(String queryText) async {

  if(isSearching){
    currentSearch = queryText;
    bool changed = false;
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      if(currentSearch != queryText){
        changed = true;
        print("changed");
      }
      else{
        print("not changed");
      }
    });
    if(changed) return [];
  }

  List<isar_jm.Entry> searchResults = [];

  String hiraText = GetIt.I<KanaKit>().toHiragana(queryText);
  String kataText = GetIt.I<KanaKit>().toKatakana(queryText);

  Stopwatch s = new Stopwatch()..start();
  
  if(queryText != ""){
    searchResults = await compute(
      searchInIsolate,
      Tuple3(
        5,
        Tuple3(
          queryText, 
          hiraText, 
          kataText
        ), 
        GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map(
          (lang) => isoToiso639_2B[lang]!.name
        ).toList()
      )
    );
    
    //print("len ${searchResults.length} time: ${s.elapsed}");
  }
  else{
    searchResults = [];
  }
  print("Whole search took ${s.elapsed}");

  // sort and return
  searchResults = sortJmdictList(
    await searchResults, 
    queryText, GetIt.I<Settings>().dictionary.selectedTranslationLanguages
  );

  isSearching = false;

  return searchResults;
}

/// Sorts a list of Jmdict entries given a query text. The order is determined
/// by those sorting criteria:
/// 
/// 1. Full Match > Match at the beginning > Match somwhere in the word
///    Those three categories are sorted individually and merged in the end
///   2.  sort inside each category based on <br/>
List<isar_jm.Entry> sortJmdictList(
  List<isar_jm.Entry> entries, 
  String queryText,
  List<String> languages)
  {

  /// lists with three sub lists
  /// 0 - full matchs 
  /// 1 - matchs starting at the word beginning 
  /// 2 - other matches
  List<List<isar_jm.Entry>> matches = [[], [], []];
  List<List<int>> matchIndices = [[], [], []];
  String queryTextHira = GetIt.I<KanaKit>().toHiragana(queryText);

  // iterate over the entries and create a ranking for each 
  for (isar_jm.Entry entry in entries) {
    // KANJI
    Tuple3 result = rankMatches(entry.kanjis, queryText);
    
    // KANA
    if(result.item1 == -1)
      result = rankMatches(entry.readings, queryTextHira);
    
    // MEANING
    // filter all langauges that are not selected in the settings
    if(result.item1 == -1){
      List<String> k = entry.meanings.where((isar_jm.LanguageMeanings e) => 
          languages.contains(isoToiso639_1[e.language]!.name)
        ).map((isar_jm.LanguageMeanings e) => 
          e.meanings!
        ).expand((e) => e).toList();
      result = rankMatches(k, queryText);
    }

    if(result.item1 != -1){
      matches[result.item1].add(entry);
      matchIndices[result.item1].add(result.item3);
    }
  }

  matches[0] = sortEntriesByInts(matches[0], matchIndices[0]);
  matches[1] = sortEntriesByInts(matches[1], matchIndices[1]);
  matches[2] = sortEntriesByInts(matches[2], matchIndices[2]);
  return matches.expand((element) => element).toList();
}

/// Sorts a `` based on `queryText`. The sorting criteria are
/// explained by `sortJmdictList`.
///
/// Returns a Tuple with the structure: <br/>
///   1 - if it was a full (0), start(1) or other(2) match <br/>
///   2 - how many characters are in the match but not in `queryText` <br/>
///   3 - the index where the search matched <br/>
Tuple3<int, int, int> rankMatches(List<String> matches, String queryText) {   

  int result = -1, lenDiff = -1;

  // check if the word written in kanji contains the query
  int matchIndex = matches.indexWhere((element) => element.contains(queryText));
  if(matchIndex != -1){
    // check kanji for full match
    if(matches[matchIndex] == queryText){
      result = 0;
    }
    // does the found dict entry start with the search term
    else if(matches[matchIndex].startsWith(queryText)){
      result = 1;
    }
    // how many additional characters does this entry include
    else {
      result = 2;
    }
    /// calculatt the difference in length between the query and the result
    lenDiff = matches[matchIndex].length - queryText.length;
  }

  return Tuple3(result, lenDiff, matchIndex);
}

/// Sorts list `a` based on the values in `b` and returns it.
/// 
/// Throws an exception if the lists do not have the same length.
List<isar_jm.Entry> sortEntriesByInts(List<isar_jm.Entry> a, List<int> b){

  assert (a.length == b.length);

  List<Tuple2<isar_jm.Entry, int>> combined = List.generate(b.length,
    (i) => Tuple2(a[i], b[i])
  );
  combined.sort(
    (_a, _b) => _a.item2 - _b.item2
  );

  return  combined.map((e) => e.item1).toList();
}

/// Searches in the dictionary matching the provided configuration `args` <br/>
/// args.item1 - The mode for searching <br/>
///              1 - search in `kanjis` using the query<br/>
///              2 - search in `readings` using the query <br/>
///              3 - search in `readings` using the query in hiragana <br/>
///              4 - search in `readings` using the query katakana <br/>
///              5 - search in `meanings` using the query <br/>
/// 
/// args.item2 - contains a Tuple3 
///              1 - the query <br/>
///              2 - the query converted to hiragana <br/>
///              3 - the query converted to katakana<br/>
/// 
/// args.item3 - is a list containing all languages that should used for finding
///              matches
//FutureOr<List<isar_jm.Entry>>
List<isar_jm.Entry> searchInIsolate(
  Tuple3<int, Tuple3<String, String, String>, List<String>> args) 
  {

  Query<isar_jm.Entry> query;

  Isar isar = Isar.openSync(
    [isar_kanji.KanjiSVGSchema, isar_jm.EntrySchema, isar_kanjidic.Kanjidic2EntrySchema],
  );
  
  query = isar.entrys.filter()
  //  .kanjisElementContains(args.item2.item1)
  //.or()
    .readingsElementContains(args.item2.item1).or()
    .readingsElementContains(args.item2.item2).or()
    .readingsElementContains(args.item2.item3)
  /*
  .or()
    .meaningsElement((meaning) => meaning
      .anyOf(args.item3, (m, lang) => m
        .languageEqualTo(lang)
        .optional(args.item2.item1.length < 3, (m) => m
          .meaningsElementStartsWith(args.item2.item1)
        )
        .optional(args.item2.item1.length >= 3, (m) => m
          .meaningsElementContains(args.item2.item1)
        )
      )
    )
  */
  //.limit(20)
  .build();
  
  return query.findAllSync();
}

