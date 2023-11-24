// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class TextScreenTutorial extends Tutorial {

  // All tutorial steps that belong to the TextScreen
  late FocusNode textInputSteps;
  late List<FocusNode> processedTextSteps;
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
      "",
      "",
      "",
      "",
    ];
    bodies = [
      LocaleKeys.TextScreen_tutorial_begin_text.tr(),
      LocaleKeys.TextScreen_tutorial_text_input_text.tr(),
      LocaleKeys.TextScreen_tutorial_processed_text_text.tr(),
      LocaleKeys.TextScreen_tutorial_processed_text_tap.tr(),
      LocaleKeys.TextScreen_tutorial_processed_text_long_press.tr(),
      LocaleKeys.TextScreen_tutorial_processed_text_double_tap.tr(),
      LocaleKeys.TextScreen_tutorial_processed_text_triple_tap.tr(),
      LocaleKeys.TextScreen_tutorial_spaces_text.tr(),
      LocaleKeys.TextScreen_tutorial_furigana_text.tr(),
      LocaleKeys.TextScreen_tutorial_colors_text.tr(),
      LocaleKeys.TextScreen_tutorial_fullscreen_text.tr(),
    ];
    
    initTutorial();

    /// get the different parts of the tutorial
    textInputSteps = focusNodes![1];
    processedTextSteps = focusNodes!.sublist(2, 7);
    spacesButtonSteps = focusNodes![7];
    furiganaSteps = focusNodes![8];
    colorButtonSteps = focusNodes![9];
    fullscreenSteps = focusNodes![10];
  } 

}
