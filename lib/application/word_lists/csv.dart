import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_word_lists.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';



/// Creates a csv string from the given word list node
Future<String> csvFromWordListNode(TreeNode<WordListsData> node) async {

  String csv = "";

  List<int> entryIDs =
    await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(node.id);

  SettingsWordLists wl = GetIt.I<Settings>().wordLists;
  List<String> langsToInclude = GetIt.I<Settings>().dictionary.selectedTranslationLanguages
    .whereIndexed((index, element) => wl.includedLanguages[index])
    .map((e) => isoToiso639_2B[e]!.name)
    .toList();

  // find all elements from the word list in the database
  List<JMdict> entries = await wordListEntriesForExport(entryIDs, langsToInclude);

  // header
  csv += "kanji\treading\t${langsToInclude.join("\t")}\n";

  for (var entry in entries) {
    
    // add kanji
    csv += "${entry.kanjis.join(";")}\t";
    // add kana
    csv += "${entry.readings.join(";")}\t";
    // add meanings
    for (var meaning in entry.meanings) {
      csv += meaning.meanings.map((e) => e.attributes).join(";");
      csv += "\t";
    }

    csv += "\n";

  }

  print(csv);
  return csv;

}