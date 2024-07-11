import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_driver/driver_extension.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/drawing/drawing_canvas.dart';
import 'package:da_kanji_mobile/widgets/drawing/prediction_button.dart';
import 'package:da_kanji_mobile/widgets/drawing/kanji_buffer_widget.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_state.dart';
import 'draw_screen_test_util.dart';
import 'test_utils.dart';



void main() {

  enableFlutterDriverExtension();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("DrawScreen test", (WidgetTester tester) async {

    await initDaKanjiTest(tester, initCallback: () {
      GetIt.I<UserData>().showOnboarding = false;
      GetIt.I<UserData>().showTutorialDictionary = false;
      GetIt.I<UserData>().showTutorialDrawing    = false;
      GetIt.I<Settings>().drawing.emptyCanvasAfterDoubleTap = false;
    });

    await navigateToScreen(Icons.brush, tester);

    await waitTillFinder(tester, find.byType(DrawingCanvas), "Waiting for canvas init");
  
    // check that the app does not show any predictions on start up
    List<String> preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();

    // get position of the drawing canvas
    Offset canvasCenter = tester.getCenter(find.byType(DrawingCanvas));
    double canvasSize = GetIt.I<DrawScreenState>().canvasSize / 2;

    // #region 1 - draw 囗 on the canvas
    await movePointer(tester, canvasCenter, kuchiStrokes, canvasSize/2);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // check that the shown predictions are as expected
    preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();
    expect(preds.contains(kuchiPrediction), true);
    debugPrint("Passed step: 1");
    // #endregion

    // #region 2 - add one stroke (becomes 日) and check predictions
    await movePointer(tester, canvasCenter, nichiStroke, canvasSize/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();
    expect(preds.contains(nichiPrediction), true);
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 2");
    // #endregion
    
    // #region 3 - remove one stroke (becomes 囗)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds.contains(kuchiPrediction), true);
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 3");
    // #endregion
    
    // #region 4 - add two strokes (becomes 目) and check predictions
    await movePointer(tester, canvasCenter, meStroke1, canvasSize/2);
    await movePointer(tester, canvasCenter, meStroke2, canvasSize/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds.contains(mePrediction), true);
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 4");
    // #endregion

    // #region 5 - double tap prediction -> Kanjibuffer = 目
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(
      GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer.split("").every(
        (e) => kanjiBuffer.contains(e)),
        true
    );
    debugPrint("Passed step: 5");
    // #endregion
    
    // #region 6 - remove one stroke (becomes 日)
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pump(const Duration(milliseconds: 500));
    await movePointer(tester, canvasCenter, nichiStroke, canvasSize/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds.contains(nichiPrediction), true);
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 6");
    // #endregion

    // #region 7 - double tap prediction -> Kanjibuffer = 目日
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(
      GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer.split("").every(
        (e) => kanjiBuffer.contains(e)),
        true
    );
    debugPrint("Passed step: 7");
    // #endregion

    // #region 8 - remove one stroke (becomes 口)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds.contains(kuchiPrediction), true);
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 8");
    // #endregion
    
    // #region 9 - double tap prediction -> Kanjibuffer = 目日口
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(
      GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer.split("").every(
        (e) => kanjiBuffer.contains(e)),
        true
    );
    debugPrint("Passed step: 9");
    // #endregion
    
    // #region 10 - clear all -> empty predictions
    await tester.tap(find.byIcon(Icons.clear));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList()))
      {
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      debugPrint("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 10");
    // #endregion
    
    // #region 11 - undo -> nothing (empty predictions)
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle(const Duration(milliseconds: 1000));

    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 11");
    // #endregion

    // #region 12 - clear all -> nothing (empty predictions)
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle(const Duration(milliseconds: 1000));
    
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(const Duration(seconds: 1));
    debugPrint("Passed step: 12");
    // #endregion

    // #region 13 - swipe left on word bar -> wordbar == "目日"
    double kBWidth = tester.getSize(find.byType(KanjiBufferWidget)).width;
    await tester.drag(
      find.byType(KanjiBufferWidget),
      Offset(-kBWidth/2, 0)
    );
    await tester.pump(const Duration(seconds: 1));
    expect(
      GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer.split("").every(
        (e) => kanjiBuffer.contains(e)),
        true
    );
    debugPrint("Passed step: 13");
    // #endregion

    // #region 14 - double tap kanji buffer -> wordbar == ""
    await tester.tap(find.byWidget((tester.widgetList(find.byType(KanjiBufferWidget))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(KanjiBufferWidget))).first));
    await tester.pumpAndSettle();
    expect(GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer, "");
    debugPrint("Passed step: 14");
    // #endregion
  });
}


