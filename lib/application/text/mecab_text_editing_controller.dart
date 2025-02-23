// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_flutter.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/furigana_matching.dart';
import 'package:da_kanji_mobile/application/japanese_text_processing/japanese_string_operations.dart';
import 'package:da_kanji_mobile/application/japanese_text_processing/mecab_data.dart';
import 'package:da_kanji_mobile/application/text/custom_selectable_text_processing.dart';
import 'package:da_kanji_mobile/widgets/helper/conditional_parent_widget.dart';

/// [TextEditingController] that can show rubys over Japanese text and also
/// colorize words based on their PoS based on analysis of MeCab
class MecabTextEditingController extends TextEditingController {


  /// should the rubys be shown or not
  bool showRubys;
  /// should spaces be added to the text between words
  bool addSpaces;
  /// should the text be rendered in colors matching the POS
  bool showColors;

  /// callback that should be executed when the currently selected text chagnes
  /// provides the current `TextSelection` as parameter
  final void Function(TextSelection)? onSelectionChange;
  /// callback that is executed when a single tap is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onTap;
  /// callbach that is executed when a long press is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onLongPress;
  /// callback that is executed when a double tap is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onDoubleTap;
  /// callback that is executed when a triple tap is executed on the text
  /// provides the `TextSelection` where the tap appeared as parameter
  final void Function(TextSelection)? onTripleTap;

  MecabTextEditingController({
    this.showRubys = false,
    this.addSpaces = false,
    this.showColors = false,

    this.onSelectionChange,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onTripleTap,
  });
  
  @override
  set selection(TextSelection newSelection){
    if(super.selection != newSelection){
      super.selection = newSelection;
      _onSelectionChange();
    }
  }

  /// factor by which the text is scaled
  static double textScaleFactor = 1.4;
  /// factor by which the rubys are scaled
  static double rubyScaleFactor = 0.8;

  /// Size between 'words' when the user enables spaces
  double spacingSize = 8.0;
  /// Spacing that is added when a furigana reading is to wide for its word
  double furiganaNotFitSpacing = 2.0;

  /// The size of a character of the normal text
  late Size textCharacterSize = getTextSize("口", textScaleFactor);
  /// The size of a ruby character
  late Size rubyCharacterSize = getTextSize("口", rubyScaleFactor);

  /// The mecab readings of the current text
  List<String> mecabReadings = [];
  /// The mecab surfaces of the current text
  List<String> mecabSurfaces = [];
  /// the PoS of the current text
  List<String> mecabPOS = [];
  /// Coloring of 
  List<Color?> posColors = [];

  /// All [InlineSpan]s that are currently rendered
  List<InlineSpan> children = [];
  /// The text that was used to build this text last time
  String lastText = "";

  /// When did the last tap happen
  int lastTap = DateTime.now().millisecondsSinceEpoch;
  /// How many consecutive taps happend
  int consecutiveTaps = 0;

