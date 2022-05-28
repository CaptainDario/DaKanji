import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/helper/HandlePredictions.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';


/// A button which shows the given [char].
/// 
/// It can copy [char] to the clipboard or open it in a dictionary.
class PredictionButton extends StatefulWidget {

  /// the character which is shown in this button
  final String char;
  ///
  final int nr;

  PredictionButton(
    this.char,
    this.nr,
  {Key? key}) : super(key: key);
  
  @override
  _PredictionButtonState createState() => _PredictionButtonState();
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
    animation = new Tween(
      begin: 1.0,
      end: 1.05,
    ).animate(new CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));

    // run the animation always reversed after completion 
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed)
        controller.reverse();
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

        onDoubleTap: () {
          if(widget.char == " ") return;

          controller.forward(from: 0.0);
          if(GetIt.I<Settings>().emptyCanvasAfterDoubleTap)
            GetIt.I<DrawScreenState>().strokes.playDeleteAllStrokesAnimation = true; 
          GetIt.I<DrawScreenState>().kanjiBuffer.addToKanjiBuffer(widget.char);
        },

        child: KeyBoardShortcuts(
          keysToPress: GetIt.I<Settings>().settingsDrawing.kbPreds[widget.nr],
          onKeysPressed: () => pressed(),
          child: KeyBoardShortcuts(
            keysToPress: GetIt.I<Settings>().settingsDrawing.kbLongPressMod
              ..addAll(
                GetIt.I<Settings>().settingsDrawing.kbPreds[widget.nr]
              ),
            onKeysPressed: () => longPressed(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
              ),
              // handle a short press
              onPressed: () => pressed(),
              // handle a long press 
              onLongPress: () => longPressed(),
              child: FittedBox(
                child: Text(
                  widget.char,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 600,
                    fontFamily: "NotoSans"
                  ),
                )
              )
            ),
          ),
        )
      )
    );
  }

  void longPressed(){
    GetIt.I<DrawScreenState>().drawingLookup.setChar(widget.char, longPress: true);
    handlePress(context);
  }

  void pressed(){
    GetIt.I<DrawScreenState>().drawingLookup.setChar(widget.char);
    handlePress(context);
  }
}
