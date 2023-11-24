// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorial.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

class DrawScreenTutorial extends Tutorial {

  /// all tutorial steps which belong to ...
  /// ... the multiCharSearch
  late List<FocusNode> multiCharSearchSteps;
  /// ... the grid of PredictionButton-s
  late FocusNode predictionButtonGridSteps;
  /// ... a PredictionButton
  late List<FocusNode> predictionbuttonSteps;
  /// ... the undo button
  late FocusNode undoButtonSteps;
  /// ... the delete button
  late FocusNode clearButtonSteps;
  /// ... the DrawingCanvas
  late FocusNode canvasSteps;



  DrawScreenTutorial() {
    
    titles = [
      LocaleKeys.DrawScreen_tutorial_begin_title.tr(),
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
      "",
      "",
      "",
    ];
  
    bodies = [
      LocaleKeys.DrawScreen_tutorial_begin_text.tr(),
      LocaleKeys.DrawScreen_tutorial_drawing.tr(),
      LocaleKeys.DrawScreen_tutorial_undo.tr(),
      LocaleKeys.DrawScreen_tutorial_clear.tr(),
      LocaleKeys.DrawScreen_tutorial_predictions.tr(),
      LocaleKeys.DrawScreen_tutorial_short_press_prediction.tr(),
      LocaleKeys.DrawScreen_tutorial_long_press_prediction.tr(),
      LocaleKeys.DrawScreen_tutorial_dictionary_settings.tr(),
      LocaleKeys.DrawScreen_tutorial_multi_search.tr(),
      LocaleKeys.DrawScreen_tutorial_double_tap_prediction.tr(),
      LocaleKeys.DrawScreen_tutorial_multi_search_short_press.tr(),
      LocaleKeys.DrawScreen_tutorial_multi_search_long_press.tr(),
      LocaleKeys.DrawScreen_tutorial_multi_search_double_tap.tr(),
      LocaleKeys.DrawScreen_tutorial_multi_search_swipe_left.tr(),
    ];

    initTutorial();
  
    /// get the different parts of the tutorial
    multiCharSearchSteps = 
      [focusNodes![8]] + focusNodes!.sublist(10, 14);

    predictionbuttonSteps = focusNodes!.sublist(5, 8) + 
      [focusNodes![9]];

    predictionButtonGridSteps = focusNodes![4];

    undoButtonSteps = focusNodes![2];
    
    clearButtonSteps = focusNodes![3];
    
    canvasSteps = focusNodes![1];
  }
}
