

import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


/// Class to represent one widget which should be shown during the showcase.
/// 
/// [key] is the `GlobalKey` of the widget which should be showcased. [title]
/// defines the name of this showcase element and [text] the instructions
/// the user will see. Finally [align] defines on which side [text] should
/// be shown relative to the showcased widget.
class ShowcaseTuple {

  /// The key of the widget to showcase
  GlobalKey key;
  /// The title of the showcase
  String title;
  /// The text which should be shown to the user
  String text;
  /// Where should the text should be placed relative to the showcased widget.
  ContentAlign align;


  ShowcaseTuple(GlobalKey key, String title, String text, ContentAlign align){
    this.key = key;
    this.title = title;
    this.text = text;
    this.align = align;
  }
}