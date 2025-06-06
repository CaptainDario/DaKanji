// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:da_kanji_mobile/application/drawing/handle_predictions.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_state.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';

/// A button which shows the given [char].
/// 
/// It can copy [char] to the clipboard or open it in a dictionary.
class PredictionButton extends StatefulWidget {

  /// the character which is shown in this button
  final String char;
  /// the nr of this PrdictionButton [0..9]
  final int nr;

  const PredictionButton(
    this.char,
    this.nr,
  {super.key});
  
  @override
  State<PredictionButton> createState() => _PredictionButtonState();
}

class _PredictionButtonState extends State<PredictionButton>
  with TickerProviderStateMixin{
    
  late AnimationController controller;
  late Animation<double> animation;

  

  void anim(){
   controller.forward(from: 0.0); 
  }

  @override
  void initState() { 
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animation = Tween(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));

    // run the animation always reversed after completion 
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      }
    });

  }

  @override
  void dispose() { 
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: () => doubleTap(),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
          // handle a short press
          onPressed: pressed,
          // handle a long press 
          onLongPress: () => longPressed(),
          child: FittedBox(
            child: Text(
              widget.char,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 600,
                fontFamily: g_japaneseFontFamily,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
              ),
            )
          )
        )
      )
    );
  }

  void doubleTap(){
    if(widget.char == " ") return;

    controller.forward(from: 0.0);
    if(GetIt.I<Settings>().drawing.emptyCanvasAfterDoubleTap) {
      GetIt.I<DrawScreenState>().strokes.playDeleteAllStrokesAnimation = true;
    } 

    GetIt.I<DrawScreenState>().kanjiBuffer.addToKanjiBuffer(widget.char);
  
  }

  void longPressed(){
    debugPrint("longPressed");
    GetIt.I<DrawScreenState>().drawingLookup.setChar(widget.char, longPress: true);
    handlePress(context);
  }

  void pressed(){
    debugPrint("pressed");
    GetIt.I<DrawScreenState>().drawingLookup.setChar(widget.char);
    handlePress(context);
  }
}
