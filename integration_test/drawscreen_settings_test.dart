import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';
import 'package:da_kanji_mobile/view/drawing/PredictionButton.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'drawscreen_test_util.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();


  testWidgets("DrawScreen settings test", (WidgetTester tester) async {

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
    await tester.pumpAndSettle(Duration(seconds: 1));
    // #endregion

    // #region 2 - double tap prediction -> add to clipboard = 囗
    Clipboard.setData(ClipboardData(text: ""));
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect((await Clipboard.getData('text/plain'))?.text, "囗");
    print("Passed step: 2");
    await tester.pumpAndSettle(Duration(seconds: 1));
    // #endregion
  
    // #region 3 - change setting: invert short / long press
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_title.tr()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_invert_short_long_press.tr()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.brush));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    print("Passed step: 3");
    await tester.pumpAndSettle(Duration(seconds: 1));
    // #endregion

    // #region 4 - long press prediction -> clipboard = 囗
    Clipboard.setData(ClipboardData(text: ""));
    await tester.longPress(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect((await Clipboard.getData('text/plain'))?.text, "囗");
    print("Passed step: 4");
    await tester.pumpAndSettle(Duration(seconds: 1));
    // #endregion

    // #region 5 - change setting: clear canvas after double tap
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_title.tr()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_empty_canvas_after_double_tap.tr()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.brush));
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.pumpAndSettle(Duration(seconds: 1));
    print("Passed step: 5");
    await tester.pumpAndSettle(Duration(seconds: 1));
    // #endregion

    // #region 6 - double tap prediction -> canvas should be empty
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pump(kDoubleTapMinTime);
    await tester.tap(find.byWidget((tester.widgetList(find.byType(PredictionButton))).first));
    await tester.pumpAndSettle();
    expect(GetIt.I<DrawScreenState>().strokes.strokeCount, 0);
    print("Passed step: 6");
    await tester.pumpAndSettle(Duration(seconds: 1));
    // #endregion
  });
}
