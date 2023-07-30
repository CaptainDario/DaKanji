

import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';
import 'package:database_builder/database_builder.dart';
import 'package:isar/isar.dart';



/// Sorts a list of Jmdict entries given a query text. The order is determined
/// by those sorting criteria:
/// 
/// 1. Full Match > Match at the beginning > Match somwhere in the word
///    Those three categories are sorted individually and merged in the end
/// 2.  sort inside each category based on <br/>
///   1. word frequency
List<List<JMdict>> sortJmdictList(
  List<JMdict> entries, String queryText, String? queryKana, List<String> languages,
  bool convertToHiragana
){

  /// lists with three sub lists
  /// 0 - full matchs 
  /// 1 - matchs starting at the word beginning 
  /// 2 - other matches
  List<List<JMdict>> matches = [[], [], []];
  /// where in the meanings of this entry did the search match
  List<List<int>> matchIndices = [[], [], []];
  /// how many characters are the query and the matched result apart
  List<List<int>> lenDifferences = [[], [], []];

  // if no wildcard is used, iterate over the entries and create a ranking for each
  if(!queryText.contains(RegExp(r"\?|\*"))){
    // iterate over the entries and create a ranking for each
    for (JMdict entry in entries) {
      // KANJI matched
      Tuple3 ranked = rankMatches([entry.kanjiIndexes], queryText);
      
      // READING matched
      if(ranked.item1 == -1)
        ranked = rankMatches([entry.hiraganas], queryKana ?? queryText);
      
      // MEANING matched
      if(ranked.item1 == -1){
        // filter all entries that have langauge that is enabled and join them to a list
        List<List<String>> k = entry.meanings.where(
          (LanguageMeanings e) => languages.contains(e.language)
        ).map((e) => 
          e.meanings.map((e) => 
            e.attributes.whereNotNull()
          ).flattened.toList()
        )
        .toList();
        
        ranked = rankMatches(k, queryText);
      }
      // the query was found in this entry
      if(ranked.item1 != -1){
        matches[ranked.item1].add(entry);
        matchIndices[ranked.item1].add(ranked.item3);
        lenDifferences[ranked.item1].add(ranked.item2);
      }
    }

    // sort the results
    matches[0] = sortEntries(matches[0], matchIndices[0], lenDifferences[0]);
    matches[1] = sortEntries(matches[1], matchIndices[1], lenDifferences[1]);
    matches[2] = sortEntries(matches[2], matchIndices[2], lenDifferences[2]);
  }
  // if a wildcard was used just sort by frequency
  else {
    matches[0] = entries..sort((a, b) => b.frequency.compareTo(a.frequency));
  }

  return matches;
}

/// Sorts a string list based on `queryText`. The sorting criteria are
/// explained by `sortJmdictList`.
///
/// Returns a Tuple with the structure: <br/>
///   1 - if it was a full (0), start(1) or other(2) match <br/>
///   2 - how many characters are in the match but not in `queryText` <br/>
///   3 - the index where the search matched <br/>
Tuple3<int, int, int> rankMatches(List<List<String>> matches, String queryText) {   

  int result = -1, lenDiff = -1; List<int> matchIndeces = [-1, -1];
  
  // convert query and matches to lower case; find where the query matched
  queryText = queryText.toLowerCase();
  for (var i = 0; i < matches.length; i++) {
    for (var j = 0; j < matches[i].length; j++) {
      matches[i][j] = matches[i][j].toLowerCase();
      if(matches[i][j].contains(queryText)){
        matchIndeces = [i, j];
        break;
      }
    }
  }  

  if(matchIndeces[0] != -1 && matchIndeces[1] != -1){
    // check for full match
    if(queryText == matches[matchIndeces[0]][matchIndeces[1]]){
      result = 0;
    }
    // does the found dict entry start with the search term
    else if(matches[matchIndeces[0]][matchIndeces[1]].startsWith(queryText)){
      result = 1;
    }
    // the query matches somwhere in the entry
    else {
      result = 2;
    }
    /// calculate the difference in length between the query and the result
    lenDiff = matches[matchIndeces[0]][matchIndeces[1]].length - queryText.length;
  }
  
  return Tuple3(result, lenDiff, matchIndeces[1]);
}

