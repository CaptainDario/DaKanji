// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/drawing/drawing_interpreter.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/widgets/drawing/prediction_button.dart';
import 'package:da_kanji_mobile/widgets/widgets/multi_focus.dart';

class DrawScreenPredictionButtons extends StatelessWidget {
  const DrawScreenPredictionButtons(
    this.runningInLandscape,
    this.canvasSize,
    this.includeHeroes,
    this.includeTutorial,
    {super.key}
    );

  /// is the app running in landscape
  final bool runningInLandscape;
  /// the size of the DrawingCanvas
  final double canvasSize;
  /// should the hero widget to animate switching to the webview be included
  final bool includeHeroes;
  /// should the tutorial Focus be included
  final bool includeTutorial;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return SizedBox(              
      //use canvas height when runningInLandscape
      width :  runningInLandscape ? (canvasSize * 0.4) : canvasSize,
      height: !runningInLandscape ? (canvasSize * 0.4) : canvasSize, 
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawingInterpreter>(),
        child: Consumer<DrawingInterpreter>(
          builder: (context, interpreter, child){
            return Focus(
              focusNode: includeTutorial ?
                GetIt.I<Tutorials>().drawScreenTutorial.predictionButtonGridSteps : null,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: runningInLandscape ? Axis.horizontal : Axis.vertical,
                crossAxisCount: 5,
                mainAxisSpacing: (width*0.01).clamp(0, 5),
                crossAxisSpacing: (width*0.01).clamp(0, 5),
                
                children: List.generate(10, (i) {
                  Widget tmpWidget = PredictionButton(
                    interpreter.predictions[i],
                    i
                  );
                  // add short/long press tutorial to the first button
                  if(i == 0) {
                    tmpWidget = MultiFocus(
                      focusNodes: includeTutorial ? 
                        GetIt.I<Tutorials>().drawScreenTutorial.predictionbuttonSteps : null,
                      child: tmpWidget,
                    );
                  }
                  
                  if(includeHeroes) {
                    tmpWidget = Hero(
                      tag: "webviewHero_${(interpreter.predictions[i] == " " 
                        ? i.toString() 
                        : interpreter.predictions[i])}",
                      child: tmpWidget,
                    );
                  }
            
                  return tmpWidget;
                },
                )
              ),
            );
          }
        ),
      )
    );
  }
}
