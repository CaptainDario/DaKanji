


import 'dart:convert';

import 'package:universal_io/io.dart';



/// Class to store all settings in the drawing settings 
class SettingsDrawing {

  /// The placeholder in the URL's which will be replaced by the predicted kanji
  final String kanjiPlaceholder = "%X%";

  /// The URL of the jisho website
  late String jishoURL;

  /// The URL of the weblio website
  late String wadokuURL;

  /// The URL of the weblio website
  late String weblioURL;
  
  /// A list with all web dictionaries
  List<String> webDictionaries = [
    "jisho (web)",
    "wadoku (web)",
    "weblio (web)",
    "url"
  ];

  /// A list with all available dictionary options.
  late List<String> dictionaries;



  /// The custom URL a user can define on the settings page.
  String customURL = "";

  /// The string representation of the dictionary which will be used (long press)
  late String selectedDictionary;

  /// Should the behavior of long and short press be inverted
  bool invertShortLongPress = false;

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool emptyCanvasAfterDoubleTap = true;

  /// should the default app browser be used for opening predictions or a webview
  bool useWebview = false;



  SettingsDrawing (){
    jishoURL = "https://www.jisho.org/search/" + kanjiPlaceholder;
    wadokuURL = "https://www.wadoku.de/search/" + kanjiPlaceholder;
    weblioURL = "https://www.weblio.jp/content/" + kanjiPlaceholder;

    dictionaries = webDictionaries;

    if(Platform.isAndroid)
      dictionaries.addAll([
        "system (app)",
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

    selectedDictionary = dictionaries[0];
  }

  void initFromMap(Map<String, dynamic> map){

    customURL                 = map['customURL'];
    selectedDictionary        = map['selectedDictionary'];
    invertShortLongPress      = map['invertShortLongPress'];
    emptyCanvasAfterDoubleTap = map['emptyCanvasAfterDoubleTap'];
    useWebview                = map['useWebview'];
  }

  void initFromJson(String jsonString) =>
    initFromMap(json.decode(jsonString));
  

  Map<String, dynamic> toMap() => {
    'customURL'                 : customURL,
    'selectedDictionary'        : selectedDictionary,
    'invertShortLongPress'      : invertShortLongPress,
    'emptyCanvasAfterDoubleTap' : emptyCanvasAfterDoubleTap,
    'useWebview'                : useWebview,
  };

  String toJson() => json.encode(toMap());

}