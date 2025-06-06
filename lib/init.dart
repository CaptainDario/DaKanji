// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_for_flutter/mecab_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaml/yaml.dart';

// Project imports:
import 'package:da_kanji_mobile/application/anki/anki.dart';
import 'package:da_kanji_mobile/application/assets/assets.dart';
import 'package:da_kanji_mobile/application/routing/deep_links.dart';
import 'package:da_kanji_mobile/application/stats/stats.dart';
import 'package:da_kanji_mobile/entities/changelog.dart';
import 'package:da_kanji_mobile/entities/dictionary/dictionary_search.dart';
import 'package:da_kanji_mobile/entities/dojg/dojg_entry.dart';
import 'package:da_kanji_mobile/entities/drawer/drawer_listener.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_layout.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_state.dart';
import 'package:da_kanji_mobile/entities/drawing/drawing_interpreter.dart';
import 'package:da_kanji_mobile/entities/drawing/drawing_lookup.dart';
import 'package:da_kanji_mobile/entities/drawing/kanji_buffer.dart';
import 'package:da_kanji_mobile/entities/drawing/strokes.dart';
import 'package:da_kanji_mobile/entities/files/path_manager.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/iso/iso_table.dart';
import 'package:da_kanji_mobile/entities/platform_dependent_variables.dart';
import 'package:da_kanji_mobile/entities/releases/version.dart';
import 'package:da_kanji_mobile/entities/search_history/search_history_sql.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/tf_lite/inference_backend.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/repositories/analytics/event_logging.dart';

/// Initializes the app, by initializing all the providers, services, etc.
Future<bool> init() async {

  // check webview support
  g_webViewSupported = Platform.isAndroid || Platform.isIOS || Platform.isMacOS ||
    (Platform.isWindows && (await WebViewEnvironment.getAvailableVersion()) != null);

  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();

  g_DakanjiPathManager = PathManager();
  await g_DakanjiPathManager.init();

  await initServices();

  // deep links
  await initDeepLinksStream();

  // try to send cached events
  await retryCachedEvents();

  return true;
}

/// Convenience function to clear the SharedPreferences
Future<void> clearPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

 debugPrint("CLEARED PREFERENCES AT APP START.");
}

/// Loads all services from disk that DO NOT dpend on data in the documents
/// directory.
Future<void> initServices() async {
  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  debugPrint("Starting DaKanji ${yaml['version']}");
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

  GetIt.I.registerSingleton<Tutorials>(Tutorials());
  GetIt.I<Tutorials>().reload();

  GetIt.I.registerSingleton<DrawScreenState>(DrawScreenState(
    Strokes(), KanjiBuffer(), DrawingLookup(), DrawScreenLayout.portrait)
  );

  GetIt.I.registerSingleton<KanaKit>(const KanaKit());

  GetIt.I.registerSingleton<DrawerListener>(DrawerListener());

  GetIt.I.registerSingleton<Anki>(Anki(GetIt.I<Settings>().anki));
  await GetIt.I<Anki>().init();

  GetIt.I.registerSingleton<Stats>(Stats(uD)..init());

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
  String dojgIsarPath = g_DakanjiPathManager.dojgDirectory.path;
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
      ),
      dojg: GetIt.I<UserData>().dojgImported && Directory(dojgIsarPath).existsSync()
        ? Isar.getInstance("dojg") ?? Isar.openSync(
          [DojgEntrySchema], directory: dojgIsarPath,
          name: "dojg", maxSizeMiB: 16
        )
        : null
    )
  );

  // word lists SQL
  final wordListsSQL = WordListsSQLDatabase(g_DakanjiPathManager.wordListsSqlFile);
  await wordListsSQL.init();
  GetIt.I.registerSingleton<WordListsSQLDatabase>(wordListsSQL);

  // search history SQL
  GetIt.I.registerSingleton<SearchHistorySQLDatabase>(
    SearchHistorySQLDatabase(g_DakanjiPathManager.searchHistorySqlFile)
  );

  GetIt.I.registerSingleton<DictionarySearch>(
    DictionarySearch(
      GetIt.I<Settings>().advanced.noOfSearchIsolates,
      GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((e) => 
        isoToiso639_2B[e]!.name
      ).toList(),
      GetIt.I<Isars>().dictionary.directory!,
      GetIt.I<Isars>().dictionary.name,
      GetIt.I<Settings>().dictionary.convertToHiraganaBeforeSearch
    ), dispose: (param) => param.kill(),
  );
  await GetIt.I<DictionarySearch>().init();

  // Mecab
  GetIt.I.registerSingleton<Mecab>(Mecab());

  await GetIt.I<Mecab>().initFlutter(
    p.joinAll([supportDirectory, "assets", "mecab_dict"]), true);

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
        g_GithubApiDependenciesRelase, context, !downloadAllowed
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
  await windowManager.setTitle(g_AppTitle);
  
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

/// Tests all TF Lite models for the backends that are available on the device
/// This is done by loading the model and running a dummy input through it.
/// The results are stored in UserData, so that this function does only need to
/// be called only once.
Future<List<Tuple2<String, List<MapEntry<InferenceBackend, double>>>>> optimizeTFLiteBackendsForModels() async {

  List<Tuple2<String, List<MapEntry<InferenceBackend, double>>>> allTestResults = [];

  debugPrint("Optimizing TFLite backends for models...");

  // find the best backend for the drawing ml
  DrawingInterpreter d = DrawingInterpreter();
  await d.init();
  final results = await d.getBestBackend();
  GetIt.I<UserData>().drawingBackend = results.item1;
  allTestResults.add(Tuple2(LocaleKeys.DrawScreen_title.tr(), results.item2));
  d.free();

  // other

  debugPrint("Finished optimizing TFLite backends for models...");
  
  await GetIt.I<UserData>().save();

  return allTestResults;

}

