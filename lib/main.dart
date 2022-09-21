import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaml/yaml.dart';

import 'package:kagome_dart/kagome_dart.dart';
import 'package:database_builder/objectbox.g.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:window_size/window_size.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

import 'package:database_builder/src/jm_enam_and_dict_to_hive/dataClasses_objectbox.dart';
import 'package:da_kanji_mobile/show_cases/Tutorials.dart';
import 'package:da_kanji_mobile/model/LightTheme.dart';
import 'package:da_kanji_mobile/model/DarkTheme.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/model/SettingsArguments.dart';
import 'package:da_kanji_mobile/helper/DeepLinks.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenLayout.dart';
import 'package:da_kanji_mobile/model/Changelog.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/provider/drawing/DrawingLookup.dart';
import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/provider/drawing/KanjiBuffer.dart';
import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/model/PlatformDependentVariables.dart';
import 'package:da_kanji_mobile/provider/DrawerListener.dart';
import 'package:da_kanji_mobile/view/home/HomeScreen.dart';
import 'package:da_kanji_mobile/view/settings/SettingsScreen.dart';
import 'package:da_kanji_mobile/view/ChangelogScreen.dart';
import 'package:da_kanji_mobile/view/TestScreen.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreen.dart';
import 'package:da_kanji_mobile/view/dictionary/DictionaryScreen.dart';
import 'package:da_kanji_mobile/view/text/TextScreen.dart';
import 'package:da_kanji_mobile/view/AboutScreen.dart';
import 'package:da_kanji_mobile/view/onboarding/OnBoardingScreen.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/CodegenLoader.dart';



Future<void> main() async {

  await init();
  
  runApp(
    EasyLocalization(
      supportedLocales: SUPPORTED_LANGUAGES.map((e) => Locale(e)).toList(),
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      useFallbackTranslations: true,
      useOnlyLangCode: true,
      assetLoader: CodegenLoader(),
      saveLocale: true,
      child: Phoenix(
        child: DaKanjiApp(),
      ),
    ),
  );
}


/// Initializes the app.
/// 
/// This function initializes:
/// * used version, CHANGELOG and about
/// * loads the settings
/// * initializes tensorflow lite and reads the labels from file 
Future<void> init() async {

  // initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();
  
  // NOTE: uncomment to clear the SharedPreferences
  //await clearPreferences();

  // read the applications version from pubspec.yaml
  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  print(yaml['version']);
  VERSION = yaml['version'];  

  await initGetIt();

  if(Platform.isAndroid || Platform.isIOS){
    await initDeepLinksStream();
    await getInitialDeepLink();
  }
  if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
    desktopWindowSetup();
  }

  // init databases
  String dbPath = (await path_provider.getApplicationDocumentsDirectory()).path;
  await setupDicts(dbPath);
}

/// Init the dictionary hive boxes in `path`
/// 
/// If this is the first time using the app / new version the dictionary files
/// will be created.
Future<void> setupDicts(String path) async {
  
  //getDict("jm_enam_and_dict", hivePath);
  //getDict("kanji_svg", hivePath);
  //getDict("kanjidic2", hivePath);
    
}

Future<void> getDict(String name, String hivePath) async{
  /*
  if(!await Hive.boxExists(name, path: hivePath)){
    print("$name not found, Copying!");

    await Hive.openBox(name);

    var box = Hive.box(name);
    String hiveLoc = "${hivePath}/$name.hive";
    await box.close();

    ByteData data = await rootBundle.load("assets/dict/$name.hive");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    File(hiveLoc).writeAsBytes(bytes, flush: true);
  }
  */
}

/// Convenience function to clear the SharedPreferences
Future<void> clearPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  print("CLEARED PREFERENCES AT APP START.");
}

