// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:da_kanji_mobile/entities/settings/settings_word_lists.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/settings/settings_advanced.dart';
import 'package:da_kanji_mobile/entities/settings/settings_anki.dart';
import 'package:da_kanji_mobile/entities/settings/settings_clipboard.dart';
import 'package:da_kanji_mobile/entities/settings/settings_dictionary.dart';
import 'package:da_kanji_mobile/entities/settings/settings_drawing.dart';
import 'package:da_kanji_mobile/entities/settings/settings_kana_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings_kanji_table.dart';
import 'package:da_kanji_mobile/entities/settings/settings_misc.dart';
import 'package:da_kanji_mobile/entities/settings/settings_text.dart';

/// Class to store all settings of DaKanji
class Settings with ChangeNotifier {

  /// All settings related to the drawing part of the app
  late SettingsDrawing _drawing;
  /// All miscellaneous settings of the app
  late SettingsMisc _misc;
  /// All miscellaneous settings of the app
  late SettingsAdvanced _advanced;
  /// All settings related to the dictionary part of the app
  late SettingsDictionary _dictionary;
  /// All settings related to the text part of the app
  late SettingsText _text;
  /// All settings related to the anki integration
  late SettingsAnki _anki;
  /// All settings related to the kanji table screen
  late SettingsKanjiTable _kanjiTable;
  /// All settings related to the kana table screen
  late SettingsKanaTable _kanaTable;
  /// All settings related to word lists
  late SettingsWordLists _wordLists;
  /// All settings realted to the clipboard screen
  late SettingsClipboard _clipboard;


  Settings(){
    _drawing    = SettingsDrawing();
    _misc       = SettingsMisc(); 
    _advanced   = SettingsAdvanced();
    _dictionary = SettingsDictionary();
    _text       = SettingsText();
    _anki       = SettingsAnki();
    _kanjiTable = SettingsKanjiTable();
    _kanaTable  = SettingsKanaTable();
    _wordLists  = SettingsWordLists();
    _clipboard  = SettingsClipboard();
  }


  SettingsDrawing get drawing {
    return _drawing;
  }

  SettingsMisc get misc {
    return _misc;
  }

  SettingsAdvanced get advanced {
    return _advanced;
  }

  SettingsDictionary get dictionary {
    return _dictionary;
  }

  SettingsText get text {
    return _text;
  }

  SettingsAnki get anki {
    return _anki;
  }

  SettingsKanjiTable get kanjiTable {
    return _kanjiTable;
  }

  SettingsKanaTable get kanaTable {
    return _kanaTable;
  }

  SettingsWordLists get wordLists {
    return _wordLists;
  }

  SettingsClipboard get clipboard{
    return _clipboard;
  }

  /// Saves all settings to the SharedPreferences.
  Future<void> save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences
    prefs.setString('settingsDrawing', json.encode(drawing.toJson()));
    prefs.setString('settingsMisc', json.encode(misc.toJson()));
    prefs.setString('settingsAdvanced', json.encode(advanced.toJson()));
    prefs.setString('settingsDictionary', json.encode(dictionary.toJson()));
    prefs.setString('settingsText', json.encode(text.toJson()));
    prefs.setString('settingsAnki', json.encode(anki.toJson()));
    prefs.setString('settingsKanjiTable', json.encode(kanjiTable.toJson()));
    prefs.setString('settingsKanaTable', json.encode(kanaTable.toJson()));
    prefs.setString('settingsWordLists', json.encode(wordLists.toJson()));
    prefs.setString('settingsClipboard', json.encode(clipboard.toJson()));
  }

  /// Load all saved settings from SharedPreferences.
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // DRAWING SETTINGS
    try{
      String tmp = prefs.getString('settingsDrawing') ?? "";
      if(tmp != "") {_drawing = SettingsDrawing.fromJson(json.decode(tmp));}
      else {_drawing = SettingsDrawing();}
    }
    catch (e) {
      _drawing = SettingsDrawing();
    }
    _drawing.addListener(() => notifyListeners());
    
    // MISC SETTINGS
    try{
      String tmp = prefs.getString('settingsMisc') ?? "";
      if(tmp != "") {_misc = SettingsMisc.fromJson(json.decode(tmp));}
      else {_misc = SettingsMisc();}
    }
    catch (e) {
      _misc = SettingsMisc();
    }
    _misc.addListener(() => notifyListeners());

    // ADVANCED SETTINGS
    try{
      String tmp = prefs.getString('settingsAdvanced') ?? "";
      if(tmp != "") {_advanced = SettingsAdvanced.fromJson(json.decode(tmp));}
      else {_advanced = SettingsAdvanced();}
    }
    catch (e) {
      _advanced = SettingsAdvanced();
    }
    _advanced.addListener(() => notifyListeners());

    // DICTIONARY SETTINGS
    try{
      String tmp = prefs.getString('settingsDictionary') ?? "";
      if(tmp != "") {_dictionary = SettingsDictionary.fromJson(json.decode(tmp));}
      else {_dictionary = SettingsDictionary();}
    }
    catch (e) {
      _dictionary = SettingsDictionary();
    }
    _dictionary.addListener(() => notifyListeners());

    // TEXT SETTINGS
    try{
      String tmp = prefs.getString('settingsText') ?? "";
      if(tmp != "") {_text = SettingsText.fromJson(json.decode(tmp));}
      else {_text = SettingsText();}
    }
    catch (e) {
      _text = SettingsText();
    }
    _text.addListener(() => notifyListeners());

    // ANKI SETTINGS
    try{
      String tmp = prefs.getString('settingsAnki') ?? "";
      if(tmp != "") {_anki = SettingsAnki.fromJson(json.decode(tmp));}
      else {_anki = SettingsAnki();}
    }
    catch (e) {
      _anki = SettingsAnki();
    }
    _anki.addListener(() => notifyListeners());

    // KANJI TABLE SETTINGS
    try{
      String tmp = prefs.getString('settingsKanjiTable') ?? "";
      if(tmp != "") {_kanjiTable = SettingsKanjiTable.fromJson(json.decode(tmp));}
      else {_kanjiTable = SettingsKanjiTable();}
    }
    catch (e) {
      _kanjiTable = SettingsKanjiTable();
    }
    _kanjiTable.addListener(() => notifyListeners());

    // KANA TABLE SETTINGS
    try{
      String tmp = prefs.getString('settingsKanaTable') ?? "";
      if(tmp != "") {_kanaTable = SettingsKanaTable.fromJson(json.decode(tmp));}
      else {_kanaTable = SettingsKanaTable();}
    }
    catch (e) {
      _kanaTable = SettingsKanaTable();
    }
    _kanaTable.addListener(() => notifyListeners());

    // WORD LISTS SETTINGS
    try{
      String tmp = prefs.getString('settingsWordLists') ?? "";
      if(tmp != "") {_wordLists = SettingsWordLists.fromJson(json.decode(tmp));}
      else {_wordLists = SettingsWordLists();}
    }
    catch (e) {
      _wordLists = SettingsWordLists();
    }
    _wordLists.addListener(() => notifyListeners());

    // CLIPBOARD SETTINGS
    try{
      String tmp = prefs.getString('settingsClipboard') ?? "";
      if(tmp != "") {_clipboard = SettingsClipboard.fromJson(json.decode(tmp));}
      else {_clipboard = SettingsClipboard();}
    }
    catch (e) {
      _clipboard = SettingsClipboard();
    }
    _clipboard.addListener(() => notifyListeners());
  }
}

