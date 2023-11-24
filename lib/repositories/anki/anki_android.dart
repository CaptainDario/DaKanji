// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';


/// Platform specific (desktop via anki connect) implementation of `add_note`
void addNoteAndroid(AnkiNote note) async {
  // TODO v word lists - implement android
  throw Exception("Not implemented");
}

/// platform specific (android via ankidroid) implementation of
/// `daKanjiModelExists`
Future<bool> daKanjiModelExistsAndroid() async {

  // TODO v word lists - implement android

  return false;

}

/// Platform specific (android via ankidroid) implementation of
/// `addDaKanjiCardType`
Future<void> addDaKanjiModelAndroid() async {
  // TODO v word lists - implement android
  throw Exception("Not implemented");
}

/// Platform specific (android via ankidroid) implementation of `addDeck`
Future<void> addDeckAndroid(String deckName) async {
  // TODO v word lists implement android
  throw Exception("Not implemented");
}

/// Platform specific (android via ankidroid) implementation of `getDeckNames`
Future<List<String>> getDeckNamesAndroid() async {
  // TODO v word lists implement android
  throw Exception("Not implemented");
}


/// Platform specific (android via ankidroid) implementation of
/// `check_anki_available`
Future<bool> checkAnkidroidAvailable() async {
  bool isRunning = false;

  // TODO v word lists implement android
  throw Exception("Not implemented");

  return isRunning;
}