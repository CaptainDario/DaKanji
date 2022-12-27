import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';
import 'package:database_builder/database_builder.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:isar/isar.dart';



/// Sorts a list of Jmdict entries given a query text. The order is determined
/// by those sorting criteria:
/// 
/// 1. Full Match > Match at the beginning > Match somwhere in the word
///    Those three categories are sorted individually and merged in the end
/// 2.  sort inside each category based on <br/>
///   1. word frequency
List<List<JMdict>> sortJmdictList(List<JMdict> entries, String queryText, List<String> languages){

  /// lists with three sub lists
  /// 0 - full matchs 
  /// 1 - matchs starting at the word beginning 
  /// 2 - other matches
  List<List<JMdict>> matches = [[], [], []];
  List<List<int>> matchIndices = [[], [], []];
  String queryTextHira = KanaKit().toHiragana(queryText);

  // iterate over the entries and create a ranking for each 
  for (JMdict entry in entries) {
    // KANJI matched
    Tuple3 ranked = rankMatches(entry.kanjis, queryText);
    
    // KANA macthed
    if(ranked.item1 == -1)
      ranked = rankMatches(entry.readings, queryTextHira);
    
    // MEANING matched
    if(ranked.item1 == -1){
      // filter all langauges that are selected in the settings and join them to a list
      List<String> k = entry.meanings.where((LanguageMeanings e) =>
          languages.contains(e.language)
        ).map((LanguageMeanings e) => 
          e.meanings!
        ).expand((e) => e).toList();
      ranked = rankMatches(k, queryText);
    }
    // the query was found in this entry
    if(ranked.item1 != -1){
      matches[ranked.item1].add(entry);
      matchIndices[ranked.item1].add(ranked.item3);
    }
  }

  // sort the results
  matches[0] = sortEntries(matches[0], matchIndices[0]);
  matches[1] = sortEntries(matches[1], matchIndices[1]);
  matches[2] = sortEntries(matches[2], matchIndices[2]);

  return matches;
}

/// Sorts a string list based on `queryText`. The sorting criteria are
/// explained by `sortJmdictList`.
///
/// Returns a Tuple with the structure: <br/>
///   1 - if it was a full (0), start(1) or other(2) match <br/>
///   2 - how many characters are in the match but not in `queryText` <br/>
///   3 - the index where the search matched <br/>
Tuple3<int, int, int> rankMatches(List<String> matches, String queryText) {   

  int result = -1, lenDiff = -1;
  
  // create a list of queries (convert query to hiragana and katakana)
  List<String> queries = [
    queryText,
    GetIt.I<KanaKit>().toHiragana(queryText),
    GetIt.I<KanaKit>().toKatakana(queryText),
  ];

  // check where the entry contains the query
  int matchIndex = matches.indexWhere(
    (element) => queries.any(
      (q) => element.contains(q)
    )
  );

  // check for full match
  if(matchIndex != -1){
    if(queries.contains(matches[matchIndex])){
      result = 0;
    }
    // does the found dict entry start with the search term
    else if(matches[matchIndex].startsWith(queries.join("|"))){
      result = 1;
    }
    // the query matches somwhere in the entry
    else {
      result = 2;
    }
    /// calculate the difference in length between the query and the result
    lenDiff = matches[matchIndex].length - queryText.length;
  }
  
  return Tuple3(result, lenDiff, matchIndex);
}

/// Sorts the list `a` of `JMdict` based on (1. is more important than 2., ...)
///   1. the frequency of the entries. <br/>
///   2. the int in `b` and returns it. <br/> 
/// Throws an exception if the lists do not have the same length.
List<JMdict> sortEntries(List<JMdict> a, List<int> b){

  assert (a.length == b.length);

  List<Tuple2<JMdict, int>> combined = List.generate(b.length,
    (i) => Tuple2(a[i], b[i])
  );
  combined.sort(
    (_a, _b) {
      if(_a.item1.frequency != _b.item1.frequency)
        return -_a.item1.frequency.compareTo(_b.item1.frequency);
      else
        return _a.item2.compareTo(_b.item2);
    }
  );

  return combined.map((e) => e.item1).toList();
}

/// Searches in KanjiVG the matching entries to `kanjis` and returns them
List<KanjiSVG> findMatchingKanjiSVG(List<String> kanjis){
  
  return GetIt.I<Isar>().kanjiSVGs.where()
    .anyOf(kanjis, (q, element) => q.characterEqualTo(element)
  ).findAllSync().toList();
}

/// Searches in KanjiVG the matching entries to `kanjis` and returns them
List<Kanjidic2> findMatchingKanjiDic2(List<String> kanjis){
  
  return GetIt.I<Isar>().kanjidic2s.where()
    .anyOf(kanjis, (q, element) => q.characterEqualTo(element)
  ).findAllSync().toList();
}