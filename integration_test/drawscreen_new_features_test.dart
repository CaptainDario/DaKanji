import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/view/home/whats_new_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/view/drawing/drawing_canvas.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/main.dart' as app;



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("DrawScreen new features test", (WidgetTester tester) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    globalIsTestingAppStartup = true;
    globalIsTestingAppStartupDrawscreenNewFeatures = true;

    // create app instance and wait until it finished initializing
    await app.main();

    GetIt.I<UserData>().showOnboarding = false;

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // #region 1 - check that the whats new dialog is shown and skip it
    int cnt = 0;
    while(tester.widgetList(find.byType(WhatsNewDialogue)).toList().isEmpty &&
      cnt < 100){
      cnt++;
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      debugPrint('waiting for app to boot');
    }
    
    expect(find.text(LocaleKeys.General_whats_new.tr()), findsOneWidget);
    
    Offset closeButton = tester.getCenter(find.text(LocaleKeys.General_close.tr()).first);
    await tester.tapAt(closeButton);
    debugPrint("Passed step: 1");
    // #endregion

    // #region 2 - check that the drawscreen tutorial is shown
    cnt = 0;
    while(tester.widgetList(find.byType(DrawingCanvas)).toList().isEmpty &&
      cnt < 100){
      cnt++;
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      debugPrint('waiting for onboarding to show');
    }
    
    expect(find.byType(DrawingCanvas), findsOneWidget);
    debugPrint("Passed step: 2");
    // #endregion
  });
}