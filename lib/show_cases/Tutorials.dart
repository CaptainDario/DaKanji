import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/show_cases/draw_screen_tutorial.dart';



class Tutorials{

  /// the draw screen tutorial
  late DrawScreenTutorial drawScreenTutorial;

  Tutorials();

  /// Reloads the all tutorials
  void reload(){
    drawScreenTutorial = DrawScreenTutorial();
  }

  List<OnboardingStep> getSteps (){
    return drawScreenTutorial.drawScreenTutorialSteps;
  }
}