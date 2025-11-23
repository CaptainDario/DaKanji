


// Flutter imports:
import 'package:flutter/material.dart';

class FloatingWordStackController {

  /// resets this floatingstack to an initial state
  Function reset;
  /// The [AnimationController] for the opacity of the falling words
  AnimationController opacityAnimationController;

  FloatingWordStackController(
    this.reset,
    this.opacityAnimationController
  );

}
