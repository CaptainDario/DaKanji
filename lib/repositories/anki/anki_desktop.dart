// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:da_kanji_mobile/domain/anki/anki_note.dart';


Uri ankiConnectUrl = Uri.http("localhost:8765");

/// Platform specific (desktop via anki connect) implementation of `add_note`
void addNoteDesktop(AnkiNote note) async {

  // Create the body of the request
  Map<String, dynamic> body = {
    "action": "addNote",
    "version": 6,
    "params": {
      "note": {
        "deckName": note.deckName,
        "modelName": note.cardType,
        "fields": note.fields,
        "options": {
          "allowDuplicate": false,
          "duplicateScope": "deck",
          "duplicateScopeOptions": {
            "deckName": note.deckName,
            "checkChildren": false
          }
        },
        "tags": note.tags
      }
    }
  };
  String bodyString = jsonEncode(body);

  http.Response r = await http.post(ankiConnectUrl, body: bodyString);
}

/// platform specific (desktop via anki connect) implementation of
/// `daKanjiModelExists`
Future<bool> daKanjiModelExistsDesktop() async {

  Map<String, dynamic> body = {
    "action": "modelNames",
    "version": 6
  };
  String bodyString = jsonEncode(body);

  http.Response r = await http.post(ankiConnectUrl, body: bodyString);
  Map rMap = jsonDecode(r.body);

  if(rMap.containsKey("result")) {
    return rMap["result"].contains("DaKanji");
  } else {
    return false;
  }

}

/// Platform specific (desktop via anki connect) implementation of
/// `addDaKanjiCardType`
Future<void> addDaKanjiModelDesktop() async {

  // Create the DaKanji Cart type if it is not present
  Map body = {
    "action": "createModel",
    "version": 6,
    "params": {
      "modelName": "DaKanji",
      "inOrderFields": [
        "Translations", "Japanese", "Kana",
        "GoogleImage", "Audio", "EncounteredImage",
      ],
      "isCloze": false,
      "cardTemplates": [
        {
          "Name": "DaKanji card",
          "Front": "Front html {{Translations}}",
          "Back": "Back html  {{Japanese}} {{GoogleImage}} {{Audio}} {{EncounteredImage}}"
        }
      ]
    }
  };
  String bodyString = jsonEncode(body);

  http.Response r = await http.post(ankiConnectUrl, body: bodyString);
  
  return;
}

/// Platform specific (desktop via anki connect) implementation of `addDeck`
Future<void> addDeckDesktop(String deckName) async {
  
  // Create the body of the request
  Map<String, dynamic> body = {
    "action": "createDeck",
    "version": 6,
    "params": {
        "deck": deckName
    }
  };
  String bodyString = jsonEncode(body);

  http.Response r = await http.post(ankiConnectUrl, body: bodyString);

}

/// Platform specific (desktop via anki connect) implementation of `getDeckNames`
Future<List<String>> getDeckNamesDesktop() async {
  // Create the body of the request
  Map<String, dynamic> body = {
    "action": "deckNames",
    "version": 6
  };
  String bodyString = jsonEncode(body);

  http.Response r = await http.post(ankiConnectUrl, body: bodyString);

  return List<String>.from(jsonDecode(r.body)["result"]);
}

/// Platform specific (desktop via anki connect) implementation of
/// `check_anki_available`
Future<bool> checkAnkiConnectAvailable() async {
  bool isRunning = false;

  try {
    var response = await http.get(ankiConnectUrl);
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