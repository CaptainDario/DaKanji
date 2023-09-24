import 'package:flutter/cupertino.dart';


import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';

part 'settings_drawing.g.dart';



/// Class to store all settings in the drawing settings 
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsDrawing with ChangeNotifier  {

  /// The placeholder in the URL's which will be replaced by the predicted kanji
  @JsonKey(includeFromJson: false, includeToJson: false)
  static const String kanjiPlaceholder = "%X%";

  /// The URL of the jisho website
  @JsonKey(includeFromJson: false, includeToJson: false)
  String jishoURL = "https://www.jisho.org/search/$kanjiPlaceholder";

  /// The URL of the weblio website
  @JsonKey(includeFromJson: false, includeToJson: false)
  String wadokuURL = "https://www.wadoku.de/search/$kanjiPlaceholder";

  /// The URL of the weblio website
  @JsonKey(includeFromJson: false, includeToJson: false)
  late String weblioURL = "https://www.weblio.jp/content/$kanjiPlaceholder";
  
  /// A list with all web dictionaries
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> webDictionaries = [
    "jisho (web)",
    "wadoku (web)",
    "weblio (web)",
    "url"
  ];

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> androidDictionaries = [
    "system (app)",
    "aedict (app)",
    "akebi (app)",
    "takoboto (app)", 
  ];

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> iosDictionaries = [
    "shirabe jisho (app)",
    "imiwa? (app)",
    "Japanese (app)",
    "midori (app)",
  ];

  /// A list with all available dictionary options.
  @JsonKey(includeFromJson: false, includeToJson: false)
  late List<String> dictionaries;

  /// Identifier for the inbuilt dictionary
  @JsonKey(includeFromJson: false, includeToJson: false)
  String inbuiltDictId = "DaKanji";

  /// The default value for `customURL`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const d_customURL = "https://www.jisho.org/search/$kanjiPlaceholder";
  /// The custom URL a user can define on the settings page.
  @JsonKey(defaultValue: d_customURL)
  String _customURL = d_customURL;
  /// The custom URL a user can define on the settings page.
  String get customURL => _customURL;
  /// The custom URL a user can define on the settings page.
  set customURL(String customURL) {
    _customURL = customURL;
    notifyListeners();
  }

  /// The string representation of the dictionary which will be used (long press)
  @JsonKey(defaultValue: "DaKanji")
  String _selectedDictionary = "DaKanji";
  /// The string representation of the dictionary which will be used (long press)
  String get selectedDictionary => _selectedDictionary;
  /// The string representation of the dictionary which will be used (long press)
  set selectedDictionary(String selectedDictionary) {
    _selectedDictionary = selectedDictionary;
    notifyListeners();
  }

  /// Should the behavior of long and short press be inverted
  @JsonKey(defaultValue: false)
  bool _invertShortLongPress = false;
  /// Should the behavior of long and short press be inverted
  bool get invertShortLongPress => _invertShortLongPress;
  /// Should the behavior of long and short press be inverted
  set invertShortLongPress(bool invertShortLongPress) {
    _invertShortLongPress = invertShortLongPress;
    notifyListeners();
  }

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  @JsonKey(defaultValue: true)
  bool _emptyCanvasAfterDoubleTap = true;
  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool get emptyCanvasAfterDoubleTap => _emptyCanvasAfterDoubleTap;
  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  set emptyCanvasAfterDoubleTap(bool emptyCanvasAfterDoubleTap) {
    _emptyCanvasAfterDoubleTap = emptyCanvasAfterDoubleTap;
    notifyListeners();
  }

  /// should the default app browser be used for opening predictions or a webview
  @JsonKey(defaultValue: false)
  bool _useWebview = false;
  /// should the default app browser be used for opening predictions or a webview
  bool get useWebview => _useWebview;
  /// should the default app browser be used for opening predictions or a webview
  set useWebview(bool useWebview) {
    _useWebview = useWebview;
    notifyListeners();
  }


  SettingsDrawing (){

    dictionaries = [inbuiltDictId] + List.from(webDictionaries);

    if(Platform.isAndroid) {
      dictionaries.addAll(androidDictionaries);
    } else if(Platform.isIOS) {
      dictionaries.addAll(iosDictionaries);
    }
  }

  /// Instantiates a new instance from a json map
  factory SettingsDrawing.fromJson(Map<String, dynamic> json) 
    => _$SettingsDrawingFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsDrawingToJson(this);
}