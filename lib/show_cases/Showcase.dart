import 'package:flutter/material.dart';

import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:sizer/sizer.dart';

import 'package:da_kanji_mobile/show_cases/DrawScreenShowcase.dart';



final List<OnboardingStep> steps = [
  OnboardingStep(
    focusNode: drawScreenFocusNodes[0],
    titleText: drawScreenShowcaseTexts[0],
  ),
];