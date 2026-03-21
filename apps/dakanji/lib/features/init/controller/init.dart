// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:da_db/database/da_db.dart';
import 'package:da_kanji_mobile/core/supabase/model/supabase_cache_manager.dart';
import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_mock_data.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/dictionary/controller/definition_rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:language_processing/language_processing.dart';
import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaml/yaml.dart';

// Project imports:
import 'package:da_kanji_mobile/features/anki/controller/anki.dart';
import 'package:da_kanji_mobile/core/assets/assets.dart';
import 'package:da_kanji_mobile/core/routing/deep_links.dart';
import 'package:da_kanji_mobile/core/user/user_activity.dart';
import 'package:da_kanji_mobile/core/releases/changelog.dart';
import 'package:da_kanji_mobile/features/dictionary/controller/dictionary_search.dart';
import 'package:da_kanji_mobile/features/drawer/controller/drawer_listener.dart';
import 'package:da_kanji_mobile/features/drawing/model/draw_screen_layout.dart';
import 'package:da_kanji_mobile/features/drawing/model/draw_screen_state.dart';
import 'package:da_kanji_mobile/features/drawing/model/drawing_lookup.dart';
import 'package:da_kanji_mobile/features/drawing/model/kanji_buffer.dart';
import 'package:da_kanji_mobile/features/drawing/model/strokes.dart';
import 'package:da_kanji_mobile/core/storage/path_manager.dart';
import 'package:da_kanji_mobile/features/dictionary/controller/isars.dart';
import 'package:da_kanji_mobile/core/device/platform_dependent_variables.dart';
import 'package:da_kanji_mobile/core/releases/version.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/tutorial/model/tutorials.dart';
import 'package:da_kanji_mobile/core/user/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/core/analytics/event_logging.dart';



/// Initializes the app, by initializing all the providers, services, etc.
Future<bool> init() async {
  await preRunInit();
  await postRunInit();
  return true;
}

/// Convenience function to clear the SharedPreferences
Future<void> clearPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

 debugPrint("CLEARED PREFERENCES AT APP START.");
}

/// Loads services that are needed BEFORE runApp
Future<void> preRunInit() async {
  // check webview support
  g_webViewSupported = Platform.isAndroid || Platform.isIOS || Platform.isMacOS ||
    (Platform.isWindows && (await WebViewEnvironment.getAvailableVersion()) != null);

  g_DakanjiPathManager = PathManager();
  await g_DakanjiPathManager.init();

  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  debugPrint("Starting ${g_AppConfig.appTitle} ${yaml['version']}");
  g_Version = Version.fromStringFull(yaml['version']);

  GetIt.I.registerSingleton<PlatformDependentVariables>(PlatformDependentVariables());

  GetIt.I.registerSingleton<Changelog>(Changelog());
  await GetIt.I<Changelog>().init();

  UserData uD = await (UserData().load());
  GetIt.I.registerSingleton<UserData>(uD);
  await GetIt.I<UserData>().init();

  GetIt.I.registerSingleton<Settings>(Settings());
  await GetIt.I<Settings>().load();
  await GetIt.I<Settings>().save();
}

/// Loads services that can be loaded AFTER runApp
Future<void> postRunInit() async {
  GetIt.I.registerSingleton<Tutorials>(Tutorials());
  GetIt.I<Tutorials>().reload();

  GetIt.I.registerSingleton<DrawScreenState>(DrawScreenState(
    Strokes(), KanjiBuffer(), DrawingLookup(), DrawScreenLayout.portrait)
  );

  GetIt.I.registerSingleton<KanaKit>(const KanaKit());

  GetIt.I.registerSingleton<DrawerListener>(DrawerListener());

  GetIt.I.registerSingleton<Anki>(Anki(GetIt.I<Settings>().anki));
  await GetIt.I<Anki>().init();

  GetIt.I.registerSingleton<UserActivity>(UserActivity(GetIt.I<UserData>())..init());

  // User data database setup
  GetIt.I.registerSingleton<UserDataDB>(UserDataDB());
  GetIt.I<UserDataDB>().timeTrackingDao.enforce24HourLimit();
  GetIt.I<UserDataDB>().timeTrackingDao.ensureDailyGoalExists();

  // deep links
  await initDeepLinksStream();

  // try to send cached events (do NOT await, can block UI otherwise)
  retryCachedEvents();

  // setup the Supabase cache manager (handles routing between local cache and
  // Supabase backend)
  GetIt.I.registerSingleton<SupabaseCacheManager>(SupabaseCacheManager());

  await setupMockData();

}

Future setupMockData() async {
  if(kDebugMode){
    debugPrint("Inserting time tracking mock data...");
    final db = GetIt.I<UserDataDB>();
    TimeTrackingMockDataGenerator seeder = TimeTrackingMockDataGenerator(db);
    await seeder.generateMockData();
    debugPrint("Time tracking mock data inserted.");
  }
}

/// Loads all services from disk that DO NOT dpend on data in the documents
/// directory.
Future<void> initServices() async {
  await preRunInit();
  await postRunInit();
}

