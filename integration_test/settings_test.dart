import 'package:da_kanji_mobile/widgets/drawing/drawing_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("DrawScreen test", (WidgetTester tester) async {
    // #region 0 - setup
    g_IsTestingDrawscreen = true;

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

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // #endregion

    
    // #region 1 - change setting: theme = dark
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_title.tr()));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Offset pos = tester.getCenter(find.text(LocaleKeys.SettingsScreen_misc_theme.tr()));
    await tester.tapAt(Offset(pos.dx*3, pos.dy));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    pos = tester.getCenter(find.text(LocaleKeys.General_dark.tr()).last);
    await tester.tapAt(pos);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    
    print("Passed step: 1");
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // #endregion

    // #region 2 - change setting: theme = light
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_title.tr()));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    pos = tester.getCenter(find.text(LocaleKeys.SettingsScreen_misc_theme.tr()));
    await tester.tapAt(Offset(pos.dx*3, pos.dy));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    pos = tester.getCenter(find.text(LocaleKeys.General_light.tr()).last);
    await tester.tapAt(pos);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    
    print("Passed step: 2");
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // #endregion
    
    // #region 3 - change setting: language = pl
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.SettingsScreen_title.tr()));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    pos = tester.getCenter(find.text('pl').last);
    await tester.tapAt(pos);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    pos = tester.getCenter(find.text('pl').last);
    await tester.tapAt(pos);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    
    expect(find.text("Ustawienia"), findsOneWidget);
    print("Passed step: 3");
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // #endregion

    // #region 4 - reshow tutorials
    await tester.scrollUntilVisible(
      find.byIcon(Icons.replay_outlined), 
      10,
      scrollable: find.descendant(
        of: find.byType(SingleChildScrollView), 
        matching: find.byType(Scrollable)
      ).last
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.replay_outlined).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    
    int cnt = 0;
    while(tester.widgetList(find.byType(DrawingCanvas)).toList().isEmpty &&
      cnt < 100){
      cnt++;
      await tester.pumpAndSettle(const Duration(milliseconds: 250));
      print('waiting for welcome to show');
    }

    expect(find.byType(DrawingCanvas), findsOneWidget);
    expect(find.text("Obraz"), findsOneWidget);
    expect(GetIt.I<UserData>().showShowcaseDrawing, true);

    print("Passed step: 4");
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // #endregion
  });
}