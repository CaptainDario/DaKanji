import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:da_kanji_mobile/show_cases/DrawScreenTutorial.dart';



class Tutorials{

  /// the draw screen tutorial
  late DrawScreenTutorial drawScreenTutorial;

  Tutorials(){}

  /// Reloads the all tutorials
  void reload(){
    this.drawScreenTutorial = DrawScreenTutorial();
  }

  List<OnboardingStep> getSteps (){
    return this.drawScreenTutorial.drawScreenTutorialSteps;
  }
}