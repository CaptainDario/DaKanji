// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:archive/archive_io.dart';
import 'package:database_builder/database_builder.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_queries.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/globals.dart';

/// Stores all word lists in a directory called `v4_word_list_migration` in the
/// users support directory to migrate the data once DaKanji 4 releases
Future<void> storeWordListsAsTextFilesForMigration() async {

  Stopwatch s = Stopwatch()..start();
  File wordListMigrationFile = File(p.joinAll([
    g_DakanjiPathManager.dakanjiSupportDirectory.path, "v4_word_list_migration"]));
  wordListMigrationFile.createSync();

  final wordListIds = (await GetIt.I<WordListsSQLDatabase>().wordListNodesSQL
    .select().get())
    .where((e) =>
      [WordListNodeType.wordList, WordListNodeType.wordListDefault].contains(e.type))
    .map((e) => Tuple2(e.id, e.name)).toList();

  List<List<JMdict>> allEntries = [];
  for (var i = 0; i < wordListIds.length; i++) {
    // get ids of the entries in word lists
    List<int> ids = await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(
      wordListIds[i].item1);
    // get dict entries
    List<JMdict> entries = await wordListIdsToJMdict(ids, null);
    if(entries.isEmpty) continue;

    allEntries.add(entries);
  }
  wordListMigrationFile.writeAsBytes(
    const GZipEncoder().encode(utf8.encode(jsonEncode(allEntries))));

}
