

// Package imports:
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/clipboard_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/dictionary_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/dojg_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/draw_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/kana_table_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/kanji_map_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/kanji_table_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/text_screen_tutorial.dart';
import 'package:da_kanji_mobile/entities/show_cases/word_lists_screen_tutorial.dart';

class Tutorials{

  /// the draw screen tutorial
  late DrawScreenTutorial drawScreenTutorial;
  /// the dictionary screen tutorial
  late DictionaryScreenTutorial dictionaryScreenTutorial;
  /// the text screen tutorial
  late TextScreenTutorial textScreenTutorial;
  /// the dojg screen tutorial
  late DojgScreenTutorial dojgScreenTutorial;
  /// the clipoard screen tutorial
  late ClipboardScreenTutorial clipboardScreenTutorial;
  /// the kanji table screen tutorial
  late KanjiTableScreenTutorial kanjiTableScreenTutorial;
  /// the kanji map screen tutorial
  late KanjiMapScreenTutorial kanjiMapScreenTutorial;
  /// the kana table screen tutorial
  late KanaTableScreenTutorial kanaTableScreenTutorial;
  /// the word lists screen tutorial
  late WordListsScreenTutorial wordListsScreenTutorial;



  Tutorials();

  /// Reloads the all tutorials
  void reload(){
    drawScreenTutorial = DrawScreenTutorial();

    dictionaryScreenTutorial = DictionaryScreenTutorial();
    dictionaryScreenTutorial.indexes = dictionaryScreenTutorial.indexes!.map(
      (e) => e + drawScreenTutorial.indexes!.last + 1
    ).toList();

    textScreenTutorial = TextScreenTutorial();
    textScreenTutorial.indexes = textScreenTutorial.indexes!.map(
      (e) => e + dictionaryScreenTutorial.indexes!.last + 1
    ).toList();

    clipboardScreenTutorial = ClipboardScreenTutorial();
    clipboardScreenTutorial.indexes = clipboardScreenTutorial.indexes!.map(
      (e) => e + textScreenTutorial.indexes!.last + 1
    ).toList();

    kanjiTableScreenTutorial = KanjiTableScreenTutorial();
    kanjiTableScreenTutorial.indexes = kanjiTableScreenTutorial.indexes!.map(
      (e) => e + clipboardScreenTutorial.indexes!.last + 1
    ).toList();

    kanjiMapScreenTutorial = KanjiMapScreenTutorial();
    kanjiMapScreenTutorial.indexes = kanjiMapScreenTutorial.indexes!.map(
      (e) => e + kanjiTableScreenTutorial.indexes!.last + 1
    ).toList();

    kanaTableScreenTutorial = KanaTableScreenTutorial();
    kanaTableScreenTutorial.indexes = kanaTableScreenTutorial.indexes!.map(
      (e) => e + kanjiMapScreenTutorial.indexes!.last + 1
    ).toList();

    wordListsScreenTutorial = WordListsScreenTutorial();
    wordListsScreenTutorial.indexes = wordListsScreenTutorial.indexes!.map(
      (e) => e + kanaTableScreenTutorial.indexes!.last + 1
    ).toList();

    dojgScreenTutorial = DojgScreenTutorial();
    dojgScreenTutorial.indexes = dojgScreenTutorial.indexes!.map(
      (e) => e + wordListsScreenTutorial.indexes!.last + 1
    ).toList();
  }

  List<OnboardingStep> getSteps (){
    return drawScreenTutorial.steps! +
      dictionaryScreenTutorial.steps! +
      textScreenTutorial.steps! + 
      clipboardScreenTutorial.steps! +
      kanjiTableScreenTutorial.steps! +
      kanjiMapScreenTutorial.steps! +
      kanaTableScreenTutorial.steps! +
      wordListsScreenTutorial.steps! + 
      dojgScreenTutorial.steps!;
  }
}
