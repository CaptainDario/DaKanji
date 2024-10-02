// Dart imports:
import 'dart:math';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/repositories/anki/anki_data.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_example_tab.dart';

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
        translation += "${j+1}: ${translations[i][j]}";
        if(j < translations[i].length-1) translation += '<br>';
      }
      if(i < translations.length-1) translation += '<br><br>';
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
      required bool includeExample,
      int translationsPerLang = 3
    }
  )
    : translations = {}
  {

    for (String langCode in langsToInclude) {

      final meanings = entry.meanings.where((e) => e.language == langCode);
      if(meanings.isEmpty) continue;
      final meaning = meanings.first;

      translations.putIfAbsent(meaning.language!, () => []);
      List<String> langTrans = meaning.meanings
        .map((e) => e.attributes.nonNulls.join("; "))
        .toList();
      translations[meaning.language!]!.addAll(
        langTrans.sublist(0, min(translationsPerLang, langTrans.length))
      );
    }
    
    kanji = [entry.kanjis.isNotEmpty ? entry.kanjis.first : ""];
    
    kana = [entry.readings.first];

    dakanjiLink = "dakanji://dictionary?id=${entry.id}";

    //audio = ;

    //exampleAudio = ;

    //image = ;

  }

  /// Searches the examples database for sentences and adds them to this card if
  /// any are found
  Future setExamplesFromDict(
    JMdict entry,
    {
      required List<String> langsToInclude,
      required int numberOfExamples,
      required bool includeTranslations,
    }
  ) async {

    List<ExampleSentence> examples = await searchExamples(
      langsToInclude, entry.kanjis, entry.readings, entry.hiraganas,
      numberOfExamples, GetIt.I<Isars>().examples.directory
    );

    if(examples.isEmpty) return;

    // get the positions where the entry matches the example
    final spans = getMatchSpans(entry, examples);

    example = "";
    for (var i = 0; i < min(numberOfExamples, examples.length); i++) {

      if(examples.length > 1) example += "${i+1}. ";
      
      // set the japanese example
      for (var span in spans[i]) {
        example += examples[i].sentence.replaceRange(span.item1, span.item2,
          "<b>${examples[i].sentence.substring(span.item1, span.item2)}</b>");
      }
      example += "<br>";

      // add the translations
      if(includeTranslations){
        for (var langCode in langsToInclude) {

          final translations = examples[i].translations
            .where((e) => e.language == langCode);
          
          if(translations.isNotEmpty) example += "${translations.first.sentence}\n";

        }
      }

      if(examples.length - 1 != i) example += "<br>";
      
    }

  }

}
