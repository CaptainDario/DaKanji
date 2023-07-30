import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:da_kanji_mobile/domain/settings/settings_kanji_table.dart';
import 'package:da_kanji_mobile/domain/settings/settings_drawing.dart';
import 'package:da_kanji_mobile/domain/settings/settings_advanced.dart';
import 'package:da_kanji_mobile/domain/settings/settings_misc.dart';
import 'package:da_kanji_mobile/domain/settings/settings_dictionary.dart';
import 'package:da_kanji_mobile/domain/settings/settings_anki.dart';



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
  /// All settings related to the anki integration
  late SettingsAnki _anki;
  /// All settings related to the 
  late SettingsKanjiTable _kanjiTable;


  Settings(){
    _drawing    = SettingsDrawing();
    _misc       = SettingsMisc(); 
    _advanced   = SettingsAdvanced();
    _dictionary = SettingsDictionary();
    _anki       = SettingsAnki();
    _kanjiTable = SettingsKanjiTable();
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

  SettingsAnki get anki {
    return _anki;
  }

  SettingsKanjiTable get kanjiTable {
    return _kanjiTable;
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
    prefs.setString('settingsAnki', json.encode(anki.toJson()));
    prefs.setString('settingsKanjiTable', json.encode(kanjiTable.toJson()));
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
  }
}

