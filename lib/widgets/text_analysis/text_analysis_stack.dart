import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_popup.dart';



/// A widget that shows `TextAnalysisPopup` over its `children`.
class TextAnalysisStack extends StatefulWidget {

  /// A list of children inside this stack
  final List<Widget> children;
  /// The text that should be analyzed in the popup
  final String textToAnalyze;
  /// An animation controller that can be used to open/close the popup
  final AnimationController poupAnimationController;
  /// Padding that should be used around the stack
  final double padding;
  /// BoxConstraints in which the TextAnalysisPopup should be movable
  final BoxConstraints constraints;
  /// Should the text be deconjugated
  final bool allowDeconjugation;

  const TextAnalysisStack(
    {
      required this.children,
      required this.textToAnalyze,
      required this.poupAnimationController,
      required this.constraints,
      this.allowDeconjugation=true,
      this.padding = 8.0,
      super.key
    }
  );

  @override
  State<TextAnalysisStack> createState() => _TextAnalysisStackState();
}

class _TextAnalysisStackState extends State<TextAnalysisStack> {

  /// the distance to the left window border of the popup
  double popupPositionLeft = 0.0;
  /// the distance to the top window border of the popup
  double popupPositionTop = 0.0;
  /// the width of the popup
  late double popupSizeWidth = popupSizeWidthMin;
  /// the height of the popup
  late double popupSizeHeight = popupSizeHeightMin;
  /// the minimal width the popup can be
  double popupSizeWidthMin = 300;
  /// the minimal height the popup can be
  double popupSizeHeightMin = 200;


  @override
  Widget build(BuildContext context) {

    // shrink the popup when making the windower smaller than the popup in ...
    // ... Width
    if(widget.constraints.maxWidth < popupPositionLeft + popupSizeWidth + 2*widget.padding){
      if(popupPositionLeft > 0){
        popupPositionLeft = widget.constraints.maxWidth - popupSizeWidth - 4*widget.padding;
      }
      else{
        popupPositionLeft = 0;
        popupSizeWidth = widget.constraints.maxWidth - 4*widget.padding;
      }
    }
    // ... Height
    if(widget.constraints.maxHeight < popupPositionTop + popupSizeHeight + 2*widget.padding){
      if(popupPositionTop > 0){
        popupPositionTop = widget.constraints.maxHeight - popupSizeHeight - 4*widget.padding;
      }
      else {
        popupPositionTop = 0;
        popupSizeHeight = widget.constraints.maxHeight - 4*widget.padding;
      }
    }


    return SizedBox(
      height: widget.constraints.maxHeight,
      width: widget.constraints.maxWidth,
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Stack(
          children: [
            ...widget.children,
            /// Popup window to show text selection in dict / DeepL
            Positioned(
              width: popupSizeWidth,
              height: popupSizeHeight,
              left: popupPositionLeft,
              top: popupPositionTop,
              child: Listener(
                child: ScaleTransition(
                  scale: widget.poupAnimationController,
                  child: TextAnalysisPopup(
                    text: widget.textToAnalyze,
                    onMovedViaHeader: (event) {
                      setState(() {
                        // assure that the popup is not moved out of view
                        if(popupPositionLeft + event.delta.dx > 0 &&
                          popupPositionLeft + popupSizeWidth + 
                          2*widget.padding + event.delta.dx < widget.constraints.maxWidth) {
                          popupPositionLeft += event.delta.dx;
                        }

                        // assure that the popup is not moved out of view
                        if(popupPositionTop + event.delta.dy > 0 &&
                          popupPositionTop + popupSizeHeight + 
                          2*widget.padding + event.delta.dy < widget.constraints.maxHeight) {
                          popupPositionTop  += event.delta.dy;
                        }
                      });
                    },
                    onResizedViaCorner: (event) {
                      setState(() {
                        // don't allow resizing the popup over the 
                        // window or smaller than the threshold 
                        if(popupSizeWidth + event.delta.dx > popupSizeWidthMin &&
                          popupSizeWidth + event.delta.dx + 2*widget.padding < widget.constraints.maxWidth) {
                          popupSizeWidth += event.delta.dx;
                        }
           
                        // don't allow resizing the popup over the 
                        // window or smaller than the threshold 
                        if(popupSizeHeight + event.delta.dy > popupSizeHeightMin &&
                          popupSizeHeight + event.delta.dy + 2*widget.padding < widget.constraints.maxHeight) {
                          popupSizeHeight += event.delta.dy;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );

  }
}