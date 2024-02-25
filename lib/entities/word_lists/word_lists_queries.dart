// Dart imports:
import 'dart:math';

// Package imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:tuple/tuple.dart';



/// Get all `JMDict` entries from the database that are in the word list given
/// by their IDs. Remove all translations that are not in `langsToInclude` and sort
/// the translations matching `langsToInclude`. Lastly retruns the list of
/// entries
Future<List<JMdict>> wordListEntriesForPDF(List<int> wordIds, List<String> langsToInclude) async {

  List<JMdict> entries = await GetIt.I<Isars>().dictionary.jmdict
  // get all entries
  .where()
    .anyOf(wordIds, (q, element) => q.idEqualTo(element))
  .filter()
    // only include them in the list if they have a translation in a selected language
    .anyOf(langsToInclude, (q, l) => 
      q.meaningsElement((m) => 
        m.languageEqualTo(l)
      )
    )
  .findAll();

  for (JMdict entry in entries) {
    // remove all translations that are not in `langsToInclude` and create a 
    entry.meanings = entry.meanings.where(
      (element) => langsToInclude.contains(element.language)
    ).toList();
    // sort the translations matching `langsToInclude`
    entry.meanings.sort((a, b) =>
      langsToInclude.indexOf(a.language!).compareTo(langsToInclude.indexOf(b.language!))
    );
    // only include the first `maxTranslations` translations
    entry.meanings = entry.meanings.sublist(0, min(3, entry.meanings.length));
  }

  return entries;

}

/// If a user made list is shown, gets the right stream from the DB
Stream<Iterable<Tuple2<DateTime, int>>> userListStream(listID){

  // listen to changes of this word list
  return GetIt.I<WordListsSQLDatabase>().watchWordlistEntries(listID)
    .map((event) => event.map((e) => Tuple2(e.timeAdded, e.dictEntryID)));
    
}