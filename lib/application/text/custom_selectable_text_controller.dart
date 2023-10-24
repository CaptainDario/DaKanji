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
  /// If expand is set to true, the current selection will expanded by the next
  /// word
  void selectNextWord({bool expand = false}){

    int cnt = 0;
    for (int i = 0; i < words.length; i++){

      if(cnt+words[i].runes.length == currentSelection.extentOffset){
        // last word
        if(i+1 == words.length){
          currentSelection = TextSelection(
            baseOffset: 0,
            extentOffset: words[0].runes.length
          );
        }
        else{
          currentSelection = TextSelection(
            baseOffset: expand
              ? currentSelection.baseOffset
              : cnt + words[i].runes.length,
            extentOffset: cnt + words[i].runes.length + words[i+1].runes.length
          );
        }
        break;
      }
      cnt += words[i].length;
    }

    updateSelection();
  }

  /// Moves the current selection to the previous word
  /// If expand is set to true, the current selection will expanded by the
  /// previous word
  void selectPreviousWord({bool expand = false}){

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
            extentOffset: expand
              ? currentSelection.extentOffset
              : cnt,
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