import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



class DrawScreenTutorial {

  /// all header texts of the DrawScreen tutorial
  late List<String> drawScreenTutorialTitles;
  /// all body texts of the DrawScreen tutorial
  late List<String> drawScreenTutorialBodies;
  /// all indexes of the DrawScreen tutorial steps 
  late List<int> drawScreenTutorialIndexes;
  /// all FocusNode of the DrawScreen tutorial
  late List<FocusNode> drawScreenTutorialFocusNodes;
  /// all OnBoardingStep of the DrawScreen tutorial
  late List<OnboardingStep> drawScreenTutorialSteps;

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
    
    drawScreenTutorialTitles = [
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
  
    drawScreenTutorialBodies = [
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
 
    drawScreenTutorialIndexes = List.generate(
      drawScreenTutorialBodies.length, (index) => index);

    drawScreenTutorialFocusNodes = 
      List.generate(drawScreenTutorialIndexes.length, (index) => FocusNode());

    drawScreenTutorialSteps = 
      List.generate(drawScreenTutorialIndexes.length, (index) => 
        OnboardingStep(
          focusNode: drawScreenTutorialFocusNodes[index], 
          titleText: drawScreenTutorialTitles[index],
          bodyText: drawScreenTutorialBodies[index]
        )
      );
  
    /// init the tutorial steps
    multiCharSearchSteps = 
      [drawScreenTutorialFocusNodes[8]] + drawScreenTutorialFocusNodes.sublist(10, 14);

    predictionbuttonSteps = drawScreenTutorialFocusNodes.sublist(5, 8) + 
      [drawScreenTutorialFocusNodes[9]];

    predictionButtonGridSteps = drawScreenTutorialFocusNodes[4];

    undoButtonSteps = drawScreenTutorialFocusNodes[2];
    
    clearButtonSteps = drawScreenTutorialFocusNodes[3];
    
    canvasSteps = drawScreenTutorialFocusNodes[1];
  }
}
