import 'dart:math';

import 'package:da_kanji_mobile/application/text/custom_selectable_text_processing.dart';
import 'package:da_kanji_mobile/application/text/pos.dart';
import 'package:da_kanji_mobile/widgets/helper/conditional_parent_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_flutter.dart';



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

  /// The size of a character of the normal text
  late Size textCharacterSize = getTextSize("口", textScaleFactor);
  /// The size of a ruby character
  late Size rubyCharacterSize = getTextSize("口", rubyScaleFactor);

  MecabTextEditingController({
    this.showRubys = false,
    this.addSpaces = false,
    this.showColors = false,
  });

  List<String> mecabReadings = [];
  List<String> mecabSurfaces = [];
  List<String> mecabPOS = [];
  List<Color?> posColors = [];

  @override
  TextSpan buildTextSpan({
    required BuildContext context, TextStyle? style, required bool withComposing
  }) {

    final res = processText(text, GetIt.I<Mecab>(), GetIt.I<KanaKit>());
    mecabReadings = res.item1;
    mecabSurfaces = res.item2;
    mecabPOS = res.item3;

    posColors = List.generate(mecabPOS.length, (i) => posToColor(mecabPOS[i]));

    List<InlineSpan> children = []; int count = 0;
    for (var i = 0; i < mecabSurfaces.length; i++) {
      int mecabSurStartIdx = count; int mecabSurEndIdx = count+mecabSurfaces[i].length;
      for (var j = 0; j < mecabSurfaces[i].length; j++) {
        
        // proper line breaking
        if (mecabSurfaces[i][j] == '\n') {
          children.add(const TextSpan(text: '\n'));
        }
        else {
          double spacing = addSpaces && (j == mecabSurfaces[i].length-1) ?
            8.0 : 0;

          /// calculate width difference between text and ruby
          double horizontalPadding = 
            ((mecabReadings[i].length*rubyCharacterSize.width) - 
            (mecabSurfaces[i].length*textCharacterSize.width)) / 2;
          horizontalPadding = max(0, horizontalPadding);

          children.add(WidgetSpan(
            child: GestureDetector(
              onTap: () => onSingleTap(mecabSurStartIdx, mecabSurEndIdx),
              // Do nothing on long press so that long press works as placing
              // the cursor
              onLongPress: () {},
              child: Container(
                color: horizontalPadding == 0 ? null : Colors.orange,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    j == 0 ? horizontalPadding : 0,
                    0,
                    (j == mecabSurfaces[i].length-1 ? horizontalPadding : 0) + spacing,
                    0
                  ),
                  // include ruby in this widget if it is either
                  // * the center character in word with uneven length
                  // * first character after half word length 
                  child: ConditionalParentWidget(
                    condition: j == (mecabSurfaces[i].length/2).floor()
                      && mecabReadings[i] != " ",
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
                      mecabSurfaces[i][j]
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
                            size: Size(
                              textCharacterSize.width,
                              0
                            ),
                            // Move the ruby text ...
                            child: Transform.translate(
                              offset: Offset(
                                // ... to the center of the word if the word is
                                // of uneven length
                                mecabSurfaces[i].length%2==0
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
                                mecabReadings[i]
                              ),
                            ),
                          ),
                          child
                        ],
                      );
                    },
                  )
                ),
              ),
            )
          ));
        }
        count += 1;
      }
    }
    print("${text.length} ${count}");
    return TextSpan(
      children: children
    );
  }

  /// Callback that is executed when the user does a single tap
  void onSingleTap(int wordStartIdx, int wordEndIdx) {
    selection = TextSelection(
      baseOffset: wordStartIdx, extentOffset: wordEndIdx);
  }

  /// Callback that is executed when the user does a single tap
  void onDoubleTap(int wordStartIdx, int wordEndIdx) {
    // TODO
    selection = TextSelection(
      baseOffset: wordStartIdx, extentOffset: wordEndIdx);
  }

  /// Callback that is executed when the user does a single tap
  void onTripleTap(int wordStartIdx, int wordEndIdx) {
    // TODO
    selection = TextSelection(
      baseOffset: wordStartIdx, extentOffset: wordEndIdx);
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

