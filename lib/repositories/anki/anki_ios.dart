// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';

/// Class to communicate with anki ios
class AnkiiOS {

  /// User settings for anki
  SettingsAnki settingsAnki;


  AnkiiOS(
    this.settingsAnki
  );

  /// Platform specific (desktop via anki connect) implementation of `add_note`
  void addNoteIos(AnkiNote note) async {
    // TODO v word lists - implement iOS
    throw Exception("Not implemented");
  }

  /// platform specific (ios via ankimobile) implementation of
  /// `daKanjiModelExists`
  Future<bool> daKanjiModelExistsIOS() async {

    // TODO v word lists - implement iOS

    return false;
  }

  /// Platform specific (iOS via anki mobile) implementation of
  /// `addDaKanjiCardType`
  Future<void> addDaKanjiModelIOS() async {
    // TODO v word lists implement iOS
    throw Exception("Not implemented");
  }

  /// Platform specific (iOS via ankimobile) implementation of `addDeck`
  Future<void> addDeckIOS(String deckName) async {
    // TODO v word lists implement iOS
    throw Exception("Not implemented");
  }

  /// Platform specific (iOS via ankimobile) implementation of `getDeckNames`
  Future<List<String>> getDeckNamesIOS() async {
    // TODO v word lists implement iOS
    throw Exception("Not implemented");
  }

  /// Platform specific (iOS via anki mobile) implementation of
  /// `check_anki_available`
  Future<bool> checkAnkiMobileRunning() async {
    bool isRunning = false;

    // TODO v word lists implement iOS
    throw Exception("Not implemented");

    return isRunning;
  }

}
