import 'dart:io';

import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/application/screenshots/dictionary_word_card.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/settings/settings_word_lists.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';



/// Renders each word list entry to an image and stores it in the temp directory
/// returns a List with all the [File]s created
Future<List<File>> imagesFromWordListNode(TreeNode<WordListsData> node) async {

  List<File> images = [];

  List<int> entryIDs =
    await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(node.id);

  SettingsWordLists wl = GetIt.I<Settings>().wordLists;
  List<String> langsToInclude = GetIt.I<Settings>().dictionary.selectedTranslationLanguages
    .whereIndexed((index, element) => wl.includedLanguages[index])
    .map((e) => isoToiso639_2B[e]!.name)
    .toList();

  // find all elements from the word list in the database
  List<JMdict> entries = await wordListEntriesForExport(entryIDs, langsToInclude);

  for (var (i, entry) in entries.indexed) {
    
    images.add(
      await dictionaryWordCardToImage(
        entry,
        "${i}_${entry.kanjis.isNotEmpty ? entry.kanjis[0] : entry.readings[0]}.png",
        false)
    );

  }

  return images;

}