/// Sorts the list `a` of `JMdict` based on (1. is more important than 2., ...)
///   1. the int in `b`. <br/>
///   2. the difference in length in `c`
///   2. the frequency of the entries. <br/> 
/// and returns it
/// 
/// Caution: Throws an exception if the lists do not have the same length.
List<JMdict> sortEntries(List<JMdict> a, List<int> b, List<int> c){

  assert (a.length == b.length);

  List<Tuple3<JMdict, int, int>> combined = List.generate(b.length,
    (i) => Tuple3(a[i], b[i], c[i])
  );

  combined.sort(
    (_a, _b) {
      // sort by index of entry match
      if(_a.item2 != _b.item2){
        return _a.item2.compareTo(_b.item2);
      }
      else{
        // sort by difference in length
        //if(_a.item3 != _b.item3){
        //  return _a.item3.compareTo(_b.item3);
        //}
        // sort by frequency
        //else {
          return -_a.item1.frequency.compareTo(_b.item1.frequency);
        //}
      }
    }
  );

  return combined.map((e) => e.item1).toList();
}

///  Builds a search query for the JMDict database in ISAR
/// 
/// Searches in the given `isar` for entries with an id between `idRangeStart`
/// and `idRangeEnd` and a message that matches `message`.
/// 
/// Note: potential optimizations: <br/>
/// * include ID in kanji / kana / meanings index to split load between isolates
QueryBuilder<JMdict, JMdict, QAfterLimit> buildJMDictQuery(
  Isar isar, int idRangeStart, int idRangeEnd, int noIsolates,
  String query, String? kanaizedQuery, List<String> filters, List<String> langs)
{

  // check if the search contains a wildcard
  bool containsWildcard = query.contains(RegExp(r"\?|\*"));

  QueryBuilder<JMdict, JMdict, QFilterCondition> q;
  if(!containsWildcard)
    q = normalQuery(isar, idRangeStart, idRangeEnd, query, kanaizedQuery);
  else
    q = wildcardQuery(isar, idRangeStart, idRangeEnd, query, kanaizedQuery);    

  return q
    // apply filters
    .optional(filters.isNotEmpty, (q) => 
      q.anyOf(filters, (q, filter) => 
        q.meaningsElement((qM) => 
          qM.partOfSpeechElement((qP) => 
            qP.attributesElementContains(filter)
          )
            .or()
          .fieldElement((qF) => 
            qF.attributesElementContains(filter)
          )
        )
      )
    )
    .sortByFrequencyDesc()
    .limit(200 ~/ noIsolates);
}

QueryBuilder<JMdict, JMdict, QFilterCondition> normalQuery(
  Isar isar, int idRangeStart, int idRangeEnd, String query, String? kanaizedQuery){

  return isar.jmdict.where()
    .kanjiIndexesElementStartsWith(query)
      .or()
    .hiraganasElementStartsWith(kanaizedQuery ?? query)
      .or()
    .meaningsIndexesElementStartsWith(query)

  .filter()
    // limit this process to one chunk of size (entries.length / num_processes)
    .idBetween(idRangeStart, idRangeEnd)
  ;
}

QueryBuilder<JMdict, JMdict, QAfterFilterCondition> wildcardQuery(
  Isar isar, int idRangeStart, int idRangeEnd, String query, String? kanaizedQuery){

  return isar.jmdict.where()
      .idBetween(idRangeStart, idRangeEnd)
    .filter()

      .kanjisElementMatches(query)
        .or()
      .hiraganasElementMatches(kanaizedQuery ?? query)
        .or()
      .meaningsIndexesElementMatches(query)
  ;

}