  @override
  TextSpan buildTextSpan({
    required BuildContext context, TextStyle? style, required bool withComposing
  }) {

    final res = processText(text, GetIt.I<Mecab>(), GetIt.I<KanaKit>());
    mecabReadings = res.item1;
    mecabSurfaces = res.item2;
    mecabPOS = res.item3;

    posColors = List.generate(mecabPOS.length, (i) => posToColor(mecabPOS[i]));
    
    children = []; int count = 0;
    for (var i = 0; i < mecabSurfaces.length; i++) {
      int mecabSurStartIdx = count; int mecabSurEndIdx = count+mecabSurfaces[i].length;
      List<FuriganaPair> furiganaPairs =  
        matchFurigana(mecabSurfaces[i], mecabReadings[i]);

      /// The index for the current character in `mecabSurfaces`'s second-dim
      int mecabSurfaceIdx = 0;
      for (var k = 0; k < furiganaPairs.length; k++) {
        String chars = furiganaPairs[k].kanji != ""
          ? furiganaPairs[k].kanji
          : furiganaPairs[k].reading;
        for (var j = 0; j < chars.length; j++) {
          // proper line breaking
          if (mecabSurfaces[i][mecabSurfaceIdx]=='\n'){
            children.add(const TextSpan(text:'\n'));
          }
          else {
            String furigana = furiganaPairs[k].kanji != ""
              ? furiganaPairs[k].reading : " ";
            double spacing = (j == chars.length-1 && k == furiganaPairs.length-1)
              && addSpaces ? spacingSize : 0;

            /// calculate width difference between text and ruby
            double horizontalPadding = 0;
            if(showRubys){
              // check if ruby is wider than text
              horizontalPadding = ((mecabReadings[i].length*rubyCharacterSize.width) - 
              (mecabSurfaces[i].length*textCharacterSize.width)) / 2;
              // add some small spacing to the width to assure better visual separation
              horizontalPadding = max(0, horizontalPadding+furiganaNotFitSpacing);
            }

            children.add(WidgetSpan(
              child: GestureDetector(
                onTapDown: (details)  {
                  int now = DateTime.now().millisecondsSinceEpoch;
                  if (now - lastTap > 300) {
                    consecutiveTaps = 1;
                    lastTap = now;
                  }  
                  else {
                    consecutiveTaps++;
                  }
                  if(consecutiveTaps == 1) {
                    _onSingleTap(mecabSurStartIdx, mecabSurEndIdx);
                  }
                  else if(consecutiveTaps == 2) {
                    _onDoubleTap(mecabSurStartIdx, mecabSurEndIdx);
                  }
                  else if (consecutiveTaps == 3){
                    _onTripleTap(mecabSurStartIdx, mecabSurEndIdx);
                  }
                },
                // Do nothing on long press so that long press works as placing
                // the cursor
                onLongPress: () => _onLongPress(mecabSurStartIdx, mecabSurEndIdx),
                //onSecondaryLongPress: ,
                child: Padding(
                  // add a small space after too wide furigana to make them 
                  // easier to separate visually
                  padding: EdgeInsets.fromLTRB(
                    j == 0 ? horizontalPadding : 0,
                    0,
                    (j == mecabSurfaces[i].length-1
                      ? horizontalPadding : 0) + spacing,
                    0
                  ),
                  // include ruby in this widget if it is either
                  // * the center character in word with uneven length
                  // * first character after half word length 
                  // and the ruby option is enabled
                  child: ConditionalParentWidget(
                    condition: furigana != " " && 
                      j == (furiganaPairs[k].kanji.length/2).floor()
                      && showRubys
                      ,
                    // the main text
                    child: Text(
                      textScaler: TextScaler.linear(textScaleFactor),
                      style: TextStyle(
                        color: showColors ? posColors[i] : null
                      ),
                      strutStyle: const StrutStyle(
                        forceStrutHeight: true, 
                        leading: 0, // No extra spacing
                      ),
                      mecabSurfaces[i][mecabSurfaceIdx]
                    ),
                    conditionalBuilder: (child) {
                      // Column to render the text and the ruby
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Set the width of the ruby to the width of the actual
                          // text so that there is no spacing 'inside' a word
                          // But also let the ruby overflow the width 
                          SizedOverflowBox(
                            size: Size(textCharacterSize.width, 0),
                            // Move the ruby text ...
                            child: Transform.translate(
                              offset: Offset(
                                // ... to the center of the word if the word is
                                // of uneven length
                                furiganaPairs[k].kanji.length%2==0
                                  ? (-textCharacterSize.width/2)
                                  : 0,
                                // ... to the top of the text
                                -rubyCharacterSize.height/2
                              ),
                              child: Text(
                                textScaler: TextScaler.linear(rubyScaleFactor),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.visible,
                                furigana
                              ),
                            ),
                          ),
                          child
                        ],
                      );
                    },
                  )
                ),
              )
            ));
          }
          count++; mecabSurfaceIdx++;
        }
      }
    }

    return TextSpan(children: children);
  }

  /// Callback that is executed when the selection changes
  void _onSelectionChange(){

    onSelectionChange?.call(selection);

  }

  /// Callback that is executed when the user does a long press
  void _onLongPress(int wordStartIdx, int wordEndIdx) {

    onLongPress?.call(selection);

  }

  /// Callback that is executed when the user does a single tap
  void _onSingleTap(int wordStartIdx, int wordEndIdx) {

    selection = TextSelection(
      baseOffset: wordStartIdx, extentOffset: wordEndIdx);
    onTap?.call(selection);

  }

  /// Callback that is executed when the user does a single tap
  void _onDoubleTap(int wordStartIdx, int wordEndIdx) {

    for (var match in sentenceRegex.allMatches(text)) {
      if (match.start <= wordStartIdx && wordStartIdx <= match.end) {
        selection = TextSelection(
          baseOffset: match.start, 
          extentOffset: match.end
        );
        break;
      }
    }
    onDoubleTap?.call(selection);

  }

  /// Callback that is executed when the user does a single tap
  void _onTripleTap(int wordStartIdx, int wordEndIdx) {

    for (var match in paragraphRegex.allMatches(text)) {
      if (match.start <= wordStartIdx && wordStartIdx <= match.end) {
        selection = TextSelection(
          baseOffset: match.start, extentOffset: match.end-1);
        break;
      }
    }
    onTripleTap?.call(selection);

  }

  /// Returns the index of the token in `mecabSurfaces` that is at position 
  /// `textIndex` in `text`
  /// if `textIndex` is not in `mecabSurfaces.length` returns -1
  int getTokenAtTextIndex(int textIndex){

    int tokenLength = 0;
    for (var i = 0; i < mecabSurfaces.length; i++) {
      if(tokenLength <= textIndex &&
        textIndex <= tokenLength + mecabSurfaces[i].length){
        return i;
      }
      tokenLength += mecabSurfaces[i].length;
    }

    return -1;

  }

  /// Returns a [Tuple2] with
  ///   * item1 - the start index of the selection
  ///   * item2 - the end index of the selections
  Tuple2<int, int> getStartAndEnd(){
    return Tuple2(
      min(selection.baseOffset, selection.extentOffset),
      max(selection.baseOffset, selection.extentOffset)
    );
  }

  /// Modifies the selection by `noTokens`.
  /// Positive values grow the selecton and negative values shrink it.
  /// 
  /// Notes:
  ///   * one token corresponds to one mecab surface
  ///   * 
  void modifySelectionByTokens(int noTokens){

    // do not move
    if(noTokens == 0 ) return;

    Tuple2 pos = getStartAndEnd();
    int currentTokenIdx = getTokenAtTextIndex(pos.item2)+1;
    int targetTokenIdx  = currentTokenIdx + noTokens;

    // set maximum selection if target is longer than the text
    if(targetTokenIdx > mecabSurfaces.length) targetTokenIdx = mecabSurfaces.length;

    // get the string by which the selection should be modified
    String modifyBy = mecabSurfaces.sublist(
      noTokens < 0 ? targetTokenIdx : currentTokenIdx,
      noTokens > 0 ? targetTokenIdx : currentTokenIdx,
    ).join();
    int modifyByLen = (noTokens > 0 ? 1 : -1) * modifyBy.length;

    // if shrinking the selection by more than its current size, move to prev.
    // token
    if(modifyBy.length > pos.item2-pos.item1 && modifyByLen < 0){
      moveSelectionByTokens(-1);
      return;
    }

    selection = selection.copyWith(
      baseOffset: null, extentOffset: pos.item2+modifyByLen);
    
  }

  /// Modifies the current selection by `noChars`.
  /// Positive values grow the selecton and negative values shrink it.
  void modifySelectionByCharacters(int noChars){

    // do not move
    if(noChars == 0) return;

    Tuple2<int, int> pos = getStartAndEnd();

    // if the selection only contains one character, move it by one
    if(pos.item2 - pos.item1 == 1){
      // if at the beginning wrap around
      if(pos.item1 == 0 && noChars < 0){
        selection = selection.copyWith(
          baseOffset: text.length-1, extentOffset: text.length);
      }
      // else move to the previous one
      else {
        selection = selection.copyWith(
          baseOffset: pos.item1-1, extentOffset: pos.item1);
      }
      return;
    }

    // set maximum selection if target is longer than the text
    if(pos.item2+noChars > text.length) noChars = text.length - pos.item2;

    selection = selection.copyWith(
      extentOffset: pos.item2+noChars);
  }

  /// Moves the current selection by `noTokens`.
  /// Positive values grow the selecton and negative values shrink it.
  /// 
  /// Notes:
  ///   * one token corresponds to one mecab surface
  void moveSelectionByTokens(int noTokens){

    // do not move
    if(noTokens == 0) return;

    // Check where the selection currently is and if moving for- or backwards
    Tuple2 pos = getStartAndEnd();

    int idxTargetToken = getTokenAtTextIndex(pos.item2) + noTokens;
    int lenTargetToken = mecabSurfaces[idxTargetToken].length;
    int targetTokenStart = mecabSurfaces.sublist(0, idxTargetToken).join().length;

    selection = selection.copyWith(
      baseOffset: targetTokenStart, extentOffset: targetTokenStart+lenTargetToken
    );

  }

  /// Moves the current selection by `noChars`.
  /// Positive values grow the selecton and negative values shrink it.
  void moveSelectionByCharacters(int noChars){

    // do not move
    if(noChars == 0) return;

    // Check where the selection currently is and if moving for- or backwards
    Tuple2 pos = getStartAndEnd();
    int moveFrom = noChars > 0 ? pos.item2 : pos.item1+1;

    // if moving 'before' the text, move selection to the end
    if(pos.item1 == 0 && noChars < 0) moveFrom = text.length+1;
    // if moving 'past' the text, move selection to the beginning
    if(pos.item2 == text.length && noChars > 0) moveFrom = 0;

    // move the selection
    selection = selection.copyWith(
      baseOffset  : moveFrom+(noChars-1), extentOffset: moveFrom+noChars);

  }

  /// Calculates the size of the given text using the given scale
  Size getTextSize(String text, double textScaleFactor) {
    return (TextPainter(
      text: TextSpan(
        text: text,
      ),
      textScaler: TextScaler.linear(textScaleFactor),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout()).size;
  }

}
