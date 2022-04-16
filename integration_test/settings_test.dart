import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/globals.dart';



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



  });
}