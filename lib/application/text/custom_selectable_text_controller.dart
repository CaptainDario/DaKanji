import 'package:flutter/material.dart';



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
  final void Function() updateSelection;


  CustomSelectableTextController({
    required this.updateSelection
  });

  /// Moves the current selection to the next word
  /// If `expandBy > 0`, the current selection will expanded by the
  /// by `expandBy` amount of characters.
  /// If `extendByOneWord == true` the selection will be expanded by the next
  /// word.
  void selectNext({
    bool selectNextToken = false,
    bool selectNextChar = false,
    bool extendByOneToken = false,
    int extendBy = 0}){

    assert ((selectNextToken && !selectNextChar && !extendByOneToken && extendBy == 0) ||
      (!selectNextToken && selectNextChar && !extendByOneToken && extendBy == 0) ||
      (!selectNextToken && !selectNextChar && extendByOneToken && extendBy == 0) ||
      (!selectNextToken && !selectNextChar && !extendByOneToken && extendBy > 0));

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
          if(extendByOneToken){
            currentSelection = TextSelection(
              baseOffset: currentSelection.baseOffset,
              extentOffset: cnt + words[i].runes.length + words[i+1].runes.length
            );
          }
          // extent the current selection by one character
          else if(extendBy > 0){
            currentSelection = TextSelection(
              baseOffset: currentSelection.baseOffset,
              extentOffset: currentSelection.extentOffset + 1
            );
          }
          else{
            // select the next token
            if(selectNextToken) {
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
          }
        }
        break;
      }
      cnt += words[i].length;
    }

    updateSelection();
  }

  /// Moves the current selection to the previous word
  void selectPrevious(){

    int cnt = 0;
    for (int i = 0; i < words.length; i++){

      if(cnt == currentSelection.baseOffset){
        // first word
        if(i-1 == -1){
          int len = words.join().runes.length;
          currentSelection = TextSelection(
            baseOffset: len - words.last.runes.length,
            extentOffset: len
          );
        }
        else{
          currentSelection = TextSelection(
            baseOffset: cnt - words[i-1].runes.length,
            extentOffset: cnt,
          );
        }
        break;
      }
      cnt += words[i].length;
    }

    updateSelection();
  }

  /// Shrinks the current selection by `shrinkBy` number of characters.
  /// If `shrinkBy == 0` removes the last token from the selection
  void shrinkSelection(int shrinkBy){

    assert (shrinkBy >= 0);

    // shrink selection by fixed amount
    if(shrinkBy > 0){
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
            selectPrevious();
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

    updateSelection();
  }

}