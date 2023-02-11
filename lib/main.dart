import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaml/yaml.dart';
import 'package:isar/isar.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:window_manager/window_manager.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:archive/archive_io.dart';
import 'package:feedback/feedback.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/model/DictionaryScreen/dictionary_search.dart';
import 'package:da_kanji_mobile/model/search_history.dart';
import 'package:da_kanji_mobile/dakanji_splash.dart';
import 'package:da_kanji_mobile/dakanji_app.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/helper/deep_links.dart';
import 'package:da_kanji_mobile/model/DrawScreen/draw_screen_state.dart';
import 'package:da_kanji_mobile/model/DrawScreen/draw_screen_layout.dart';
import 'package:da_kanji_mobile/model/changelog.dart';
import 'package:da_kanji_mobile/provider/settings/settings.dart';
import 'package:da_kanji_mobile/provider/drawing/drawing_lookup.dart';
import 'package:da_kanji_mobile/provider/drawing/strokes.dart';
import 'package:da_kanji_mobile/provider/drawing/kanji_buffer.dart';
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/model/platform_dependent_variables.dart';
import 'package:da_kanji_mobile/provider/drawer_listener.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/CodegenLoader.dart';
import 'package:da_kanji_mobile/feedback_localization.dart';
import 'package:da_kanji_mobile/provider/isars.dart';



Future<void> main() async {
  
  runApp(DaKanjiSplash());

  // delete settings
  //await clearPreferences();

  // initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();
  // init window Manager
  if(g_desktopPlatform)
    await windowManager.ensureInitialized();

  await init();

  setupErrorCollection();

  runZoned(() => 
    runApp(
      EasyLocalization(
        supportedLocales: g_DaKanjiLocalizations.map((e) => Locale(e)).toList(),
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        useOnlyLangCode: true,
        assetLoader: const CodegenLoader(),
        saveLocale: true,
        child: Phoenix(
          child: BetterFeedback(
            theme: FeedbackThemeData(
              sheetIsDraggable: true
            ),
            localizationsDelegates: [
              CustomFeedbackLocalizationsDelegate()..supportedLocales = {
                const Locale('en'): CustomFeedbackLocalizations()
              },
            ],
            mode: FeedbackMode.navigate,
            child: const DaKanjiApp(),
          ),
        ),
      ),
    ),
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        g_appLogs += "${line}\n";
        parent.print(zone, "EJHEHEHE: ${line}");
      },
    )
  );

}

void setupErrorCollection(){
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    g_appLogs += "${details.exception} \n\n ${details.stack}";
   print("${details.exception} \n\n ${details.stack}");
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    g_appLogs += "${error} \n\n ${stack}";
   print("${error} \n\n ${stack}");
    return true;
  };
}


/// Initializes the app.
/// 
/// This function initializes:
/// * used version, CHANGELOG and about
/// * loads the settings
Future<void> init() async {

  // read the applications version from pubspec.yaml
  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
 print(yaml['version']);
  g_Version = yaml['version'];

  await initGetIt();

  if(Platform.isAndroid || Platform.isIOS){
    await initDeepLinksStream();
    await getInitialDeepLink();
  }
  if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
    desktopWindowSetup();
  }
}

/// copies the zipped database from assets to the user's documents directory
/// and unzips it, if it does not exist already
Future<void> copyDictionaryFilesFromAssets() async {
  // Search and create db file destination folder if not exist
  final documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
 print("documents directory: ${documentsDirectory.toString()}");
  final databaseDirectory = Directory(documentsDirectory.path + "/DaKanji" + "/isar/");

  // if the file already exists delete it
  final dbFile = File(databaseDirectory.path + '/dictionary.isar');
  if (dbFile.existsSync()) {
    dbFile.deleteSync();
   print("Deleted dictionary ISAR");
  }

  // Get pre-populated db file and copy it to the documents directory
  ByteData data = await rootBundle.load("assets/dict/dictionary.zip");
  final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());
  extractArchiveToDisk(archive, databaseDirectory.path);
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
  UserData uD = await (UserData().load());
  GetIt.I.registerSingleton<UserData>(uD);
  await GetIt.I<UserData>().init();
  GetIt.I.registerSingleton<Settings>(Settings());
  await GetIt.I<Settings>().load();
  await GetIt.I<Settings>().save();

  // draw screen services 
  GetIt.I.registerSingleton<DrawScreenState>(DrawScreenState(
    Strokes(), KanjiBuffer(), DrawingLookup(), DrawScreenLayout.portrait)
  );

  // tutorial services
  GetIt.I.registerSingleton<Tutorials>(Tutorials());

  // package for converting between kana
  GetIt.I.registerSingleton<KanaKit>(const KanaKit());

  // ISAR / database services
  String documentsDir =
    (await path_provider.getApplicationDocumentsDirectory()).path;
  String isarPath = documentsDir + "/DaKanji/" + "isar/";
  if(uD.newVersionUsed || !File(isarPath + "dictionary.isar").existsSync())
    await copyDictionaryFilesFromAssets();

  GetIt.I.registerSingleton<Isars>(
    Isars(
      dictionary: Isar.openSync(
        [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
        directory: isarPath,
        name: "dictionary"
      ),
      searchHistory: Isar.openSync(
        [SearchHistorySchema],
        directory: isarPath,
        name: "searchHistory", 
      )
    )
  );

  GetIt.I.registerSingleton<DictionarySearch>(
    DictionarySearch(
      2,
      GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((e) => 
        isoToiso639_2B[e]!.name
      ).toList(),
      GetIt.I<Isars>().dictionary.directory!,
      GetIt.I<Isars>().dictionary.name
    )
  );
  GetIt.I<DictionarySearch>().init();

  // Drawer
  GetIt.I.registerSingleton<DrawerListener>(DrawerListener());

  // Mecab
  GetIt.I.registerSingleton<Mecab>(Mecab());
  await GetIt.I<Mecab>().init(
    "assets/ipadic",
    true,
    dicDir: documentsDir + "/DaKanji/ipadic/"
  );
}

/// Setup the DaKanji window on desktop platforms
void desktopWindowSetup() {
  
  if(kReleaseMode) windowManager.center();

  windowManager.setMinimumSize(const Size(480, 720));
  windowManager.setTitle(g_AppTitle);
  
  windowManager.setSize(Size(
    GetIt.I<Settings>().misc.windowWidth.toDouble(), 
    GetIt.I<Settings>().misc.windowHeight.toDouble()
  ));

  if(kReleaseMode) windowManager.center();

  windowManager.setOpacity(GetIt.I<Settings>().misc.windowOpacity);
  windowManager.setAlwaysOnTop(GetIt.I<Settings>().misc.alwaysOnTop);
}
