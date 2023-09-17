// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/data/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/domain/drawing/draw_screen_state.dart';
import 'package:da_kanji_mobile/domain/drawing/kanji_buffer.dart';
import 'package:da_kanji_mobile/widgets/drawing/kanji_buffer_widget.dart';
import 'package:da_kanji_mobile/widgets/widgets/multi_focus.dart';

class DrawScreenMultiCharSearch extends StatelessWidget {
  const DrawScreenMultiCharSearch(
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
          Widget tpmWidget = MultiFocus(
            focusNodes: includeTutorial ?
              GetIt.I<Tutorials>().drawScreenTutorial.multiCharSearchSteps : null,
            child: Center(
              child: KanjiBufferWidget(
                canvasSize,
                runningInLandscape ? 1.0 : 0.65,
              )
            )
          );
          if (includeHeroes) {
            tpmWidget = Hero(
              tag: "webviewHero_b_" + (kanjiBuffer.kanjiBuffer == "" 
                ? "Buffer" 
                : kanjiBuffer.kanjiBuffer),
              child: tpmWidget
            );
          }
          return tpmWidget;
        }
      ),
    );
  }
}
