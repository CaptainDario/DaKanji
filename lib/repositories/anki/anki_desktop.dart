// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';

/// Class to communicate with anki desktop
class AnkiDesktop {

  /// User settings for anki
  SettingsAnki settingsAnki;


  AnkiDesktop(
    this.settingsAnki
  );


  /// Platform specific (desktop via anki connect) implementation of `add_note`
  Future<http.Response> addNoteDesktop(AnkiNote note, bool allowDuplicates) async {

    // Create the body of the request
    Map<String, dynamic> body = {
      "action": "addNote",
      "version": 6,
      "params": {
        "note": {
          "deckName": note.deckName,
          "modelName": note.noteType,
          "fields": note.fields,
          "options": {
            "allowDuplicate": allowDuplicates,
            //"duplicateScope": "deck",
            //"duplicateScopeOptions": {
            //  "deckName": note.deckName,
            //  "checkChildren": false
            //}
          },
          "tags": note.tags
        }
      }
    };
    String bodyString = jsonEncode(body);

    http.Response r = await http.post(
      settingsAnki.desktopAnkiUri,
      body: bodyString);

    return r;
  }

  /// Platform specific (desktop via anki connect) implementation of `add_notes`
  Future<http.Response> addNotesDesktop(List<AnkiNote> notes, bool allowDuplicates) async {

    List<Map> jsonNotes = [];

    for (var note in notes) {
      
      jsonNotes.add({
        "deckName": note.deckName,
        "modelName": note.noteType,
        "fields": note.fields,
        "options": {
          "allowDuplicate": allowDuplicates,
          //"duplicateScope": "deck",
          //"duplicateScopeOptions": {
          //  "deckName": note.deckName,
          //  "checkChildren": false
          //}
        },
        "tags": note.tags
      });

    }
    
    // Create the body of the request
    Map<String, dynamic> body = {
      "action": "addNotes",
      "version": 6,
      "params": {
        "notes": jsonNotes
      }
    };
    String bodyString = jsonEncode(body);

    http.Response r = await http.post(
      settingsAnki.desktopAnkiUri,
      body: bodyString);

    return r;

  }

  /// platform specific (desktop via anki connect) implementation of
  /// `daKanjiModelExists`
  Future<bool> daKanjiModelExistsDesktop() async {

    Map<String, dynamic> body = {
      "action": "modelNames",
      "version": 6
    };
    String bodyString = jsonEncode(body);

    http.Response r = await http.post(settingsAnki.desktopAnkiUri, body: bodyString);
    Map rMap = jsonDecode(r.body);

    if(rMap.containsKey("result")) {
      return rMap["result"].contains(ankiDataCardModelName);
    } else {
      return false;
    }

  }

  /// Platform specific (desktop via anki connect) implementation of
  /// `addDaKanjiCardType`
  Future<http.Response> addDaKanjiModelDesktop() async {

    // Create the DaKanji Cart type if it is not present
    Map body = {
      "action": "createModel",
      "version": 6,
      "params": {
        "modelName": ankiDataCardModelName,
        "inOrderFields": ankiDataFields,
        "css" : ankiDataStyling,
        "isCloze": false,
        "cardTemplates": [
          {
            "Name" : ankiDataCardTypeName,
            "Front": ankiDataFrontTemplate,
            "Back" : ankiDataBackTemplate
          }
        ]
      }
    };
    String bodyString = jsonEncode(body);

    http.Response r = await http.post(settingsAnki.desktopAnkiUri, body: bodyString);
    return r;
  }

  /// Platform specific (desktop via anki connect) implementation of `addDeck`
  Future<http.Response> addDeckDesktop(String deckName) async {
    
    // Create the body of the request
    Map<String, dynamic> body = {
      "action": "createDeck",
      "version": 6,
      "params": {
          "deck": deckName
      }
    };
    String bodyString = jsonEncode(body);

    http.Response r = await http.post(settingsAnki.desktopAnkiUri, body: bodyString);

    return r;

  }

  /// Platform specific (desktop via anki connect) implementation of `getDeckNames`
  Future<List<String>> getDeckNamesDesktop() async {
    // Create the body of the request
    Map<String, dynamic> body = {
      "action": "deckNames",
      "version": 6
    };
    String bodyString = jsonEncode(body);

    http.Response r = await http.post(settingsAnki.desktopAnkiUri, body: bodyString);

    return List<String>.from(jsonDecode(r.body)["result"]);
  }

  /// Platform specific (desktop via anki connect) implementation of
  /// `check_anki_available`
  Future<bool> checkAnkiConnectAvailable() async {
    bool isRunning = false;

    try {
      var response = await http.get(settingsAnki.desktopAnkiUri);
      if(response.statusCode == 200){
        isRunning = true;
      }
    }
    catch(e){
      // Anki is not running
      debugPrint(e.toString());
    }

    return isRunning;
  }
}
