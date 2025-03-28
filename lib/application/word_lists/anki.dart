// Dart imports:
import 'dart:io';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';

/// Renders each word list entry to an image and stores it in the temp directory
/// returns a List with all the [File]s created
Future sendListToAnkiFromWordListNode(TreeNode<WordListsData> node, bool allowDuplicates) async {

  List<int> entryIDs =
    await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(node.id);

  List<String> langsToInclude = GetIt.I<Settings>().wordLists
    .langsToInclude(GetIt.I<Settings>().dictionary.selectedTranslationLanguages);

  // find all elements from the word list in the database
  List<JMdict> jmdicts = (await wordListIdsToJMdict(entryIDs, langsToInclude));
  List<AnkiNote> notes = [];
  for (var jmdict in jmdicts) {
    AnkiNote note = AnkiNote.fromJMDict(
      GetIt.I<Settings>().anki.defaultDeck!, jmdict,
      langsToInclude: langsToInclude,
      translationsPerLang: GetIt.I<Settings>().anki.noTranslations,
      includeExample: true
    );
    await note.setExamplesFromDict(jmdict,
      langsToInclude: langsToInclude,
      includeTranslations: GetIt.I<Settings>().anki.includeExampleTranslations,
      numberOfExamples: GetIt.I<Settings>().anki.noExamples);
    notes.add(note);
  }

  GetIt.I<Anki>().addNotes(notes, allowDuplicates);

}
