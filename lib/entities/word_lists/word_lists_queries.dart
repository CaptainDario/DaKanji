// Dart imports:
import 'dart:math';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';

/// Get all `JMDict` entries from the database that are in the word list given
/// by their IDs.
/// 
/// if `langsToInclude != null` remove all translations that are not in
/// `langsToInclude` and sort the translations matching `langsToInclude`.
/// if `langsToInclude == null` returns all entries with all data
/// 
/// Lastly retruns the list of entries created as described above
Future<List<JMdict>> wordListIdsToJMdict(List<int> wordIds, List<String>? langsToInclude) async {

  if(wordIds.isEmpty) return[];

  List<JMdict> entries = (await GetIt.I<Isars>().dictionary.jmdict.getAll(wordIds))
    .nonNulls.toList();

  if(langsToInclude != null) {
    int i = 0;
    while (i < entries.length) {
      
      JMdict entry = entries[i];

      // remove all translations that are not in `langsToInclude` and create a 
      entry.meanings = entry.meanings.where(
        (element) => langsToInclude.contains(element.language)
      ).toList();
      if(entry.meanings.isEmpty){
        entries.removeAt(i);
        continue;
      }
      // sort the translations matching `langsToInclude`
      entry.meanings.sort((a, b) =>
        langsToInclude.indexOf(a.language!).compareTo(langsToInclude.indexOf(b.language!))
      );
      // only include the first `maxTranslations` translations
      entry.meanings = entry.meanings.sublist(0, min(3, entry.meanings.length));

      i++;
    }
  }

  return entries;

}

/// If a user made list is shown, gets the right stream from the DB
Stream<Iterable<Tuple2<DateTime, int>>> userListStream(listID){

  // listen to changes of this word list
  return GetIt.I<WordListsSQLDatabase>().watchWordlistEntries(listID)
    .map((event) => event.map((e) => Tuple2(e.timeAdded, e.dictEntryID)));
    
}