/// Loads all services from disk that DO depend on data in the documents
/// directory.
Future<void> initDocumentsServices(BuildContext context) async {

  if(g_documentsServicesInitialized) return;

  // check if the data in the documents directory is available
  await initDocumentsAssets(context);

  // ISAR / database services
  String supportDirectory = g_DakanjiPathManager.dakanjiSupportDirectory.path;
  String isarPath = g_DakanjiPathManager.dictionaryDirectory.path;
  GetIt.I.registerSingleton<Isars>(
    Isars(
      dictionary: Isar.getInstance("dictionary") ?? Isar.openSync(
        [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
        directory: isarPath, name: "dictionary", maxSizeMiB: g_IsarDictMaxMiB
      ),
      examples: Isar.getInstance("examples") ?? Isar.openSync(
        [ExampleSentenceSchema], directory: isarPath,
        name: "examples", maxSizeMiB: g_IsarExampleMaxMiB
      ),
      krad: Isar.getInstance("krad") ?? Isar.openSync(
        [KradSchema], directory: isarPath,
        name: "krad", maxSizeMiB: 1
      ),
      radk: Isar.getInstance("radk") ?? Isar.openSync(
        [RadkSchema], directory: isarPath,
        name: "radk", maxSizeMiB: 1
      )
    )
  );

  GetIt.I.registerSingleton<DictionarySearch>(
    DictionarySearch(
      GetIt.I<Settings>().advanced.noOfSearchIsolates,
      GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((e) => 
        isoToIso639_3[e]!.name
      ).toList(),
      GetIt.I<Isars>().dictionary.directory!,
      GetIt.I<Isars>().dictionary.name,
      GetIt.I<Settings>().dictionary.convertToHiraganaBeforeSearch
    ), dispose: (param) => param.kill(),
  );
  await GetIt.I<DictionarySearch>().init();

  // Language processing
  LanguageProcessor? languageProcessor;
  if(g_AppConfig.languageCode == Iso639_3.jpn){
    languageProcessor = JapaneseProcessor(
      mecabTransferableState: MecabTransferableState(
        mecabDictDirPath: p.joinAll([supportDirectory, "assets", "mecab_dict"]),
      )
    );
    await (languageProcessor as JapaneseProcessor).init();
  }
  else {
    throw Exception("No LanguageProcessor implemented for ${g_AppConfig.languageCode}");
  }
  GetIt.I.registerSingleton<LanguageProcessor>(languageProcessor);

  // database
  GetIt.I.registerSingleton<DaDb>(DaDb(
    dbPath: p.joinAll([g_DakanjiPathManager.dictionaryDirectory.path, "da.db"]),
    inMemory: false,
    languageProcessor: GetIt.I<LanguageProcessor>(),
  ));

  // definition rendering
  GetIt.I.registerSingletonAsync<YomitanRenderService>(() async {
    final service = YomitanRenderService();
    await service.isReady;
    return service;
  });

  g_documentsServicesInitialized = true;
}

/// Initializes the document assets, by copying the assets from the assets
/// Checks if a different version of
/// * the dictionary DB
/// * the examples DB
/// * mecab's dictionary
/// is needed for this release. If so, copy the new one from assets / donwload
/// from GitHub. The context is used for showing a popup 
Future<void> initDocumentsAssets(BuildContext context) async {

  String supportDir = g_DakanjiPathManager.dakanjiSupportDirectory.path;
  debugPrint("documents directory: ${supportDir.toString()}");

  // download assets from GH
  bool downloadAllowed = false;

  List<FileSystemEntity> assets = [
    "assets/dict/dictionary.isar",
    "assets/dict/examples.isar",
    "assets/dict/krad.isar",
    "assets/dict/radk.isar",
    "assets/mecab_dict",
    "assets/ml/CNN_single_char"
  ].map((f) => File(f)).toList();

  // While getting the assets do not turn of the screen
  WakelockPlus.enable();
  for (var asset in assets) {
    if(!checkAssetExists(supportDir, asset)
      || asset == assets[0] && GetIt.I<UserData>().getNewDict //dict
      || asset == assets[1] && GetIt.I<UserData>().getNewExamples //examples
      || asset == assets[2] && GetIt.I<UserData>().getNewRadicals // krad
      || asset == assets[3] && GetIt.I<UserData>().getNewRadicals // radk
    ){
      await getAsset(
        asset, p.joinAll([supportDir, ...asset.uri.pathSegments]),
        g_AppConfig.githubApiDataRelase, context, !downloadAllowed
      );
      downloadAllowed = true;
    }
  }
  WakelockPlus.disable();

}

/// Checks if an `asset` exists in the `documentsDir` Returns
/// true if `asset` exists in the `documentsDir`
/// false otherwise 
bool checkAssetExists(String documentsDir, FileSystemEntity asset){

  return !(!File(p.joinAll([documentsDir, ...asset.uri.pathSegments])).existsSync() &&
    !Directory(p.joinAll([documentsDir, ...asset.uri.pathSegments])).existsSync());

}

/// Removes the menu bar and shows square window while the app is loading
Future<void> splashscreenDesktop() async {

  await windowManager.setSize(const Size(600, 600));
  if(!kReleaseMode) await windowManager.center();
  await windowManager.setAsFrameless();
  await windowManager.setAlwaysOnTop(true);

}

/// Setup the DaKanji window on desktop platforms
Future<void> desktopWindowSetup() async {

  if(!g_desktopPlatform) return;

  await windowManager.setMinimumSize(g_minDesktopWindowSize);
  await windowManager.setTitle(g_AppConfig.appTitle);
  
  await windowManager.setSize(Size(
    GetIt.I<Settings>().misc.windowWidth.toDouble(), 
    GetIt.I<Settings>().misc.windowHeight.toDouble()
  ));

  await windowManager.setPosition(Offset(
    GetIt.I<Settings>().misc.windowPosX.toDouble(), 
    GetIt.I<Settings>().misc.windowPosY.toDouble()
  ));

  await windowManager.setOpacity(GetIt.I<Settings>().misc.windowOpacity);
  await windowManager.setAlwaysOnTop(GetIt.I<Settings>().misc.alwaysOnTop);
  await windowManager.setTitleBarStyle(TitleBarStyle.normal);
}


