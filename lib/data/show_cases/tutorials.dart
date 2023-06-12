

import 'package:da_kanji_mobile/data/show_cases/clipboard_screen_tutorial.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/data/show_cases/text_screen_tutorial.dart';
import 'package:da_kanji_mobile/data/show_cases/dictionary_screen_tutorial.dart';
import 'package:da_kanji_mobile/data/show_cases/draw_screen_tutorial.dart';



class Tutorials{

  /// the draw screen tutorial
  late DrawScreenTutorial drawScreenTutorial;
  /// the dictionary screen tutorial
  late DictionaryScreenTutorial dictionaryScreenTutorial;
  /// the text screen tutorial
  late TextScreenTutorial textScreenTutorial;
  /// the clipoard screen tutorial
  late ClipboardScreenTutorial clipboardScreenTutorial;



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
  }

  List<OnboardingStep> getSteps (){
    return drawScreenTutorial.steps! +
      dictionaryScreenTutorial.steps! +
      textScreenTutorial.steps! + 
      clipboardScreenTutorial.steps!;
  }
}