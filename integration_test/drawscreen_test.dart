import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';
import 'package:da_kanji_mobile/view/drawing/PredictionButton.dart';
import 'package:da_kanji_mobile/view/drawing/KanjiBufferWidget.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'drawscreen_test_util.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("DrawScreen test", (WidgetTester tester) async {

    IS_TESTING_DRAWSCREEN = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    // create app instance and wait until it finished initializing
    await app.main();
    GetIt.I<Settings>().load();
    GetIt.I<Settings>().save();
    GetIt.I<UserData>().showChangelog       = false;
    GetIt.I<UserData>().showOnboarding      = false;
    GetIt.I<UserData>().showRatePopup       = false;
    GetIt.I<UserData>().showShowcaseDrawing = false;
    GetIt.I<UserData>().save();

    await tester.pumpAndSettle(Duration(seconds: 1));

    // check that the app does not show any predictions on start up
    List<String> preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();

    // get position of the drawing canvas
    Offset canvasCenter = tester.getCenter(find.byType(DrawingCanvas));
    double canvasSize = GetIt.I<DrawScreenState>().canvasSize / 2;

    // #region 1 - draw 囗 on the canvas
    await movePointer(tester, canvasCenter, kuchiStrokes, canvasSize/2);
    await tester.pumpAndSettle(Duration(seconds: 2));
    // check that the shown predictions are as expected
    preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();
    expect(preds[0], kuchiPrediction);
    print("Passed step: 1");
    // #endregion

    // #region 2 - add one stroke (becomes 日) and check predictions
    await movePointer(tester, canvasCenter, nichiStroke, canvasSize/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();
    expect(preds[0], nichiPrediction);
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 2");
    // #endregion
    
    // #region 3 - remove one stroke (becomes 囗)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds[0], kuchiPrediction);
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 3");
    // #endregion
    
    // #region 4 - add two strokes (becomes 目) and check predictions
    await movePointer(tester, canvasCenter, meStroke1, canvasSize/2);
    await movePointer(tester, canvasCenter, meStroke2, canvasSize/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds[0], mePrediction);
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 4");
    // #endregion

    // #region 5 - double tap prediction -> Kanjibuffer = 目
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer, kanjiBuffer_1);
    print("Passed step: 5");
    // #endregion
    
    // #region 6 - remove one stroke (becomes 日)
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pump(Duration(milliseconds: 500));
    await movePointer(tester, canvasCenter, nichiStroke, canvasSize/2);
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds[0], nichiPrediction);
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 6");
    // #endregion

    // #region 7 - double tap prediction -> Kanjibuffer = 目日
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer, kanjiBuffer_2);
    print("Passed step: 7");
    // #endregion

    // #region 8 - remove one stroke (becomes 口)
    await tester.tap(find.byIcon(Icons.undo));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList())){
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds[0], kuchiPrediction);
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 8");
    // #endregion
    
    // #region 9 - double tap prediction -> Kanjibuffer = 目日口
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer, kanjiBuffer_3);
    print("Passed step: 9");
    // #endregion
    
    // #region 10 - clear all -> empty predictions
    await tester.tap(find.byIcon(Icons.clear));
    while (listEquals(preds, (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList()))
      {
      await tester.pumpAndSettle(Duration(milliseconds: 100));
      print("waiting");
    }
    preds = (tester.widgetList(find.byType(PredictionButton)))
      .map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 10");
    // #endregion
    
    // #region 11 - undo -> nothing (empty predictions)
    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle(Duration(milliseconds: 1000));

    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 11");
    // #endregion

    // #region 12 - clear all -> nothing (empty predictions)
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle(Duration(milliseconds: 1000));
    
    preds = (tester.widgetList(find.byType(PredictionButton))).map((e) => (e as PredictionButton).char).toList();
    expect(preds, List.generate(10, (index) => " "));
    await tester.pump(Duration(seconds: 1));
    print("Passed step: 12");
    // #endregion

    // #region 13 - swipe left on word bar -> wordbar == "目日"
    double kBWidth = tester.getSize(find.byType(KanjiBufferWidget)).width;
    await tester.drag(
      find.byType(KanjiBufferWidget),
      Offset(-kBWidth/2, 0)
    );
    await tester.pump(Duration(seconds: 1));
    expect(GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer, "目日");
    print("Passed step: 13");
    // #endregion

    // #region 14 - double tap kanji buffer -> wordbar == ""
    await tester.tap(find.byWidget((tester.widgetList(find.byType(KanjiBufferWidget))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(KanjiBufferWidget))).first));
    await tester.pumpAndSettle();
    expect(GetIt.I<DrawScreenState>().kanjiBuffer.kanjiBuffer, "");
    print("Passed step: 14");
    // #endregion
  });
}


