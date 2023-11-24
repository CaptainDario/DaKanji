// Dart imports:
import 'dart:math';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/word_lists/default_names.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// Returns the localization of the given `w`. `w` should be the name of a
/// member of the [Enum] called [DefaultNames]
/// 
/// Caution: if `w` is not a valid name of a member of [DefaultNames] raises
///   an exception
String wordListsDefaultsStringToTranslation(String w){
  
  String converted = "";

  if(w.contains("jlpt")){
    converted = w.replaceAll("jlpt", "JLPT ");
  }
  else if(w == DefaultNames.searchHistory.name){
    converted = LocaleKeys.WordListsScreen_search_history.tr();
  }
  else if(w == DefaultNames.defaults.name){
    converted = LocaleKeys.WordListsScreen_defaults.tr();
  }
  else{
    
    //throw Exception("$w is not a valid name of a member of [DefaultNames]");
  }

  return converted;
}

/// Get all `JMDict` entries from the database that are in the word list given
/// by its IDs. Remove all translations that are not in `langsToInclude` and sort
/// the translations matching `langsToInclude`. Lastly retruns the list of
/// entries
Future<List<JMdict>> wordListEntries(List<int> wordIds, List<String> langsToInclude) async {

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