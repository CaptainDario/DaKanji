import 'dart:io';

import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:get_it/get_it.dart';



/// Renders each word list entry to an image and stores it in the temp directory
/// returns a List with all the [File]s created
Future sendListToAnkiFromWordListNode(TreeNode<WordListsData> node) async {

  List<int> entryIDs =
    await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(node.id);

  List<String> langsToInclude = GetIt.I<Settings>().wordLists
    .langsToInclude(GetIt.I<Settings>().dictionary.selectedTranslationLanguages);

  // find all elements from the word list in the database
  List<AnkiNote> notes = (await wordListEntriesForExport(entryIDs, langsToInclude))
    .map((e) => AnkiNote.fromJMDict(
      GetIt.I<Settings>().anki.defaultDeck!, e,
      langsToInclude: langsToInclude,
      translationsPerLang: GetIt.I<Settings>().anki.noTranslations
    ))
    .toList();

  GetIt.I<Anki>().addNotes(notes);

}