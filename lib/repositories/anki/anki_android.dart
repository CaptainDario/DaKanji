import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';
import 'package:flutter_ankidroid/flutter_ankidroid.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';



/// Class to communicate with AnkiDroid (anki on android)
class AnkiAndroid {

  /// User settings for anki
  SettingsAnki settingsAnki;
  /// AnkiDroid communication isolate
  late final Ankidroid ankidroid;


  AnkiAndroid(
    this.settingsAnki
  );
    
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

}
