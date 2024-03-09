// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/anki/anki_note.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_android.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_desktop.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_ios.dart';

/// Class to handle anki communication
class Anki {

  /// User settings for anki
  SettingsAnki settingsAnki;
  /// Communication with anki desktop
  AnkiDesktop? ankiDesktop;
  /// Communication with anki android
  AnkiAndroid? ankiAndroid;
  /// Communication with anki ios
  AnkiiOS? ankiiOS;


  Anki(
    this.settingsAnki
  ){
    if(Platform.isLinux || Platform.isLinux || Platform.isMacOS){
      ankiDesktop = AnkiDesktop(settingsAnki);
    }
    else if(Platform.isAndroid){
      ankiAndroid = AnkiAndroid(settingsAnki);
    }
    else if(Platform.isIOS){
      ankiiOS = AnkiiOS(settingsAnki);
    }
  }

  /// Initializes this instance
  Future init() async {

    if(Platform.isLinux || Platform.isLinux || Platform.isMacOS){
      
    }
    else if(Platform.isAndroid){
      await ankiAndroid!.init();
    }
    else if(Platform.isIOS){
      
    }
  
  }

  /// Addes the given note to Anki
  /// 
  /// Note: if the deck or model does not exist, it will be created
  Future<bool> addNote(AnkiNote note) async {

    // check that anki is running
    if(!await checkAnkiAvailable()){
      debugPrint("Anki not running");
    }
    // assure that the DaKanji card type is present
    if(!(await daKanjiModelExists())) {
      await addDaKanjiModel();
    }

    // Add the note to Anki platform dependent
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      ankiDesktop!.addNoteDesktop(note);
    }
    else if(Platform.isIOS) {
      ankiiOS!.addNoteIos(note);
    }
    else if(Platform.isAndroid) {
      ankiAndroid!.addNoteAndroid(note);
    }
    else {
      throw Exception("Unsupported platform");
    }

    return true;
  }

  /// Addes the given note*s* to Anki
  /// 
  /// Note: if the deck or model does not exist, it will be created
  Future addNotes(List<AnkiNote> notes) async {

    // check that anki is running
    if(!await checkAnkiAvailable()){
      debugPrint("Anki not running");
    }
    // assure that the DaKanji card type is present
    if(!(await daKanjiModelExists())) {
      await addDaKanjiModel();
    }

    // if the given deck does not exist, create it
    if(!(await getDeckNames()).contains(notes.first.deckName)) {
      await addDeck(notes.first.deckName);
    }

    // Add the note to Anki platform dependent
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      ankiDesktop!.addNotesDesktop(notes);
    }
    else if(Platform.isIOS) {
      ankiiOS!.addNotesIos(notes);
    }
    else if(Platform.isAndroid) {
      ankiAndroid!.addNotesAndroid(notes);
    }
    else {
      throw Exception("Unsupported platform");
    }

    return true;
  }

  /// Checks if the DaKanji card type is present in Anki
  Future<bool> daKanjiModelExists() async {

    // assure anki is reachable
    if(!await checkAnkiAvailable()){
      return false;
    }

    // Add the card type to Anki platform dependent
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      return ankiDesktop!.daKanjiModelExistsDesktop();
    }
    else if(Platform.isIOS) {
      return ankiiOS!.daKanjiModelExistsIOS();
    }
    else if(Platform.isAndroid) {
      return ankiAndroid!.daKanjiModelExistsAndroid();
    }
    else {
      throw Exception("Unsupported platform");
    }
  }

  /// Adds the DaKanji card type to Anki, if it is not present, otherwise
  /// adds it
  Future<void> addDaKanjiModel() async {

    // assure anki is reachable
    if(!await checkAnkiAvailable()){
      return;
    }

    // Add the card type to Anki platform dependent
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      ankiDesktop!.addDaKanjiModelDesktop();
    }
    else if(Platform.isIOS) {
      ankiiOS!.addDaKanjiModelIOS();
    }
    else if(Platform.isAndroid) {
      ankiAndroid!.addDaKanjiModelAndroid();
    }
    else {
      throw Exception("Unsupported platform");
    }
  }


  /// Adds a deck to Anki if not present
  Future<bool> addDeck(String deckName) async {

    // assure anki is reachable
    if(!await checkAnkiAvailable()){
      return false;
    }
    
    // Add the card type to Anki platform dependent
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      ankiDesktop!.addDeckDesktop(deckName);
    }
    else if(Platform.isIOS) {
      ankiiOS!.addDeckIOS(deckName);
    }
    else if(Platform.isAndroid) {
      ankiAndroid!.addDeckAndroid(deckName);
    }
    else {
      throw Exception("Unsupported platform");
    }

    return true;
  }

  /// Returns a list of all deck names available in anki
  Future<List<String>> getDeckNames() async {

    // assure anki is reachable
    if(!await checkAnkiAvailable()){
      return [];
    }

    // Add the card type to Anki platform dependent
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      return ankiDesktop!.getDeckNamesDesktop();
    }
    else if(Platform.isIOS) {
      return ankiiOS!.getDeckNamesIOS();
    }
    else if(Platform.isAndroid) {
      return ankiAndroid!.getDeckNamesAndroid();
    }
    else {
      throw Exception("Unsupported platform");
    }
  }

  /// Checks if Anki is available on the current platform
  Future<bool> checkAnkiAvailable(){
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux){
      return ankiDesktop!.checkAnkiConnectAvailable();
    }
    else if(Platform.isIOS) {
      return ankiiOS!.checkAnkiMobileRunning();
    }
    else if(Platform.isAndroid) {
      return ankiAndroid!.checkAnkidroidAvailable();
    }
    else {
      throw Exception("Unsupported platform");
    }
  }

  /// Checks if Anki is available on the current platform and show a snackbar
  /// accoringly
  Future<bool> checkAnkiAvailableAndShowSnackbar(
    BuildContext context, {String? successMessage, String? failureMessage}) async {

    bool ankiAvailable = await checkAnkiAvailable();

    if(ankiAvailable) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            successMessage ?? LocaleKeys.ManualScreen_anki_test_connection_success.tr(),
          ),
        ),
      );
    }
    else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (failureMessage ?? LocaleKeys.ManualScreen_anki_test_connection_fail.tr()),
          ),
        ),
      );
    }

    return ankiAvailable;
  }

}
