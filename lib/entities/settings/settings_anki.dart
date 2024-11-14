// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';

part 'settings_anki.g.dart';



/// Class to store all settings related to the anki integration
/// 
/// To update the toJson code run `flutter pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class SettingsAnki with ChangeNotifier {

  /// The default value for `defaultDeck`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const String? d_defaultDeck = null;
  /// When creating a new note, the deck to add the card to by default
  @JsonKey(defaultValue: d_defaultDeck)
  String? _defaultDeck = d_defaultDeck;
  /// When creating a new note, the deck to add the card to by default
  String? get defaultDeck => _defaultDeck;
  /// When creating a new note, the deck to add the card to by default
  set defaultDeck(String? value) {
    _defaultDeck = value;
    notifyListeners();
  }

  /// The default value for `allowDuplicates`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_allowDuplicates = false;
  /// When sending a note to anki, should duplicates be allowed
  @JsonKey(defaultValue: d_allowDuplicates)
  bool _allowDuplicates = d_allowDuplicates;
  /// When sending a note to anki, should duplicates be allowed
  bool get allowDuplicates => _allowDuplicates;
  /// When sending a note to anki, should duplicates be allowed
  set allowDuplicates(bool value) {
    _allowDuplicates = value;
    notifyListeners();
  }

  /// All decks currently in anki
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> availableDecks = [];

  /// When creating a new note, which languages should be included
  @JsonKey(defaultValue: [true])
  List<bool> _includedLanguages = [true];
  /// When creating a new note, which languages should be included
  List<bool> get includedLanguages => _includedLanguages;
  /// When creating a new note, which languages should be included
  set includedLanguages(List<bool> value) {
    _includedLanguages = value;
    notifyListeners();
  }
  void setIncludeLanguagesItem(bool value, int index){
    _includedLanguages[index] = value;
    notifyListeners();
  }
  /// Based on the given `selectedTranslationLanguages` (the languages selected
  /// in the dictionary) returns the languages that should be included when
  /// exporting a word list
  List<String> langsToInclude (List<String> selectedTranslationLanguages) => 
    selectedTranslationLanguages
      .whereIndexed((index, element) => includedLanguages[index])
      .map((e) => isoToiso639_2B[e]!.name)
      .toList();

  /// The default value for `noTranslations`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_noTranslations = 3;
  /// When creating a new note, how many translations should be included
  @JsonKey(defaultValue: d_noTranslations)
  int _noTranslations = d_noTranslations;
  /// When creating a new note, how many translations should be included
  int get noTranslations => _noTranslations;
  /// When creating a new note, how many translations should be included
  set noTranslations(int value) {
    _noTranslations = value;
    notifyListeners();
  }

  /// The default value for `desktopAnkiUri`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const String d_desktopAnkiURL = "localhost:8765";
  /// The URL to connect to anki desktop
  @JsonKey(defaultValue: d_desktopAnkiURL)
  String _desktopAnkiURL = d_desktopAnkiURL;
  /// The URL to connect to anki desktop
  String get desktopAnkiURL => _desktopAnkiURL;
  /// The URL to connect to anki desktop
  set desktopAnkiURL(String value) {
    _desktopAnkiURL = value;
    notifyListeners();
  }
  /// The URL to connect to anki desktop
  Uri get desktopAnkiUri => Uri.http(Uri.encodeFull(_desktopAnkiURL));

  /// The default value for `noTranslations`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const int d_noExamples = 1;
  /// When creating a new note, how many examples should be included
  @JsonKey(defaultValue: d_noTranslations)
  int _noExamples = d_noExamples;
  /// When creating a new note, how many examples should be included
  int get noExamples => _noExamples;
  /// When creating a new note, how many examples should be included
  set noExamples(int value) {
    _noExamples = value;
    notifyListeners();
  }
  
  /// The default value for `includeExampleTranslations`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_includeExampleTranslations = false;
  /// When creating a new note, should the examples translations be included
  @JsonKey(defaultValue: d_includeGoogleImage)
  bool _includeExampleTranslations = d_includeExampleTranslations;
  /// When creating a new note, should the examples translations be included
  bool get includeExampleTranslations => _includeExampleTranslations;
  /// When creating a new note, should the examples translations be included
  set includeExampleTranslations(bool value) {
    _includeExampleTranslations = value;
    notifyListeners();
  }

  /// The default value for `includeGoogleImage`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_includeGoogleImage = false;
  /// When creating a new note, download and include a google image of the vocabulary
  @JsonKey(defaultValue: d_includeGoogleImage)
  bool _includeGoogleImage = d_includeGoogleImage;
  /// When creating a new note, download and include a google image of the vocabulary
  bool get includeGoogleImage => _includeGoogleImage;
  /// When creating a new note, download and include a google image of the vocabulary
  set includeGoogleImage(bool value) {
    _includeGoogleImage = value;
    notifyListeners();
  }

  /// The default value for `includeAudio`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_includeAudio = false;
  /// should an audio file be downloaded and included in the card
  @JsonKey(defaultValue: d_includeAudio)
  bool _includeAudio = d_includeAudio;
  /// should an audio file be downloaded and included in the card
  bool get includeAudio => _includeAudio;
  /// should an audio file be downloaded and included in the card
  set includeAudio(bool value) {
    _includeAudio = value;
    notifyListeners();
  }

  
  /// The default value for `includeScreenshot`
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: constant_identifier_names
  static const bool d_includeScreenshot = false;
  /// Include a screenshot of the current screen in the card
  @JsonKey(defaultValue: d_includeScreenshot)
  bool _includeScreenshot = d_includeScreenshot;
  /// Include a screenshot of the current screen in the card
  bool get includeScreenshot => _includeScreenshot;
  /// Include a screenshot of the current screen in the card
  set includeScreenshot(bool value) {
    _includeScreenshot = value;
    notifyListeners();
  }


  SettingsAnki();

  /// Instantiates a new instance from a json map
  factory SettingsAnki.fromJson(Map<String, dynamic> json) => _$SettingsAnkiFromJson(json);

  /// Create a JSON map from this object
  Map<String, dynamic> toJson() => _$SettingsAnkiToJson(this);
}
