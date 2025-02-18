// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_flutter.dart';

// Project imports:
import 'package:da_kanji_mobile/application/japanese_text_processing/furigana_matching.dart';
import 'package:da_kanji_mobile/application/japanese_text_processing/japanese_string_operations.dart';
import 'package:da_kanji_mobile/application/text/custom_selectable_text_processing.dart';
import 'package:da_kanji_mobile/application/text/pos.dart';
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

  MecabTextEditingController({
    this.showRubys = false,
    this.addSpaces = false,
    this.showColors = false,
  });

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

  int lastTap = DateTime.now().millisecondsSinceEpoch;
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
                    onSingleTap(mecabSurStartIdx, mecabSurEndIdx);
                  }
                  else if(consecutiveTaps == 2) {
                    onDoubleTap(mecabSurStartIdx, mecabSurEndIdx);
                  }
                  else if (consecutiveTaps == 3){
                    onTripleTap(mecabSurStartIdx, mecabSurEndIdx);
                  }
                },
                // Do nothing on long press so that long press works as placing
                // the cursor
                onLongPress: () {},
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

  /// Callback that is executed when the user does a single tap
  void onSingleTap(int wordStartIdx, int wordEndIdx) {
    selection = TextSelection(
      baseOffset: wordStartIdx, extentOffset: wordEndIdx);
  }

  /// Callback that is executed when the user does a single tap
  void onDoubleTap(int wordStartIdx, int wordEndIdx) {
    for (var match in sentenceRegex.allMatches(text)) {
      if (match.start <= wordStartIdx && wordStartIdx <= match.end) {
        selection = TextSelection(
          baseOffset: match.start, 
          extentOffset: match.end
        );
        break;
      }
    }
  }

  /// Callback that is executed when the user does a single tap
  void onTripleTap(int wordStartIdx, int wordEndIdx) {
    for (var match in paragraphRegex.allMatches(text)) {
      if (match.start <= wordStartIdx && wordStartIdx <= match.end) {
        selection = TextSelection(
          baseOffset: match.start, extentOffset: match.end-1);
        break;
      }
    }
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
