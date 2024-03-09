// Project imports:
import 'dart:async';
import 'dart:convert';

import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Class to communicate with anki ios
class AnkiiOS {

  /// User settings for anki
  SettingsAnki settingsAnki;
  /// the url scheme to interact with ankimobile
  static const ankiMobileURLScheme = "anki://x-callback-url";
  /// the Clipboard format from ankimobile
  static const ankiMobileFormat = "net.ankimobile.json";


  AnkiiOS(
    this.settingsAnki
  );

  /// Platform specific (desktop via anki connect) implementation of `add_note`
  void addNoteIos(AnkiNote note) async {
    // TODO v word lists - implement iOS
    throw Exception("Not implemented");
  }

    /// Platform specific (iOS via ankiMobile) implementation of `add_notes`
  void addNotesIos(List<AnkiNote> notes) async {

    List<Map> jsonNotes = [];

    return;

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

    return await canLaunchUrlString("anki://");

  }

}
