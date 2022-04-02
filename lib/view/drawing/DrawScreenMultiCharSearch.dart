import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:da_kanji_mobile/provider/drawing/KanjiBuffer.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
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
          Widget tpm_widget = Center(
              child: KanjiBufferWidget(
                canvasSize,
                runningInLandscape ? 1.0 : 0.65,
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