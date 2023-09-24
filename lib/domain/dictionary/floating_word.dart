// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';

/// Bundles the information of a floating word entry of `FloatingWordsEntry`
class FloatingWord {

  /// Dicitonary entry of this word
  JMdict entry;
  /// 
  get entryString {
    return entry.kanjis.isNotEmpty ? entry.kanjis.first : entry.readings.first;
  }
  /// Splits either the first kanji or reading of `entry` so that it is a vertical
  /// text
  get entryVerticalString {

    String word = (entry.kanjis.isNotEmpty ? entry.kanjis.first : entry.readings.first);
  
    word = word.replaceAll("ー", "｜");

    if (word.runes.length > 1) {
      word = word.toString().split("").join("\n");
    }

    return word;
  }
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
