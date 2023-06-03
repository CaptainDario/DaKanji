import 'package:flutter/material.dart';

import 'package:onboarding_overlay/onboarding_overlay.dart';



abstract class Tutorial {

  /// all header texts of this tutorial
  List<String>? titles;
  /// all body texts of this tutorial
  List<String>? bodies;
  /// all indexes of this tutorial
  List<int>? indexes;
  /// all FocusNode of this tutorial
  List<FocusNode>? focusNodes;
  /// all OnBoardingStep of this tutorial
  List<OnboardingStep>? steps;

  

  /// Initializes this tutorial, should be called after `tutorialTitles` and
  /// `tutorialBodies` has been initialized
  void initTutorial(){

    if(titles == null){
      throw "`tutorialTitles` needs to be initialized";
    }
    if(bodies == null){
      throw "`tutorialBodies` needs to be initialized";
    }

    indexes = List.generate(
      bodies!.length, (index) => index);

    focusNodes = 
      List.generate(indexes!.length, (index) => FocusNode());

    steps = List.generate(indexes!.length, (index) => 
      OnboardingStep(
        focusNode: focusNodes![index], 
        titleText: titles![index],
        bodyText: bodies![index]
      )
    );
  }
}