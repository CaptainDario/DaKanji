import 'package:da_kanji_mobile/model/InferenceBackends.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



class Settings with ChangeNotifier {
  /// The placeholder in the URL's which will be replaced by the predicted kanji
  String kanjiPlaceholder = "%X%";

  /// The custom URL a user can define on the settings page.
  String customURL = "";

  /// The URL of the jisho website
  late String jishoURL;

  /// The URL of the weblio website
  late String wadokuURL;

  /// The URL of the weblio website
  late String weblioURL;

  /// A list with all available dictionary options.
  List<String> dictionaries = [];

  /// A list with all web dictionaries
  late List<String> web_dictionaries;

  /// The string representation of the dictionary which will be used (long press)
  String _selectedDictionary = "";
  
  /// The theme which the application will use.
  /// System will match the settings of the system.
  String _selectedTheme = "";

  ///
  List<String> themesLocaleKeys = [
    LocaleKeys.General_light,
    LocaleKeys.General_dark,
    LocaleKeys.General_system
  ];
  
  /// A Map from the string of a theme to the ThemeMode of the theme.
  Map<String, ThemeMode> themesDict = {
      LocaleKeys.General_light : ThemeMode.light,
      LocaleKeys.General_dark : ThemeMode.dark,
      LocaleKeys.General_system : ThemeMode.system
    };

  /// Should the behavior of long and short press be inverted
  bool _invertShortLongPress = false;

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool _emptyCanvasAfterDoubleTap = true;

  /// should the default app browser be used for opening predictions or a webview
  bool _useWebview = true;

  // ADVANCED SETTINGS
  /// The available backends for inference
  List<String> inferenceBackends= [
      InferenceBackends.CPU.name.toString(),
    ];

  /// The inference backend used for the single character CNN
  String _backendCNNSingleChar = "";

  /// use a thanos like snap effect to dissolve the drawing from the screen
  bool _useThanosSnap = false;



  Settings() {
    kanjiPlaceholder;

    web_dictionaries = [
      "jisho (web)",
      "wadoku (web)",
      "weblio (web)",
      "url"
    ];

    dictionaries.addAll(web_dictionaries);
    
    if(Platform.isAndroid)
      dictionaries.addAll([
        "system (app",
        "aedict (app)",
        "akebi (app)",
        "takoboto (app)", 
      ]);
    else if(Platform.isIOS)
      dictionaries.addAll([
        "shirabe jisho (app)",
        "imiwa? (app)",
        "Japanese (app)",
        "midori (app)",
      ]);

    if(Platform.isAndroid)
      inferenceBackends.addAll([
        InferenceBackends.GPU.toString(),
        InferenceBackends.NNAPI.toString(),
      ]);
    //else if(Platform.isIOS)
    //  inferenceBackends.addAll([
    //    InferenceBackends.GPU.toString(),
    //    InferenceBackends.CoreML.toString(),
    //  ]);
    //else if(Platform.isLinux || Platform.isMacOS || Platform.isWindows)
    //  inferenceBackends.addAll([
    //    InferenceBackends.XXNPACK.toString()
    //  ]);

    jishoURL = "https://www.jisho.org/search/" + kanjiPlaceholder;
    wadokuURL = "https://www.wadoku.de/search/" + kanjiPlaceholder;
    weblioURL = "https://www.weblio.jp/content/" + kanjiPlaceholder;

    load();
    save();
  }

  String get selectedDictionary{
    return _selectedDictionary;
  }

  set selectedDictionary(String newDictionary){
    _selectedDictionary = newDictionary;
    notifyListeners();
  }

  set selectedTheme(String newTheme){
    _selectedTheme = newTheme;
    notifyListeners();
  }
  
  bool get invertShortLongPress{
    return _invertShortLongPress;
  }

  set invertShortLongPress(bool invert){
    _invertShortLongPress = invert;
    notifyListeners();
  }

  bool get emptyCanvasAfterDoubleTap{
    return _emptyCanvasAfterDoubleTap;
  }
  
  set emptyCanvasAfterDoubleTap(bool empty){
    _emptyCanvasAfterDoubleTap = empty;
    notifyListeners();
  }
  
  bool get useWebview{
    return _useWebview;
  }
  
  set useWebview(bool empty){
    _useWebview = empty;
    notifyListeners();
  }

  // MISC SETTINGS
  String get selectedTheme{
    return _selectedTheme;
  }

  ThemeMode? selectedThemeMode() {
    return themesDict[_selectedTheme];
  }
  
  // ADVANCED SETTINGS
  String get backendCNNSingleChar{
    return _backendCNNSingleChar;
  }

  set backendCNNSingleChar(String newBackend){
    _backendCNNSingleChar = newBackend;
    notifyListeners();
  }

  bool get useThanosSnap{
    return _useThanosSnap;
  }

  set useThanosSnap(bool newValue){
    _useThanosSnap = newValue;
    notifyListeners();
  }


  /// Saves all settings to the SharedPreferences.
  void save() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // set value in shared preferences

    // drawing screen
    prefs.setString('selectedDictionary', selectedDictionary);
    prefs.setString('customURL', customURL);
    prefs.setBool('invertShortLongPress', invertShortLongPress);
    prefs.setBool('emptyCanvasAfterDoubleTap', emptyCanvasAfterDoubleTap);
    prefs.setBool('useWebview', useWebview);

    // misc
    prefs.setString('selectedTheme', _selectedTheme);
    
    // advanced settings
    prefs.setString('backendCNNSingleChar', backendCNNSingleChar);
    prefs.setBool('useThanosSnap', useThanosSnap);
  }

  /// Load all saved settings from SharedPreferences.
  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // drawing screen
    selectedDictionary = prefs.getString('selectedDictionary') ?? dictionaries[0];
    customURL = prefs.getString('customURL') ?? '';
    invertShortLongPress = prefs.getBool('invertShortLongPress') ?? false;
    emptyCanvasAfterDoubleTap = prefs.getBool('emptyCanvasAfterDoubleTap') ?? false;
    useWebview = prefs.getBool('useWebview') ?? false;
    
    // misc
    _selectedTheme = prefs.getString('selectedTheme') ?? themesLocaleKeys[2];

    // advanced settings
    backendCNNSingleChar = prefs.getString("backendCNNSingleChar") ?? '';
    useThanosSnap = prefs.getBool('useThanosSnap') ?? false;
  }
}

