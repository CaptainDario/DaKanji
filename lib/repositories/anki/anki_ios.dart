// Project imports:
import 'dart:async';
import 'dart:convert';

import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';
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
  /// url callback that on success opens dakanji again
  static const ankiMobileURLSchemeCallback = "x-success=dakanji://";
  /// the Clipboard format from ankimobile
  static const ankiMobileFormat = "net.ankimobile.json";


  AnkiiOS(
    this.settingsAnki
  );

  /// Returns a string that can be used to add teh given note to ankimobile
  String addNoteSchemeFromAnkiNote(AnkiNote note){

    // anki://x-callback-url/addnote?
    String url = "$ankiMobileURLScheme/addnote?";
    // profile=User%201&

    // type=Basic
    url += "type=${note.noteType}&";
    // deck=Default&
    url += "deck=${note.deckName}&";
    // tags=<tags separated by space>
    url += "tags=${note.tags.join(" ")}&";
    // fldFront=front%20text&
    for (MapEntry field in note.fields.entries) {
      url += "fld${field.key}=${field.value}&";
    }
    url += "&x-success=dakanji://";

    return url;

  }

  /// Platform specific (desktop via anki connect) implementation of `add_note`
  Future<void> addNoteIos(AnkiNote note) async {
    
    await launchUrlString(Uri.encodeFull(addNoteSchemeFromAnkiNote(note)));

  }

  /// Platform specific (iOS via ankiMobile) implementation of `add_notes`
  Future<void> addNotesIos(List<AnkiNote> notes) async {

    for (var note in notes) {
      await addNoteIos(note);
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

  Future<String> getUserAnkiDataIos() async {

    // get the current clipboard
    ClipboardData? originalClipboard = await Clipboard.getData("text/plain");
    
    // Launch anki via AnkiMobile scheme
    await launchUrlString("$ankiMobileURLScheme/infoForAdding?x-success=dakanji://",
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
