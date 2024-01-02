// Package imports:
import 'package:collection/collection.dart';

/// Represents a DaKanji-style Anki note
class AnkiNote{

  /// The name of the deck to add the note to
  String deckName;
  /// The card type of this note, always "DaKanji"
  final String _cardType = "DaKanji";
  /// The card type of this note, always "DaKanji"
  get cardType => _cardType;
  List<String> tags = [];
  
  /// All translations of the note
  List<String> translations = [];
  /// All Kanjis of the entry
  List<String> kanji = [];
  /// All Kana of the entry
  List<String> kana = [];

  /// A google Image of the entry
  String googleImage = "";
  /// An audio of the entry
  String audio = "";
  /// If watching a series / playing a game a screenshot
  String encounteredImage = "";

  /// All fields of the note
  Map get fields => {
    "Translations"     : translations.mapIndexed((index, value) => "$index. $value").join("\n"),
    "Japanese"         : kanji.mapIndexed((index, value) => "$index. $value").join("<br>"),
    "Kana"             : kana.mapIndexed((index, value) => "$index. $value").join("<br>"),
    "GoogleImage"      : googleImage,
    "Audio"            : audio,
    "EncounteredImage" : encounteredImage
  };


  /// Creates a new note with the given values
  AnkiNote(this.deckName, this.translations, this.kanji,
    this.googleImage, this.audio, this.encounteredImage);

  /// Creates a new note with testing values
  AnkiNote.testNote() :
    deckName = "DaKanji testing",
    tags = ["DaKanji", "testing"],

    translations = ["apple", "banana", "orange"],
    kanji = ["来", "林檎"],
    kana = ["くる", "りんご"],
    
    googleImage = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
    audio = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
    encounteredImage = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png";

}
