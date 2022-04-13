import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/show_cases/Tutorials.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/view/drawing/PredictionButton.dart';
import 'package:da_kanji_mobile/show_cases/MultiFocus.dart';



class DrawScreenPredictionButtons extends StatelessWidget {
  const DrawScreenPredictionButtons(
    this.runningInLandscape,
    this.canvasSize,
    this.includeHeroes,
    {Key? key}
    ) : super(key: key);

  final bool runningInLandscape;
  final double canvasSize;
  final bool includeHeroes;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Container(              //use canvas height in runningInLandscape
      width :  runningInLandscape ? (canvasSize * 0.4) : canvasSize,
      height: !runningInLandscape ? (canvasSize * 0.4) : canvasSize, 
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawingInterpreter>(),
        child: Consumer<DrawingInterpreter>(
          builder: (context, interpreter, child){
            return Focus(
              focusNode: GetIt.I<Tutorials>().drawScreenTutorial.predictionButtonGridSteps,
              child: GridView.count(
                physics: new NeverScrollableScrollPhysics(),
                scrollDirection: runningInLandscape ? Axis.horizontal : Axis.vertical,
                crossAxisCount: 5,
                mainAxisSpacing: (width*0.01).clamp(0, 5),
                crossAxisSpacing: (width*0.01).clamp(0, 5),
                
                children: List.generate(10, (i) {
                  Widget tmp_widget = PredictionButton(
                    interpreter.predictions[i],
                  );
                  // add short/long press showcase to the first button
                  if(i == 0)
                    tmp_widget = MultiFocus(
                      focusNodes: GetIt.I<Tutorials>().drawScreenTutorial.predictionbuttonSteps,
                      child: tmp_widget,
                    );
                  
                  if(includeHeroes)
                    tmp_widget = Hero(
                      tag: "webviewHero_" + (interpreter.predictions[i] == " " 
                        ? i.toString() 
                        : interpreter.predictions[i]),
                      child: tmp_widget,
                    );
            
                  return tmp_widget;
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