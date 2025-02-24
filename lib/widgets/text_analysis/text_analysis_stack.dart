// Flutter imports:
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/text_analysis/text_analysis_popup.dart';
import 'package:provider/provider.dart';

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
  /// Callback that is executed when the text analysis stack is initialized
  /// Provides:
  /// * the [TabController] to control the tabs of the popup
  /// as parameters
  final Function(TabController tabController)? onPopupInitialized;

  const TextAnalysisStack(
    {
      required this.children,
      required this.textToAnalyze,
      required this.poupAnimationController,
      required this.constraints,
      this.allowDeconjugation=true,
      this.padding = 8.0,
      this.onPopupInitialized,
      super.key
    }
  );

  @override
  State<TextAnalysisStack> createState() => _TextAnalysisStackState();
}

class _TextAnalysisStackState extends State<TextAnalysisStack> with TickerProviderStateMixin{

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
  void initState() {

    // read the last popup settings from disk
    popupPositionLeft = context.read<Settings>().text.windowPosX.toDouble();
    popupPositionTop  = context.read<Settings>().text.windowPosY.toDouble();
    popupSizeWidth    = context.read<Settings>().text.windowWidth.toDouble();
    popupSizeHeight   = context.read<Settings>().text.windowHeight.toDouble();

    super.initState();
  
  }

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
                    allowDeconjugation: widget.allowDeconjugation,
                    onInitialized: (controller) {
                      widget.onPopupInitialized?.call(controller);
                    },
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

                      // save current popup window position
                      context.read<Settings>().text.windowPosX = popupPositionLeft.toInt();
                      context.read<Settings>().text.windowPosY = popupPositionTop.toInt();
                      context.read<Settings>().save();
                      
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

                      // save current popup window size
                      context.read<Settings>().text.windowHeight = popupSizeHeight.toInt();
                      context.read<Settings>().text.windowWidth  = popupSizeWidth.toInt();
                      context.read<Settings>().save();
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
