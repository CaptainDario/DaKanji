// Dart imports:
import 'dart:math';

// Package imports:
import 'package:collection/collection.dart';
import 'package:database_builder/database_builder.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';

/// Represents a DaKanji-style Anki note
class AnkiNote{

  /// The name of the deck to add the note to
  String deckName;
  /// The card type of this note, always "DaKanji"
  final String _noteType = ankiDataCardModelName;
  /// The card type of this note, always "DaKanji"
  get noteType => _noteType;
  List<String> tags = [];
  
  /// All translations of the note
  Map<String, List<String>> translations;
  /// All Kanjis of the entry
  List<String> kanji = [];
  /// All Kana of the entry
  List<String> kana = [];

  /// Link to open this entry in DaKanji
  String dakanjiLink = "";

  /// A google Image of the entry
  String image = "";
  /// An audio of the entry
  String audio = "";
  /// Example sentence for this card
  String example = "";
  /// Audio of `example`
  String exampleAudio = "";


  /// All fields of the note
  Map get fields {

    // get all langauges and translations
    List<List<String>> translations = []; List<String> langs = [];
    for (MapEntry<String, List<String>> entry in this.translations.entries) {
      translations.add([]);
      langs.add(entry.key);
      for (var i = 0; i < entry.value.length; i++) {
        translations.last.add(entry.value[i]);
      }
    }
    // join translations
    String translation = "";
    for (var i = 0; i < translations.length; i++) {
      // if there is more than 1 language write the language names
      if(langs.length > 1){
        translation += "<div class=\"language\">${isoToLanguage[isoToiso639_2T[langs[i]]]}</div>";
      }
      for (var j = 0; j < translations[i].length; j++){
        translation += "${j+1}: ${translations[i][j]}<br>";
      }
      translation += "<br>";
    }

    return {
      ankiDataFieldTranslation  : translation,
      ankiDataFieldKanji        : kanji.first,
      ankiDataFieldKana         : kana.first,
      ankiDataFieldFrontNote    : "",
      ankiDataFieldBackNote     : "",
      ankiDataFieldDaKanjiLink  : dakanjiLink,
      ankiDataFieldAudio        : audio,
      ankiDataFieldExample      : example,
      ankiDataFieldExampleAudio : exampleAudio,
      ankiDataFieldImage        : image
    };
  }


  /// Creates a new note with the given values
  AnkiNote(
    this.deckName,
    this.translations,
    this.kanji,
    this.kana,
    {
      this.dakanjiLink = "",
      this.audio = "",
      this.example = "",
      this.exampleAudio = "",
      this.image = ""
    }
  );


  /// Creates a new AnkiNote from a JMdict entry
  AnkiNote.fromJMDict(
    this.deckName, JMdict entry,
    {
      required List<String> langsToInclude,
      int translationsPerLang = 3
    }
  )
    : translations = {}
  {

    for (var meaning in entry.meanings) {

      if(!langsToInclude.contains(meaning.language!)) continue;

      translations.putIfAbsent(meaning.language!, () => []);
      List<String> langTrans = meaning.meanings
        .map((e) => e.attributes.whereNotNull().join("; "))
        .toList();
      translations[meaning.language!]!.addAll(
        langTrans.sublist(0, min(translationsPerLang, langTrans.length))
      );
    }
    
    kanji = [entry.kanjis.isNotEmpty ? entry.kanjis.first : ""];
    
    kana = [entry.readings.first];

    dakanjiLink = "dakanji://dictionary?id=${entry.id}";

    //audio = ;

    //example = ;

    //exampleAudio = ;

    //image = ;


  }

}
