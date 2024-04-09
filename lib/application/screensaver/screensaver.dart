// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/screens/screen_saver/screen_saver_screen.dart';

/// Starts a screensaver using the words from the given word lists
void startScreensaver(List<int> wordListIDs) async {

  // do not start a screensaver if one is already running
  if(g_ScreensaverKey.currentWidget != null) return;

  List<int> ids = await getDictIDsForScreensaver(wordListIDs);

  // ignore: use_build_context_synchronously
  Navigator.of(g_NavigatorKey.currentContext!).push(
    MaterialPageRoute(builder: (context) => 
      ScreenSaverScreen(ids, key: g_ScreensaverKey)
    )
  );

}

/// Gets all entries from the word lists that are selected to be used for word
/// lists
Future<List<int>> getDictIDsForScreensaver(List<int> wordListIDs) async {

  List<int> entries = [];

  for (int idx in wordListIDs) {
    entries.addAll(
      await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(idx)
    );
  }

  return entries;
}

/// Stops a running screensaver
void stopScreensaver(BuildContext context){

  // do not stop a screensaver if none is running
  if(g_ScreensaverKey.currentWidget == null) return;

  Navigator.of(context).pop();
}
