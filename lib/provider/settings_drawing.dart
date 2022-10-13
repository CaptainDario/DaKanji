import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:universal_io/io.dart';

import 'package:da_kanji_mobile/model/DrawScreen/logical_keyboard_key_converter.dart';
part 'settings_drawing.g.dart';



/// Class to store all settings in the drawing settings 
/// 
/// To update the toJson code run `flutter pub run build_runner build`
@JsonSerializable()
class SettingsDrawing with ChangeNotifier  {

  /// The placeholder in the URL's which will be replaced by the predicted kanji
  @JsonKey(ignore: true)
  final String kanjiPlaceholder = "%X%";

  /// The URL of the jisho website
  @JsonKey(ignore: true)
  late String jishoURL;

  /// The URL of the weblio website
  @JsonKey(ignore: true)
  late String wadokuURL;

  /// The URL of the weblio website
  @JsonKey(ignore: true)
  late String weblioURL;
  
  /// A list with all web dictionaries
  @JsonKey(ignore: true)
  List<String> webDictionaries = [
    "jisho (web)",
    "wadoku (web)",
    "weblio (web)",
    "url"
  ];

  @JsonKey(ignore: true)
  List<String> androidDictionaries = [
    "system (app)",
    "aedict (app)",
    "akebi (app)",
    "takoboto (app)", 
  ];

  @JsonKey(ignore: true)
  List<String> iosDictionaries = [
    "shirabe jisho (app)",
    "imiwa? (app)",
    "Japanese (app)",
    "midori (app)",
  ];

  /// A list with all available dictionary options.
  @JsonKey(ignore: true)
  late List<String> dictionaries;

  /// Identifier for the inbuilt dictionary
  @JsonKey(ignore: true)
  String inbuiltDictId = "inbuilt";

  /// The custom URL a user can define on the settings page.
  String _customURL = "";
  /// The custom URL a user can define on the settings page.
  String get customURL => _customURL;
  /// The custom URL a user can define on the settings page.
  set customURL(String customURL) {
    _customURL = customURL;
    notifyListeners();
  }

  /// The string representation of the dictionary which will be used (long press)
  late String _selectedDictionary;
  /// The string representation of the dictionary which will be used (long press)
  String get selectedDictionary => _selectedDictionary;
  /// The string representation of the dictionary which will be used (long press)
  set selectedDictionary(String selectedDictionary) {
    _selectedDictionary = selectedDictionary;
    notifyListeners();
  }

  /// Should the behavior of long and short press be inverted
  bool _invertShortLongPress = false;
  /// Should the behavior of long and short press be inverted
  bool get invertShortLongPress => _invertShortLongPress;
  /// Should the behavior of long and short press be inverted
  set invertShortLongPress(bool invertShortLongPress) {
    _invertShortLongPress = invertShortLongPress;
    notifyListeners();
  }

  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool _emptyCanvasAfterDoubleTap = true;
  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  bool get emptyCanvasAfterDoubleTap => _emptyCanvasAfterDoubleTap;
  /// Should the canvas be cleared when a prediction was copied to kanjibuffer
  set emptyCanvasAfterDoubleTap(bool emptyCanvasAfterDoubleTap) {
    _emptyCanvasAfterDoubleTap = emptyCanvasAfterDoubleTap;
    notifyListeners();
  }

  /// should the default app browser be used for opening predictions or a webview
  bool _useWebview = false;
  /// should the default app browser be used for opening predictions or a webview
  bool get useWebview => _useWebview;
  /// should the default app browser be used for opening predictions or a webview
  set useWebview(bool useWebview) {
    _useWebview = useWebview;
    notifyListeners();
  }