/// Initialize GetIt by initializing and registering all the instances that
/// are accessed through getIt
Future<void> initGetIt() async {

  // services to load from disk
  GetIt.I.registerSingleton<PlatformDependentVariables>(PlatformDependentVariables());
  GetIt.I.registerSingleton<Changelog>(Changelog());
  await GetIt.I<Changelog>().init();
  GetIt.I.registerSingleton<UserData>(UserData());
  await GetIt.I<UserData>().init();
  GetIt.I.registerSingleton<Settings>(Settings());
  await GetIt.I<Settings>().load();
  await GetIt.I<Settings>().save();
  
  // inference services
  GetIt.I.registerSingleton<DrawingInterpreter>(DrawingInterpreter());

  // draw screen services 
  GetIt.I.registerSingleton<DrawScreenState>(DrawScreenState(
    Strokes(), KanjiBuffer(), DrawingLookup(), DrawScreenLayout.Portrait)
  );

  // tutorial services
  GetIt.I.registerSingleton<Tutorials>(Tutorials());
  
  // Kagome
  GetIt.I.registerSingleton<Kagome>(Kagome());

  // ObjectBox
  Store store = await openStore(
    directory: (await path_provider.getApplicationDocumentsDirectory()).path,
  );
  GetIt.I.registerSingleton(store.box<Jm_enam_and_dict_Entry>());

  // Drawer
  GetIt.I.registerSingleton<DrawerListener>(DrawerListener());
}

/// Setup the DaKanji window on desktop platforms
void desktopWindowSetup() {
  setWindowMinSize(Size(480, 720));
  setWindowTitle(APP_TITLE);
  
  setWindowFrame(
    Rect.fromLTWH(
      0,
      0, 
      GetIt.I<Settings>().settingsMisc.windowWidth.toDouble(), 
      GetIt.I<Settings>().settingsMisc.windowHeight.toDouble()
    )
  );
}

/// The starting widget of the app
class DaKanjiApp extends StatefulWidget {

  @override
  _DaKanjiAppState createState() => _DaKanjiAppState();
}

class _DaKanjiAppState extends State<DaKanjiApp> {

  @override
  dispose() {
    linkSub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
      onGenerateRoute: (settings) {
        PageRouteBuilder switchScreen (Widget screen) =>
          PageRouteBuilder(
            pageBuilder: (_, __, ___) {
                // reload the tutorials
                GetIt.I<Tutorials>().reload();

                return Onboarding(
                  steps: GetIt.I<Tutorials>().getSteps(),
                  autoSizeTexts: true,
                  onChanged: (int index){
                    print("Tutorial step: ${index}");
                    if(index == GetIt.I<Tutorials>().drawScreenTutorial.drawScreenTutorialIndexes.last){
                      print("DrawScreen tutorial done, saving...");
                      GetIt.I<UserData>().showShowcaseDrawing = false;
                      GetIt.I<UserData>().save();
                    }
                  },
                  child: screen,
                );
            },
            settings: settings,
            transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c)
          );

        // check type and extract arguments
        SettingsArguments args;
        if((settings.arguments is SettingsArguments))
          args = settings.arguments as SettingsArguments;
        else
          args = SettingsArguments(false);

        switch(settings.name){
          case "/home":
            return switchScreen(HomeScreen());
          case "/onboarding":
            return switchScreen(OnBoardingScreen());
          case "/drawing":
            return switchScreen(DrawScreen(args.navigatedByDrawer, true, true));
          case "/dictionary":
            return switchScreen(DictionaryScreen(args.navigatedByDrawer, false, false));
          case "/text":
            return switchScreen(TextScreen(args.navigatedByDrawer, false, false));
          case "/settings":
            return switchScreen(SettingsScreen(args.navigatedByDrawer));
          case "/about":
            return switchScreen(AboutScreen(args.navigatedByDrawer));
          case "/changelog":
            return switchScreen(ChangelogScreen());
          case "/testScreen":
            return switchScreen(TestScreen());
        }
        throw UnsupportedError("Unknown route: ${settings.name}");
      },

      title: APP_TITLE,

      // themes
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: GetIt.I<Settings>().selectedThemeMode(),

      //screens
      home: HomeScreen(),
      //home: TestScreen()

    );
  }
}
