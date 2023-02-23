import 'package:da_kanji_mobile/view/home/whats_new_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/view/onboarding/on_boarding_page.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/main.dart' as app;



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Onboarding new features test", (WidgetTester tester) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    g_IsTestingAppStartup = true;
    g_IsTestingAppStartupOnboardingNewFeatures = true;

    // create app instance and wait until it finished initializing
    await app.main();

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // #region 1 - check that the whats new dialog is shown and skip it
    int cnt = 0;
    while(tester.widgetList(find.byType(WhatsNewDialogue)).toList().isEmpty &&
      cnt < 100){
      cnt++;
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      print('waiting for app to boot');
    }
    
    expect(find.text(LocaleKeys.HomeScreen_whats_new.tr()), findsOneWidget);
    
    Offset closeButton = tester.getCenter(find.text(LocaleKeys.General_close.tr()).first);
    await tester.tapAt(closeButton);
    print("Passed step: 1");
    // #endregion

    // #region 2 - check that the whats onboarding is shown and skip it
    cnt = 0;
    while(tester.widgetList(find.byType(OnBoardingPage)).toList().isEmpty &&
      cnt < 100){
      cnt++;
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      print('waiting for onboarding to show');
    }
    
    expect(find.text(LocaleKeys.OnBoarding_Onboarding_1_title.tr()), findsOneWidget);
    
    Offset skipButton = tester.getCenter(find.text(LocaleKeys.General_skip.tr()).first);
    await tester.tapAt(skipButton);
    print("Passed step: 2");
    // #endregion

    GetIt.I.reset();
  });

}