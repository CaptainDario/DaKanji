import 'package:da_kanji_mobile/show_cases/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/view/DaKanjiShowCaseElement.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/provider/drawing/KanjiBuffer.dart';
import 'package:da_kanji_mobile/provider/drawing/DrawScreenState.dart';
import 'package:da_kanji_mobile/view/drawing/KanjiBufferWidget.dart';



class DrawScreenMultiCharSearch extends StatelessWidget {
  const DrawScreenMultiCharSearch(
    this.canvasSize,
    this.runningInLandscape,
    this.includeHeroes,
    {Key? key}
    ) : super(key: key);

  final double canvasSize;
  final bool runningInLandscape;
  final bool includeHeroes;



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GetIt.I<DrawScreenState>().kanjiBuffer,
      child: Consumer<KanjiBuffer>(
        builder: (context, kanjiBuffer, child){
          var showCaseIdxs = [7, 9, 10, 11, 12];
          Widget tpm_widget = DaKanjiShowCaseElement(
            List.generate(showCaseIdxs.length, (index) => drawScreenShowcaseIDs[showCaseIdxs[index]]),
            List.generate(showCaseIdxs.length, (index) =>
              Text(drawScreenShowcaseTexts[showCaseIdxs[index]])
            ),
            List.generate(showCaseIdxs.length, (index) => ContentLocation.above),
            Center(
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