  // KEY BINDING (kb)
  /// default key binding for modifying a normal press to a long press
  @JsonKey(ignore: true)
  final Set<LogicalKeyboardKey> kbLongPressModDefault = {LogicalKeyboardKey.keyN};
  /// current key binding for modifying a normal press to a long press
  @LogicalKeyboardKeyConverter()
  late Set<LogicalKeyboardKey> kbLongPressMod;
  /// default key binding for modifying a normal press to a double press
  @JsonKey(ignore: true)
  final Set<LogicalKeyboardKey> kbDoublePressModDefault = {LogicalKeyboardKey.keyM};
  /// current key binding for modifying a normal press to a double press
  @LogicalKeyboardKeyConverter()
  late Set<LogicalKeyboardKey> kbDoublePressMod;

  /// default key binding for clearing the canvas
  @JsonKey(ignore: true)
  final Set<LogicalKeyboardKey> kbClearCanvasDefault = {LogicalKeyboardKey.keyD};
  /// key binding for clearing the canvas
  @LogicalKeyboardKeyConverter()
  late Set<LogicalKeyboardKey> kbClearCanvas;
  /// default key binding for clearing the canvas
  @JsonKey(ignore: true)
  final Set<LogicalKeyboardKey> kbUndoStrokeDefault = {LogicalKeyboardKey.keyU};
  /// current key binding for clearing the canvas
  @LogicalKeyboardKeyConverter()
  late Set<LogicalKeyboardKey> kbUndoStroke;
  /// default key binding for tapping the word bar
  @JsonKey(ignore: true)
  final Set<LogicalKeyboardKey> kbWordBarDefault = {LogicalKeyboardKey.keyW};
  /// current key binding for tapping the wordbar
  @LogicalKeyboardKeyConverter()
  late Set<LogicalKeyboardKey> kbWordBar;
  /// default key binding forn1 deleting a character from the word bar
  @JsonKey(ignore: true)
  final Set<LogicalKeyboardKey> kbWordBarDelCharDefault = {LogicalKeyboardKey.keyE};
  /// current key binding for deleting a character from the word bar
  @LogicalKeyboardKeyConverter()
  late Set<LogicalKeyboardKey> kbWordBarDelChar = kbWordBarDelCharDefault;

  /// default key binding for tapping the 0 .. 10 prediction button
  @JsonKey(ignore: true)
  final List<Set<LogicalKeyboardKey>> kbPredsDefaults = [
    {LogicalKeyboardKey.digit1}, {LogicalKeyboardKey.digit2},
    {LogicalKeyboardKey.digit3}, {LogicalKeyboardKey.digit4},
    {LogicalKeyboardKey.digit5}, {LogicalKeyboardKey.digit6},
    {LogicalKeyboardKey.digit7}, {LogicalKeyboardKey.digit8},
    {LogicalKeyboardKey.digit9}, {LogicalKeyboardKey.digit0},
  ];
  /// current key binding for tapping the 0 .. 10 prediction button
  @LogicalKeyboardKeyConverter()
  late List<Set<LogicalKeyboardKey>> kbPreds = kbPredsDefaults;
    


  SettingsDrawing (){
    jishoURL = "https://www.jisho.org/search/" + kanjiPlaceholder;
    wadokuURL = "https://www.wadoku.de/search/" + kanjiPlaceholder;
    weblioURL = "https://www.weblio.jp/content/" + kanjiPlaceholder;

    dictionaries = [inbuiltDictId] + List.from(webDictionaries);

    if(Platform.isAndroid) {
      dictionaries.addAll(androidDictionaries);
    } else if(Platform.isIOS) {
      dictionaries.addAll(iosDictionaries);
    }

    selectedDictionary = dictionaries[0];

    // key bindings
    kbLongPressMod   = kbLongPressModDefault;
    kbDoublePressMod = kbDoublePressModDefault;

    kbClearCanvas    = kbClearCanvasDefault;
    kbUndoStroke     = kbUndoStrokeDefault;
    kbWordBar        = kbWordBarDefault;
    kbWordBarDelChar = kbWordBarDelCharDefault;

    kbPreds       = kbPredsDefaults;
  }

  /// Instantiates a new instance from a json map
  factory SettingsDrawing.fromJson(Map<String, dynamic> json) 
    => _$SettingsDrawingFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsDrawingToJson(this);
}