// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_android.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_desktop.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_ios.dart';

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
    addNoteDesktop(note);
  }
  else if(Platform.isIOS) {
    addNoteIos(note);
  }
  else if(Platform.isAndroid) {
    addNoteAndroid(note);
  }
  else {
    throw Exception("Unsupported platform");
  }

  return true;
}

/// Checks if the DaKanji card type is present in Anki
Future<bool> daKanjiModelExists(){

  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return daKanjiModelExistsDesktop();
  }
  else if(Platform.isIOS) {
    return daKanjiModelExistsIOS();
  }
  else if(Platform.isAndroid) {
    return daKanjiModelExistsAndroid();
  }
  else {
    throw Exception("Unsupported platform");
  }


}

/// Adds the DaKanji card type to Anki, if it is not present, otherwise
/// adds it
Future<void> addDaKanjiModel() async {
  // assure anki is reachable
  if(!await checkAnkiConnectAvailable()){
    return;
  }

  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    addDaKanjiModelDesktop();
  }
  else if(Platform.isIOS) {
    addDaKanjiModelIOS();
  }
  else if(Platform.isAndroid) {
    addDaKanjiModelAndroid();
  }
  else {
    throw Exception("Unsupported platform");
  }

}


/// Adds a deck to Anki if not present
Future<void> addDeck(String deckName){
  
  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return addDeckDesktop(deckName);
  }
  else if(Platform.isIOS) {
    return addDeckIOS(deckName);
  }
  else if(Platform.isAndroid) {
    return addDeckAndroid(deckName);
  }
  else {
    throw Exception("Unsupported platform");
  }
  
}

/// Returns a list of all deck names available in anki
Future<List<String>> getDeckNames() async {
  // Add the card type to Anki platform dependent
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return getDeckNamesDesktop();
  }
  else if(Platform.isIOS) {
    return getDeckNamesIOS();
  }
  else if(Platform.isAndroid) {
    return getDeckNamesAndroid();
  }
  else {
    throw Exception("Unsupported platform");
  }
}

/// Checks if Anki is available on the current platform
Future<bool> checkAnkiAvailable(){
  if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
    return checkAnkiConnectAvailable();
  }
  else if(Platform.isIOS) {
    return checkAnkidroidAvailable();
  }
  else if(Platform.isAndroid) {
    return checkAnkiMobileRunning();
  }
  else {
    throw Exception("Unsupported platform");
  }
}

