// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:super_clipboard/super_clipboard.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';

/// Class to communicate with anki ios
class AnkiiOS {

  /// User settings for anki
  SettingsAnki settingsAnki;
  /// the url scheme to interact with ankimobile
  static const ankiMobileURLScheme = "anki://x-callback-url";
  /// url callback that on success opens dakanji again
  static const ankiMobileURLSchemeCallback = "x-success=dakanji://";
  /// the Clipboard format from ankimobile
  static const ankiMobileFormat = "net.ankimobile.json";


  AnkiiOS(
    this.settingsAnki
  );

  /// Returns a string that can be used to add the given note to ankimobile
  String addNoteSchemeFromAnkiNote(AnkiNote note, bool allowDuplicates){

    // anki://x-callback-url/addnote?
    String url = "$ankiMobileURLScheme/addnote?";
    // set duplicate options
    if(allowDuplicates) url += "dupes=1&";
    // set note type
    url += "type=${note.noteType}&";
    // set deck
    url += "deck=${note.deckName}&";
    // tags=<tags separated by space>
    url += "tags=${note.tags.join(" ")}&";
    // add all fields
    for (MapEntry field in note.fields.entries) {
      url += "fld${field.key}=${field.value}&";
    }
    url += "&x-success=dakanji://";

    return url;

  }

  /// Platform specific (desktop via anki connect) implementation of `add_note`
  Future<void> addNoteIos(AnkiNote note, bool allowDuplicates) async {
    
    await launchUrlString(
      Uri.encodeFull(addNoteSchemeFromAnkiNote(note, allowDuplicates)));

    /// Wait until anki closes
    while (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

  }

  /// Platform specific (iOS via ankiMobile) implementation of `add_notes`
  Future<void> addNotesIos(List<AnkiNote> notes, bool allowDuplicates) async {

    for (var note in notes) {
      await addNoteIos(note, allowDuplicates);
    }

  }

  /// platform specific (ios via ankimobile) implementation of
  /// `daKanjiModelExists`
  Future<bool> daKanjiModelExistsIOS() async {

    final String ankiJsonString = await getUserAnkiDataIos();
    
    final Map ankiJsonMap = jsonDecode(ankiJsonString);
    final List<String> noteTypeNames = List<String>.from(ankiJsonMap["notetypes"]
      .map((e) => e["name"]));

    return noteTypeNames.contains(ankiDataCardModelName);

  }

  /// Platform specific (iOS via anki mobile) implementation of
  /// `addDaKanjiCardType`
  Future<void> addDaKanjiModelIOS() async {
    // not possible in ankimobile
  }

  /// Platform specific (iOS via ankimobile) implementation of `addDeck`
  Future<void> addDeckIOS(String deckName) async {
    // not possible in ankimobile
  }

  /// Returns the user data from anki as a string
  Future<String> getUserAnkiDataIos() async {

    // get the current clipboard
    ClipboardData? originalClipboard = await Clipboard.getData("text/plain");
    
    // Launch anki via AnkiMobile scheme
    await launchUrlString("$ankiMobileURLScheme/infoForAdding?x-success=$g_AppLinkDaKanji",
      mode: LaunchMode.externalApplication,
    );
    /// Wait until anki closes
    while (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // read the data from the clipboard
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) return "";
    final reader = await clipboard.read();
    final List<int> ankiJsonBytes = await reader.readValue(
      const CustomValueFormat(applicationId: ankiMobileFormat)) as List<int>;

    // convert the read bytes to a list of deck names
    final String ankiJsonString = (utf8.decode(ankiJsonBytes));

    // Set the original clipboard
    if(originalClipboard != null) Clipboard.setData(originalClipboard);

    return ankiJsonString;

  }

  /// Platform specific (iOS via ankimobile) implementation of `getDeckNames`
  Future<List<String>> getDeckNamesIOS() async {

    final String ankiJsonString = await getUserAnkiDataIos();
    
    final Map ankiJsonMap = jsonDecode(ankiJsonString);
    final List<String> deckNames = List<String>.from(ankiJsonMap["decks"]
      .map((e) => e["name"]));

    return deckNames;

  }

  /// Platform specific (iOS via anki mobile) implementation of
  /// `check_anki_available`
  Future<bool> checkAnkiMobileRunning() async {

    return await canLaunchUrlString("anki://");

  }

}
