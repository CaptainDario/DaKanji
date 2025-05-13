// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/screenshots/dictionary_word_card.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';

/// Renders each word list entry to an image and stores it in the temp directory
/// returns a List with all the [File]s created
Future<List<File>> imagesFromWordListNode(
  TreeNode<WordListsData> node, ThemeData theme) async {

  List<File> images = [];

  List<int> entryIDs =
    await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(node.id);

    List<String> langsToInclude = GetIt.I<Settings>().wordLists
    .langsToInclude(GetIt.I<Settings>().dictionary.selectedTranslationLanguages);

  // find all elements from the word list in the database
  List<JMdict> entries = await wordListIdsToJMdict(entryIDs, langsToInclude);

  for (var (i, entry) in entries.indexed) {
    
    images.add(
      await dictionaryWordCardToImage(
        entry,
        "${i}_${entry.kanjis.isNotEmpty ? entry.kanjis[0] : entry.readings[0]}.png",
        false, theme)
    );

  }

  return images;

}
