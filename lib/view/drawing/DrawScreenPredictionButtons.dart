import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/model/core/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/view/drawing/PredictionButton.dart';



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
    return Container(              //use canvas height in runningInLandscape
      width :  runningInLandscape ? (canvasSize * 0.4) : canvasSize,
      height: !runningInLandscape ? (canvasSize * 0.4) : canvasSize, 
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawingInterpreter>(),
        child: Consumer<DrawingInterpreter>(
          builder: (context, interpreter, child){
            return GridView.count(
              physics: new NeverScrollableScrollPhysics(),
              scrollDirection: runningInLandscape ? Axis.horizontal : Axis.vertical,
              crossAxisCount: 5,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              
              children: List.generate(10, (i) {
                Widget tmp_widget = PredictionButton(
                  interpreter.predictions[i],
                );
                // instantiate short/long press showcase button
                if(i == 0){
                  tmp_widget = Container(
                    child: tmp_widget 
                  );
                }
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
            );
          }
        ),
      )
    );
  }
}