// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';

/// When the step of tutorial changes
void onTutorialStep (int index) async {
  debugPrint("Tutorial step: $index");
  if(index == GetIt.I<Tutorials>().drawScreenTutorial.indexes!.last){
    debugPrint("DrawScreen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialDrawing = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().dictionaryScreenTutorial.indexes!.last){
    debugPrint("DictionaryScreen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialDictionary = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().textScreenTutorial.indexes!.last){
    debugPrint("TextScreen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialText = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().clipboardScreenTutorial.indexes!.last){
    debugPrint("Clipboard screen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialClipboard = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().kanjiTableScreenTutorial.indexes!.last){
    debugPrint("Kanji table screen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialKanjiTable = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().kanjiMapScreenTutorial.indexes!.last){
    debugPrint("Kanji map screen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialKanjiMap = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().kanaTableScreenTutorial.indexes!.last){
    debugPrint("Kana table screen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialKanaTable = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().wordListsScreenTutorial.indexes!.last){
    debugPrint("Word lists screen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialWordLists = false;
    await GetIt.I<UserData>().save();
  }
  else if(index == GetIt.I<Tutorials>().dojgScreenTutorial.indexes!.last){
    debugPrint("Dojg screen tutorial done, saving...");
    GetIt.I<UserData>().showTutorialDojg = false;
    await GetIt.I<UserData>().save();
  }
}
