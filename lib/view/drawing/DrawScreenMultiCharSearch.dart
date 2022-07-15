import 'package:da_kanji_mobile/show_cases/Tutorials.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/show_cases/MultiFocus.dart';
import 'package:da_kanji_mobile/provider/drawing/KanjiBuffer.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/view/drawing/KanjiBufferWidget.dart';



class DrawScreenMultiCharSearch extends StatelessWidget {
  DrawScreenMultiCharSearch(
    this.canvasSize,
    this.runningInLandscape,
    this.includeHeroes,
    this.includeTutorial,
    {Key? key}
    ) : super(key: key);

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
    return ChangeNotifierProvider.value(
      value: GetIt.I<DrawScreenState>().kanjiBuffer,
      child: Consumer<KanjiBuffer>(
        builder: (context, kanjiBuffer, child){
          Widget tpm_widget = MultiFocus(
            focusNodes: includeTutorial ?
              GetIt.I<Tutorials>().drawScreenTutorial.multiCharSearchSteps : null,
            child: Center(
              child: KanjiBufferWidget(
                canvasSize,
                runningInLandscape ? 1.0 : 0.65,
              )
            )
          );
          if (includeHeroes)
            tpm_widget = Hero(
              tag: "webviewHero_b_" + (kanjiBuffer.kanjiBuffer == "" 
                ? "Buffer" 
                : kanjiBuffer.kanjiBuffer),
              child: tpm_widget
            );
          return tpm_widget;
        }
      ),
    );
  }
}