import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/locales_keys.dart';


List<String> drawScreenTutorialTitles = [
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

List<String> drawScreenTutorialBodies = [
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

final List<int> drawScreenTutorialIndexes = List.generate(
  drawScreenTutorialFocusNodes.length, (index) => index);

final List<FocusNode> drawScreenTutorialFocusNodes = 
  List.generate(drawScreenTutorialTitles.length, (index) => FocusNode());

final List<OnboardingStep> drawScreenTutorialSteps = 
  List.generate(drawScreenTutorialTitles.length, (index) => 
    OnboardingStep(
      focusNode: drawScreenTutorialFocusNodes[index], 
      titleText: drawScreenTutorialTitles[index],
      bodyText: drawScreenTutorialBodies[index]
    )
  );

