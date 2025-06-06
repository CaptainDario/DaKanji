// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:isar/isar.dart';

///  Builds a search query for the JMDict database in ISAR
/// 
/// Searches in the given `isar` for entries with an id between `idRangeStart`
/// and `idRangeEnd` and a message that matches `message`.
/// 
/// Note: potential optimizations: <br/>
/// * include ID in kanji / kana / meanings index to split load between isolates
QueryBuilder<JMdict, JMdict, QAfterLimit> buildJMDictQuery(
  Isar isar, int idRangeStart, int idRangeEnd, int noIsolates,
  List<String> allQueries,
  List<String> filters, List<String> langs, int limitSearchResults)
{
  // check if the search contains a wildcard
  bool containsWildcard = allQueries.first.contains(RegExp(r"\?|\*"));

  QueryBuilder<JMdict, JMdict, QFilterCondition> q;
  if(!containsWildcard) {
    q = normalQuery(isar, idRangeStart, idRangeEnd, allQueries);
  } else {
    q = wildcardQuery(isar, idRangeStart, idRangeEnd, allQueries);
  }    

  return q
    // apply filters
    .optional(filters.isNotEmpty, (q) => 
      q.anyOf(filters, (q, filter) => 
        q.meaningsElement((qM) => 
          qM.partOfSpeechElement((qP) => 
            qP.attributesElementContains(filter, caseSensitive: false)
          )
            .or()
          .fieldElement((qF) => 
            qF.attributesElementContains(filter, caseSensitive: false)
          )
        )
      )
    )
    // filter matches that do not match in an active language
    .group((q) => 
      // allow kanji / hiragana matches without wildcard
      q.optional(!containsWildcard, (q) => 
        q.group((q) => 
          q.anyOf(allQueries, (q, element)
            => q.kanjiIndexesElementStartsWith(element))
            .or()
          .anyOf(allQueries, (q, element)
            => q.hiraganasElementStartsWith(element))
        )
      )
      .or()
      // allow kanji / hiragana matches with wildcard  
      .optional(containsWildcard, (q) => 
        q.group((q) =>
          q.anyOf(allQueries, (q, element)
            => q.kanjisElementMatches(element))
            .or()
          .anyOf(allQueries, (q, element)
            => q.hiraganasElementMatches(element))
        )
      )
      .or()
      // of any meaning ...
      .meaningsElement((lMeanings) => 
        // does any ...
        lMeanings.anyOf(langs, (lMeaning, lang) =>
          // active language ...
          lMeaning.languageEqualTo(lang)
            .and()
          .group((q) => 
            q
            .optional(!containsWildcard, (q) =>
              q.meaningsElement((meaning) => 
                meaning.attributesElementStartsWith(allQueries.first, 
                  caseSensitive: false)
              )
            )
            .or()
            .optional(containsWildcard, (q) => 
              q.meaningsElement((meaning) => 
                meaning.attributesElementMatches(allQueries.first,
                  caseSensitive: false)
              )
            )
          )
        )
      )
    )
  // filter out entries 
  .sortByFrequencyDesc()
  .optional(limitSearchResults != 0, (q) => q.limit(limitSearchResults));
}


QueryBuilder<JMdict, JMdict, QFilterCondition> normalQuery(
  Isar isar, int idRangeStart, int idRangeEnd,
  List<String> allQueries){

  return isar.jmdict.where()
    .anyOf(allQueries, (q, element)
        => q.kanjiIndexesElementStartsWith(element))
        .or()
      .anyOf(allQueries, (q, element)
        => q.hiraganasElementStartsWith(element))
        .or()
      .anyOf([allQueries.first], (q, element)
        => q.meaningsIndexesElementStartsWith(element))
  .filter()
    // limit this process to one chunk of size (entries.length / num_processes)
    .idBetween(idRangeStart, idRangeEnd)
  ;
}

QueryBuilder<JMdict, JMdict, QAfterFilterCondition> wildcardQuery(
  Isar isar, int idRangeStart, int idRangeEnd,
  List<String> allQueries){

  return isar.jmdict.where()
      .idBetween(idRangeStart, idRangeEnd)
    .filter()
      .anyOf(allQueries, (q, element)
        => q.kanjisElementMatches(element))
        .or()
      .anyOf(allQueries, (q, element)
        => q.hiraganasElementMatches(element))
        .or()
      .anyOf([allQueries.first], (q, element)
        => q.meaningsIndexesElementMatches(element, caseSensitive: false))
  ;

}
