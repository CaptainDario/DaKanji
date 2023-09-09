import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/widgets/onboarding/on_boarding_page.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/main.dart' as app;



void main() {
  
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("First startup test", (WidgetTester tester) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    // create app instance and wait until it finished initializing
    await app.main();

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // #region 1 - check that the onboarding is shown and skip it
    int cnt = 0;
    while(tester.widgetList(find.byType(OnBoardingPage)).toList().isEmpty &&
      cnt < 100){
      cnt++;
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      print('waiting for app to boot');
    }
    
    expect(find.text(LocaleKeys.OnBoarding_Onboarding_1_title.tr()), findsOneWidget);
    
    Offset skipButton = tester.getCenter(find.text(LocaleKeys.General_skip.tr()).first);
    await tester.tapAt(skipButton);
    print("Passed step: 1");
    // #endregion

    // #region 3 - check that the DrawScreen tutorial is shown
    cnt = 0;
    while(tester.widgetList(find.byType(OnboardingStepper)).toList().isEmpty && cnt < 60){
      cnt++;
      await tester.pumpAndSettle(const Duration(seconds: 1));
      print('waiting for dictionary to load');
    }
    
    expect(find.byType(OnboardingStepper), findsOneWidget);
    print("Passed step: 2");
    // #endregion

  });
}