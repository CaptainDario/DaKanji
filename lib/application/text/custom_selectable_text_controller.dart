// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/application/helper/japanese_text_processing.dart';

/// Controller for the `CustomSelectableText`-widget to control the widget from
/// outside itself.
class CustomSelectableTextController {

  /// the current split of ruby texts, this is used because when a text breaks
  /// lines in a word the rubys need to be split
  List<String> rubys = [];
  /// a list of all words
  List<String> words = [];

  /// The current text selection
  TextSelection currentSelection = const TextSelection.collapsed(offset: -1);

  /// Callback that should update the current selection graphics
  final void Function() updateSelectionGraphics;


  CustomSelectableTextController({
    required this.updateSelectionGraphics
  });


  /// Get the current text selection in text format
  String getCurrentSelectionString() {
    if(currentSelection.isCollapsed){
      return "";
    }

    return words.join().substring(
      currentSelection.baseOffset,
      currentSelection.extentOffset
    );
  }

  /// Resets the current selection to an empty one
  void resetSelection() {

    currentSelection = const TextSelection.collapsed(offset: -1);

  }

  /// Moves the current selection to the next token
  /// If `nextChar == true` selects the next character instead
  void selectNext({bool nextChar = false}){

    int cnt = 0;
    for (int i = 0; i < words.length; i++){

      if((cnt <= currentSelection.extentOffset &&
        currentSelection.extentOffset <= cnt+words[i].runes.length) ||
        currentSelection.extentOffset <= cnt){

        // last word
        if(i+1 == words.length){
          currentSelection = TextSelection(
            baseOffset: 0,
            extentOffset: words[0].runes.length
          );
        }

        // skip punctuation
        else if(japaneseCharacterRegex.hasMatch(words[i+1])){
          // select the next token
          if(!nextChar) {
            currentSelection = TextSelection(
              baseOffset: cnt + words[i].runes.length,
              extentOffset: cnt + words[i].runes.length + words[i+1].runes.length
            );
          }
          // select the next character
          else {
            currentSelection = TextSelection(
              baseOffset: currentSelection.extentOffset,
              extentOffset: currentSelection.extentOffset + 1
            );
          }
          break;
        }
      }
      cnt += words[i].runes.length;
    }

    updateSelectionGraphics();
  }

  /// Moves the current selection to the previous token
  /// If `previousChar == true` selects the previous character instead
  void selectPrevious({bool previousChar = false}){

    int cnt = words.join("").runes.length;
    for (int i = words.length-1; i >= 0; i--){

      if((cnt <= currentSelection.extentOffset &&
        currentSelection.extentOffset <= cnt-words[i].runes.length) ||
        cnt <= currentSelection.baseOffset){
        // first word
        if(i-1 == -1){
          int len = words.join().runes.length;
          currentSelection = TextSelection(
            baseOffset: len - words.last.runes.length,
            extentOffset: len
          );
        }
        else if(japaneseCharacterRegex.hasMatch(words[i])){
          if(previousChar){
            currentSelection = TextSelection(
              baseOffset: currentSelection.baseOffset-1,
              extentOffset: currentSelection.baseOffset
            );
          }
          else {
            currentSelection = TextSelection(
              baseOffset: cnt - words[i].runes.length,
              extentOffset: cnt,
            );
          }
          break;
        }
      }
      cnt -= words[i].runes.length;
      
    }

    updateSelectionGraphics();
  }

  /// Shrinks the current selection by `shrinkBy` number of characters, from the
  /// right side.
  /// If `shrinkBy == 0` removes the last token from the selection
  void shrinkSelectionRight(int shrinkBy){

    assert (shrinkBy >= 0);

    // shrink selection by fixed amount
    if(shrinkBy > 0 && currentSelection.extentOffset - currentSelection.baseOffset > 1){
      currentSelection = TextSelection(
        baseOffset: currentSelection.baseOffset,
        extentOffset: currentSelection.extentOffset - shrinkBy
      );
    }
    // shrink selection by words
    else{
      int cnt = 0;
      for (int i = 0; i < words.length; i++){

        if(cnt >= currentSelection.extentOffset){
          // the selection only contains one word -> select previous word
          if (currentSelection.baseOffset == cnt - words[i-1].runes.length) {
            // do not go to end of text
            if(currentSelection.baseOffset == 0) return;

            selectPrevious(previousChar: shrinkBy > 0);
          }
          else {
            // the selection contains multiple words -> shrink selection by one word
            currentSelection = TextSelection(
              baseOffset: currentSelection.baseOffset,
              extentOffset: cnt - words[i-1].runes.length
            );
          }
          break;
        }
        cnt += words[i].length;
      }
    }

    updateSelectionGraphics();
  }

  /// Grows the current selection by `growBy` number of characters, to the
  /// right side.
  /// If `shrinkBy == 0` extends by one token
  void growSelectionRight({int growBy = 0}){

    assert (growBy >= 0);

    // assure there is a token to select
    if(currentSelection.extentOffset == words.join("").length) return;

    int cnt = 0;
    for (int i = 0; i < words.length; i++){

      if(cnt <= currentSelection.extentOffset &&
        currentSelection.extentOffset <= cnt+words[i].runes.length){
        // last word
        if(i+1 == words.length){
          currentSelection = TextSelection(
            baseOffset: 0,
            extentOffset: words[0].runes.length
          );
        }
        else{
          // extent the current selection by one word
          if(growBy == 0){
            currentSelection = TextSelection(
              baseOffset: currentSelection.baseOffset,
              extentOffset: cnt + words[i].runes.length +
                (currentSelection.extentOffset == cnt + words[i].runes.length
                  ? words[i+1].runes.length
                  : 0)
            );
          }
          // extent the current selection by one character
          else if(growBy > 0){
            currentSelection = TextSelection(
              baseOffset: currentSelection.baseOffset,
              extentOffset: currentSelection.extentOffset + growBy
            );
          }
        }
        break;
      }
      cnt += words[i].length;
      
    }

    updateSelectionGraphics();
  }
}
