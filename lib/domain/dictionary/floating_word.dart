import 'dart:math';

import 'package:flutter/material.dart';



/// Bundles the information of a floating word entry of `FloatingWordsEntry`
class FloatingWord {

  /// Dicitonary entry of this word
  String entry;
  /// Position of this word
  Offset position;

  /// Parallax level of this word (range: [0.5, 1.0])
  double parallax;
  /// The animation controller of this entry
  AnimationController animationController;
  /// The animation of this entry
  Animation animation;


  FloatingWord(
    this.entry,
    this.position,
    this.parallax,
    this.animationController,
    this.animation,
  );


}