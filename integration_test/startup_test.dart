import 'package:flutter_test/flutter_test.dart';
//import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/main.dart' as app;



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("First boot test", (WidgetTester tester) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    IS_TESTING_APP_STARTUP = true;

    // create app instance and wait until it finished initializing
    await app.main();
    await tester.pumpAndSettle(Duration(seconds: 5));

    // #region 1 - check that the onboarding is shown
    expect(find.text(LocaleKeys.General_skip.tr()), findsOneWidget);
    
    await tester.tap(find.text(LocaleKeys.General_skip.tr()));
    // #endregion

  });
}