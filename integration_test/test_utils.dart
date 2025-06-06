// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/widgets/dictionary/floating_word_stack.dart';

Future<void> waitTillFinder(WidgetTester tester, Finder finder, String waitingMessage) async {
  int cnt = 0;
  while(tester.widgetList(finder).toList().isEmpty &&
    cnt < 100){
    cnt++;
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    debugPrint(waitingMessage);
  }
}

/// This should be called in every integration test at the beginning
/// to setup dakanji
Future<void> initDaKanjiTest(WidgetTester tester, {Function? initCallback}) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  // create app instance and wait until it finished initializing
  await app.main();
  await tester.pump(const Duration(seconds: 10));

  initCallback?.call();
  
  // #region 1 - check that the onboarding is shown and skip it
  //await waitTillFinder(tester, find.byType(OnBoardingPage), 'waiting for app to boot');
  //expect(find.text(LocaleKeys.OnBoarding_Onboarding_1_title.tr()), findsOneWidget);
  //await tester.tapAt(tester.getCenter(find.text(LocaleKeys.General_skip.tr()).first));
  //debugPrint("Passed initDaKanjiTest step: 1");
  // #endregion

  // #region 2 - check that the dictionary shows up
  await waitTillFinder(tester, find.byType(FloatingWordStack), 'waiting for dictionary to load');
  expect(find.byType(FloatingWordStack), findsWidgets);
  debugPrint("Passed initDaKanjiTest step: 2");
  // #endregion

}

/// Naviagtes to the screen given by `screenIcon`
Future<void> navigateToScreen(IconData screenIcon, WidgetTester tester) async {

  // open drawer
  await tester.tapAt(tester.getCenter(find.byIcon(Icons.menu)));

  waitTillFinder(tester, find.byIcon(Icons.brush), "Waiting for drawer to open");

  // navigate to new screen
  await tester.tapAt(tester.getCenter(find.byIcon(screenIcon)));

}
