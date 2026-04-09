// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:da_kanji_mobile/features/settings/model/settings_advanced.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_anki.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_clipboard.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_dictionary.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_drawing.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_kana_table.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_kanji_table.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_misc.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_text.dart';
// Flutter imports:
import 'package:da_kanji_mobile/features/settings/model/settings_time_tracking.dart';
import 'package:da_kanji_mobile/features/settings/model/settings_word_lists.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

/// Class to store all settings of DaKanji
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
class Settings with ChangeNotifier {

  /// This settings object is a temporary instance and therefore calls to 
  /// `save` should do nothing
  bool isTemp;
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
  /// All settings related to time tracking
  late SettingsTimeTracking _timeTracking;



  Settings({
    this.isTemp = false,
  }){
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
    _timeTracking = SettingsTimeTracking();
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

  SettingsTimeTracking get timeTracking {
    return _timeTracking;
  }

  /// Saves all settings to the SharedPreferences.
  Future<void> save() async {
    
    // if this is a temporary settings object, skip saving
    if(isTemp) return;

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
    prefs.setString('settingsTimeTracking', json.encode(timeTracking.toJson()));
  }

  // Generic helper function to load a setting
  T _loadSetting<T extends Listenable>({
    required SharedPreferences prefs,
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
    required T Function() defaultConstructor,
  }) {

    try {
      String? tmp = prefs.getString(key);
      if (tmp != null && tmp.isNotEmpty) {
        T setting = fromJson(json.decode(tmp));
        setting.addListener(notifyListeners);
        return setting;
      }
    } catch (e) {
      // fall through
    }

    T setting = defaultConstructor();
    setting.addListener(notifyListeners);
    return setting;
  }

  /// Load all saved settings from SharedPreferences.
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
  _drawing      = _loadSetting(prefs: prefs, key: 'settingsDrawing',      fromJson: SettingsDrawing.fromJson,      defaultConstructor: SettingsDrawing.new);
  _misc         = _loadSetting(prefs: prefs, key: 'settingsMisc',         fromJson: SettingsMisc.fromJson,         defaultConstructor: SettingsMisc.new);
  _advanced     = _loadSetting(prefs: prefs, key: 'settingsAdvanced',     fromJson: SettingsAdvanced.fromJson,     defaultConstructor: SettingsAdvanced.new);
  _dictionary   = _loadSetting(prefs: prefs, key: 'settingsDictionary',   fromJson: SettingsDictionary.fromJson,   defaultConstructor: SettingsDictionary.new);
  _text         = _loadSetting(prefs: prefs, key: 'settingsText',         fromJson: SettingsText.fromJson,         defaultConstructor: SettingsText.new);
  _anki         = _loadSetting(prefs: prefs, key: 'settingsAnki',         fromJson: SettingsAnki.fromJson,         defaultConstructor: SettingsAnki.new);
  _kanjiTable   = _loadSetting(prefs: prefs, key: 'settingsKanjiTable',   fromJson: SettingsKanjiTable.fromJson,   defaultConstructor: SettingsKanjiTable.new);
  _kanaTable    = _loadSetting(prefs: prefs, key: 'settingsKanaTable',    fromJson: SettingsKanaTable.fromJson,    defaultConstructor: SettingsKanaTable.new);
  _wordLists    = _loadSetting(prefs: prefs, key: 'settingsWordLists',    fromJson: SettingsWordLists.fromJson,    defaultConstructor: SettingsWordLists.new);
  _clipboard    = _loadSetting(prefs: prefs, key: 'settingsClipboard',    fromJson: SettingsClipboard.fromJson,    defaultConstructor: SettingsClipboard.new);
  _timeTracking = _loadSetting(prefs: prefs, key: 'settingsTimeTracking', fromJson: SettingsTimeTracking.fromJson, defaultConstructor: SettingsTimeTracking.new);
  
  }
}

