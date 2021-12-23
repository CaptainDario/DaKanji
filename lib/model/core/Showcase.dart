import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// An abstract class which 
abstract class Showcase {

  /// The targets (widgets) which should be shown in this showcase
  List<TargetFocus> targets;
  /// The `tutorialCoachMark` instance defining this showcase
  TutorialCoachMark tutorialCoachMark;
  /// was the function `init` called.
  bool __initalized = false;
  /// The color of the vignette highlighting showcased elements.
  Color vignetteColor = Colors.black;


  void init (BuildContext context){

    this.targets = this.initTargets();
    this.tutorialCoachMark = initShowcase(context);
    this.__initalized = true;
  }

  List<TargetFocus> initTargets();

  /// Initializes a `TutorialCoachMark` instance with the attributes of this
  /// showcase
  /// 
  /// @args context - the context used for the page in which this showcase is shown 
  TutorialCoachMark initShowcase(BuildContext context);

  /// 
  TargetFocus createShowcaseTargetFocus(int index);

  /// Shows the showcase this class defines.
  /// 
  /// Caution: Before calling `show`, `init` must have been called.
  void show(){

    // throw an exception when class was not initialized with `init`
    if(!__initalized)
      throw UnimplementedError();

    this.tutorialCoachMark.show();
  }

}