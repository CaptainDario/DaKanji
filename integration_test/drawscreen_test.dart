import 'package:da_kanji_mobile/provider/drawing/DrawScreenState.dart';
import 'package:da_kanji_mobile/provider/drawing/KanjiBuffer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/drawing/PredictionButton.dart';
import 'drawscreen_test_values.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("DrawScreen test", (WidgetTester tester) async {

    IS_TESTING_DRAWSCREEN = true;

    // create app instance and wait until it finished initializing
    app.main();
    print(GetIt.I<DrawScreenState>());
    await tester.pumpAndSettle(Duration(seconds: 2));

    // check that the app does not show any predictions on start up
    List<String> preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();

    // get position of the drawing canvas
    Offset canvasCenter = tester.getCenter(find.byType(DrawingCanvas));
    Size canvasSize = tester.getSize(find.byType(DrawingCanvas));

    // #region 1 - draw 囗 on the canvas
    await movePointer(tester, canvasCenter, kuchiStrokes, canvasSize.height/2);
    await tester.pumpAndSettle(Duration(seconds: 2));
    // check that the shown predictions are as expected
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, kuchiPredictions);
    // #endregion

    // #region 2 - add one stroke (becomes 日) and check predictions
    await movePointer(tester, canvasCenter, nichiStroke, canvasSize.height/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, nichiPredictions);
    await tester.pump(Duration(seconds: 1));
    // #endregion
    
    // #region 3 - remove one stroke (becomes 囗)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, kuchiPredictions);
    await tester.pump(Duration(seconds: 1));
    // #endregion
    
    // #region 4 - add two strokes (becomes 目) and check predictions
    await movePointer(tester, canvasCenter, meStroke1, canvasSize.height/2);
    await movePointer(tester, canvasCenter, meStroke2, canvasSize.height/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, mePredictions);
    await tester.pump(Duration(seconds: 1));
    // #endregion

    // #region 5 - double tap prediction -> Kanjibuffer = 目
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    // #endregion
    
    
    // #region 6 - remove one stroke (becomes 日)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, nichiPredictions);
    await tester.pump(Duration(seconds: 1));
    // #endregion

    // TODO #region 7 - double tap prediction -> Kanjibuffer = 目日

    // #endregion

    // #region 8 - remove one stroke (becomes 口)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, kuchiPredictions);
    await tester.pump(Duration(seconds: 1));
    // #endregion
    
    // TODO #region 9 - double tap prediction -> Kanjibuffer = 目日口

    // #endregion
    
    // #region 10 - clear all -> empty predictions
    tester.tap(find.byIcon(Icons.clear));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(Duration(seconds: 1));
    // #endregion
    
    // #region 11 - undo -> nothing (empty predictions)
    tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(Duration(seconds: 1));
    // #endregion

    // #region 12 - clear all -> nothing (empty predictions)
    tester.tap(find.byIcon(Icons.clear));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(Duration(seconds: 1));
    // #endregion
  });
}



/// Creates a pointer and moves it to the given `points` in relation to 
/// `referencePoint` as center point. 
/// Moves the pointer up after each point. 
Future<void> movePointer(
  WidgetTester tester,
  Offset referencePoint,
  List<Offset> points,
  double scale,
  {Duration wait = const Duration(milliseconds: 500)}) async {
    
    // create a pointer to draw a character on the canvas
    final gesture = await tester.createGesture();
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pumpAndSettle();
    
    // draw lines between all the given points
    for (int i = 0; i < points.length-1; i++){ 
      await gesture.down(referencePoint + points[i] * scale);
      await gesture.moveTo(referencePoint + points[i+1] * scale);
      await gesture.up();
      await tester.pump(wait);
    }
    await tester.pumpAndSettle();

}