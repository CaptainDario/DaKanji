import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class TextScreenTutorial extends Tutorial {

  /// all tutorial steps that beolng to the TextScreen
  late FocusNode textInputSteps;
  late FocusNode processedTextSteps;
  late FocusNode spacesButtonSteps;
  late FocusNode furiganaSteps;
  late FocusNode colorButtonSteps;
  late FocusNode fullscreenSteps;

  TextScreenTutorial() {
    titles = [
      LocaleKeys.TextScreen_tutorial_begin_title.tr(),
      "",
      "",
      "",
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.TextScreen_tutorial_begin_text.tr(),
      LocaleKeys.TextScreen_tutorial_text_input_text.tr(),
      LocaleKeys.TextScreen_tutorial_processed_text_text.tr(),
      LocaleKeys.TextScreen_tutorial_spaces_text.tr(),
      LocaleKeys.TextScreen_tutorial_furigana_text.tr(),
      LocaleKeys.TextScreen_tutorial_colors_text.tr(),
      LocaleKeys.TextScreen_tutorial_fullscreen_text.tr(),
    ];
    initTutorial();

    /// get the different parts of the tutorial
    textInputSteps = focusNodes![1];
    processedTextSteps = focusNodes![2];
    spacesButtonSteps = focusNodes![3];
    furiganaSteps = focusNodes![4];
    colorButtonSteps = focusNodes![5];
    fullscreenSteps = focusNodes![6];
  } 

}
