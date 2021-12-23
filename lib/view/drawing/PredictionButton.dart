import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/model/helper/HandlePredictions.dart';
import 'package:da_kanji_mobile/provider/Lookup.dart';
import 'package:da_kanji_mobile/provider/KanjiBuffer.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/provider/Strokes.dart';


/// A button which shows the given [char].
/// 
/// It can copy [char] to the clipboard or open it in a dictionary.
class PredictionButton extends StatefulWidget {

  
  final String char;
  PredictionButton (this.char);
  
  @override
  _PredictionButtonState createState() => _PredictionButtonState();
}

class _PredictionButtonState extends State<PredictionButton>
  with TickerProviderStateMixin{
    
  AnimationController controller;
  Animation<double> animation;

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
          controller.forward(from: 0.0);
          if(GetIt.I<Settings>().emptyCanvasAfterDoubleTap)
            GetIt.I<Strokes>().playDeleteAllStrokesAnimation = true; 
          GetIt.I<KanjiBuffer>().addToKanjiBuffer(widget.char);
        },

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
          ),
          // handle a short press
          onPressed: () {
            GetIt.I<Lookup>().setChar(widget.char);
            HandlePrediction().handlePress(context);
          },
          // handle a long press 
          onLongPress: () async {
            GetIt.I<Lookup>().setChar(widget.char, longPress: true);
            HandlePrediction().handlePress(context);
          },
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
        )
      )
    );
  }
}
