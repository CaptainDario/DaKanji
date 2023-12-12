// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:da_kanji_mobile/domain/anki/anki_note.dart';

Uri ankiConnectUrl = Uri.http("localhost:8765");

/// Addes the given note to Anki
/// 
/// Note: if the deck or model does not exist, it will be created
Future<bool> addNote(AnkiNote note) async {

  // checl that anki is running
  if(!await checkAnkiAvailable()){
    debugPrint("Anki not running");
  }
  // assure that the DaKanji card type is present
  if(!(await daKanjiModelExists())) {
    await addDaKanjiModel();
  }

  // if the given deck does not exist, create it
  if(!(await getDeckNames()).contains(note.deckName)) {
    await addDeck(note.deckName);
  }


  // Add the note to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    _addNoteDesktop(note);
  }
  else if(Platform.isIOS) {
    _addNoteIos(note);
  }
  else if(Platform.isAndroid) {
    _addNoteAndroid(note);
  }
  else {
    throw Exception("Unsupported platform");
  }

  return true;
}

/// Platform specific (desktop via anki connect) implementation of `add_note`
void _addNoteDesktop(AnkiNote note) async {

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

/// Platform specific (desktop via anki connect) implementation of `add_note`
void _addNoteIos(AnkiNote note) async {
  // TODO v word lists - implement iOS
  throw Exception("Not implemented");
}

/// Platform specific (desktop via anki connect) implementation of `add_note`
void _addNoteAndroid(AnkiNote note) async {
  // TODO v word lists - implement android
  throw Exception("Not implemented");
}


/// Checks if the DaKanji card type is present in Anki
Future<bool> daKanjiModelExists(){

  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return _daKanjiModelExistsDesktop();
  }
  else if(Platform.isIOS) {
    return _daKanjiModelExistsIOS();
  }
  else if(Platform.isAndroid) {
    return _daKanjiModelExistsAndroid();
  }
  else {
    throw Exception("Unsupported platform");
  }


}

/// platform specific (desktop via anki connect) implementation of
/// `daKanjiModelExists`
Future<bool> _daKanjiModelExistsDesktop() async {

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

/// platform specific (android via ankidroid) implementation of
/// `daKanjiModelExists`
Future<bool> _daKanjiModelExistsAndroid() async {

  // TODO v word lists - implement android

  return false;

}

/// platform specific (ios via ankimobile) implementation of
/// `daKanjiModelExists`
Future<bool> _daKanjiModelExistsIOS() async {

  // TODO v word lists - implement iOS

  return false;
}


/// Adds the DaKanji card type to Anki, if it is not present, otherwise
/// adds it
Future<void> addDaKanjiModel() async {
  // assure anki is reachable
  if(!await _checkAnkiConnectAvailable()){
    return;
  }

  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    _addDaKanjiModelDesktop();
  }
  else if(Platform.isIOS) {
    _addDaKanjiModelIOS();
  }
  else if(Platform.isAndroid) {
    _addDaKanjiModelAndroid();
  }
  else {
    throw Exception("Unsupported platform");
  }

}

/// Platform specific (desktop via anki connect) implementation of
/// `addDaKanjiCardType`
Future<void> _addDaKanjiModelDesktop() async {

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

/// Platform specific (android via ankidroid) implementation of
/// `addDaKanjiCardType`
Future<void> _addDaKanjiModelAndroid() async {
  // TODO v word lists - implement android
  throw Exception("Not implemented");
}

/// Platform specific (iOS via anki mobile) implementation of
/// `addDaKanjiCardType`
Future<void> _addDaKanjiModelIOS() async {
  // TODO v word lists implement iOS
  throw Exception("Not implemented");
}


/// Adds a deck to Anki if not present
Future<void> addDeck(String deckName){
  
  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return _addDeckDesktop(deckName);
  }
  else if(Platform.isIOS) {
    return _addDeckIOS(deckName);
  }
  else if(Platform.isAndroid) {
    return _addDeckAndroid(deckName);
  }
  else {
    throw Exception("Unsupported platform");
  }
  
}

/// Platform specific (desktop via anki connect) implementation of `addDeck`
Future<void> _addDeckDesktop(String deckName) async {
  
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

/// Platform specific (android via ankidroid) implementation of `addDeck`
Future<void> _addDeckAndroid(String deckName) async {
  // TODO v word lists implement android
  throw Exception("Not implemented");
}

/// Platform specific (iOS via ankimobile) implementation of `addDeck`
Future<void> _addDeckIOS(String deckName) async {
  // TODO v word lists implement iOS
  throw Exception("Not implemented");
}


/// Returns a list of all deck names available in anki
Future<List<String>> getDeckNames() async {
  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return _getDeckNamesDesktop();
  }
  else if(Platform.isIOS) {
    return _getDeckNamesIOS();
  }
  else if(Platform.isAndroid) {
    return _getDeckNamesAndroid();
  }
  else {
    throw Exception("Unsupported platform");
  }
}

/// Platform specific (desktop via anki connect) implementation of `getDeckNames`
Future<List<String>> _getDeckNamesDesktop() async {
  // Create the body of the request
  Map<String, dynamic> body = {
    "action": "deckNames",
    "version": 6
  };
  String bodyString = jsonEncode(body);

  http.Response r = await http.post(ankiConnectUrl, body: bodyString);

  return List<String>.from(jsonDecode(r.body)["result"]);
}

/// Platform specific (android via ankidroid) implementation of `getDeckNames`
Future<List<String>> _getDeckNamesAndroid() async {
  // TODO v word lists implement android
  throw Exception("Not implemented");
}

/// Platform specific (iOS via ankimobile) implementation of `getDeckNames`
Future<List<String>> _getDeckNamesIOS() async {
  // TODO v word lists implement iOS
  throw Exception("Not implemented");
}


/// Checks if Anki is available on the current platform
Future<bool> checkAnkiAvailable(){
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return _checkAnkiConnectAvailable();
  }
  else if(Platform.isIOS) {
    return _checkAnkidroidAvailable();
  }
  else if(Platform.isAndroid) {
    return _checkAnkiMobileRunning();
  }
  else {
    throw Exception("Unsupported platform");
  }
}

/// Platform specific (desktop via anki connect) implementation of
/// `check_anki_available`
Future<bool> _checkAnkiConnectAvailable() async {
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

/// Platform specific (android via ankidroid) implementation of
/// `check_anki_available`
Future<bool> _checkAnkidroidAvailable() async {
  bool isRunning = false;

  // TODO v word lists implement android
  throw Exception("Not implemented");

  return isRunning;
}

/// Platform specific (iOS via anki mobile) implementation of
/// `check_anki_available`
Future<bool> _checkAnkiMobileRunning() async {
  bool isRunning = false;

  // TODO v word lists implement iOS
  throw Exception("Not implemented");

  return isRunning;
}
