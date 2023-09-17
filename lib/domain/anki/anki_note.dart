// Package imports:
import 'package:collection/collection.dart';

/// Represents a DaKanji-style Anki note
class AnkiNote{

  /// The name of the deck to add the note to
  String deckName;
  /// The card type of this note, always "DaKanji"
  String _cardType = "DaKanji";
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
  String auido = "";
  /// If watching a series / playing a game a screenshot
  String encounteredImage = "";

  /// All fields of the note
  Map get fields => {
    "Translations"     : translations.mapIndexed((index, value) => "$index. $value").join("\n"),
    "Japanese"         : kanji.mapIndexed((index, value) => "$index. $value").join("<br>"),
    "Kana"             : kana.mapIndexed((index, value) => "$index. $value").join("<br>"),
    "GoogleImage"      : googleImage,
    "Audio"            : auido,
    "EncounteredImage" : encounteredImage
  };


  /// Creates a new note with the given values
  AnkiNote(this.deckName, this.translations, this.kanji,
    this.googleImage, this.auido, this.encounteredImage);

  /// Creates a new note with testing values
  AnkiNote.testNote() :
    this.deckName = "DaKanji testing",
    this.tags = ["DaKanji", "testing"],

    this.translations = ["apple", "banana", "orange"],
    this.kanji = ["来", "林檎"],
    this.kana = ["くる", "りんご"],
    
    this.googleImage = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
    this.auido = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
    this.encounteredImage = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png";

}
