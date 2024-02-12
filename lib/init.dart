// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';
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
import 'package:da_kanji_mobile/entities/search_history/search_history.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/tf_lite/inference_backend.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_tree.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/repositories/analytics/event_logging.dart';

/// Initializes the app, by initializing all the providers, services, etc.
Future<bool> init() async {

  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();

  g_DakanjiPathManager = PathManager();
  await g_DakanjiPathManager.init();

  await initServices();

  // init window Manager
  if(g_desktopPlatform) {
    await windowManager.ensureInitialized();
    desktopWindowSetup();
  }

  // deep links
  await initDeepLinksStream();

  // media kit
  MediaKit.ensureInitialized();  

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

  WordListsTree wL = WordListsTree();
  wL.load();
  GetIt.I.registerSingleton<WordListsTree>(wL);

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

  GetIt.I.registerSingleton<Stats>(Stats(uD)..init());

}

/// Loads all services from disk that DO depend on data in the documents
/// directory.
Future<void> initDocumentsServices(BuildContext context) async {

  if(g_documentsServicesInitialized) return;

  // check if the data in the documents directory is available
  await initDocumentsAssets(context);

  // ISAR / database services
  String documentsDir = g_DakanjiPathManager.documentsDirectory.path;
  String isarPath = g_DakanjiPathManager.dictionaryDirectory.path;
  String dojgIsarPath = g_DakanjiPathManager.dojgDirectory.path;
  GetIt.I.registerSingleton<Isars>(
    Isars(
      dictionary: Isar.getInstance("dictionary") ?? Isar.openSync(
        [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
        directory: isarPath, name: "dictionary", maxSizeMiB: 512
      ),
      examples: Isar.getInstance("examples") ?? Isar.openSync(
        [ExampleSentenceSchema], directory: isarPath,
        name: "examples", maxSizeMiB: 512
      ),
      searchHistory: Isar.getInstance("searchHistory") ?? Isar.openSync(
        [SearchHistorySchema], directory: isarPath,
        name: "searchHistory", maxSizeMiB: 512
      ),
      krad: Isar.getInstance("krad") ?? Isar.openSync(
        [KradSchema], directory: isarPath,
        name: "krad", maxSizeMiB: 512
      ),
      radk: Isar.getInstance("radk") ?? Isar.openSync(
        [RadkSchema], directory: isarPath,
        name: "radk", maxSizeMiB: 512
      ),
      dojg: GetIt.I<UserData>().dojgImported && Directory(dojgIsarPath).existsSync()
        ? Isar.getInstance("dojg") ?? Isar.openSync(
          [DojgEntrySchema], directory: dojgIsarPath, name: "dojg"
        )
        : null
    )
  );

  GetIt.I.registerSingleton<DictionarySearch>(
    DictionarySearch(
      GetIt.I<Settings>().advanced.noOfSearchIsolates,
      GetIt.I<Settings>().dictionary.selectedTranslationLanguages.map((e) => 
        isoToiso639_2B[e]!.name
      ).toList(),
      GetIt.I<Isars>().dictionary.directory!,
      GetIt.I<Isars>().dictionary.name,
      GetIt.I<Settings>().dictionary.convertToHiragana
    ), dispose: (param) => param.kill(),
  );
  await GetIt.I<DictionarySearch>().init();

  // Mecab
  GetIt.I.registerSingleton<Mecab>(Mecab());
  await GetIt.I<Mecab>().init(
    "assets/ipadic",
    true,
    dicDir: "$documentsDir/DaKanji/assets/ipadic/"
  );

  g_documentsServicesInitialized = true;
}

/// Initializes the document assets, by copying the assets from the assets
/// Checks if a different version of
/// * the dictionary DB
/// * the examples DB
/// * mecab's ipadic
/// is needed for this release. If so, copy the new one from assets / donwload
/// from GitHub. The context is used for showing a popup 
Future<void> initDocumentsAssets(BuildContext context) async {

  String documentsDir = g_DakanjiPathManager.dakanjiDocumentsDirectory.path;
  debugPrint("documents directory: ${documentsDir.toString()}");

  // copy assets from assets to documents directory, or download them from GH
  bool downloadAllowed = false;

  List<FileSystemEntity> assets = [
    "assets/dict/dictionary.isar",
    "assets/dict/examples.isar",
    "assets/dict/krad.isar",
    "assets/dict/radk.isar",
    "assets/ipadic"
  ].map((f) => File(f)).toList();

  for (var asset in assets) {
    if(!checkAssetExists(documentsDir, asset)
      || asset == assets[0] && GetIt.I<UserData>().getNewDict //dict
      || asset == assets[1] && GetIt.I<UserData>().getNewExamples //examples
      || asset == assets[2] && GetIt.I<UserData>().getNewRadicals // krad
      || asset == assets[3] && GetIt.I<UserData>().getNewRadicals // radk
    ){
      await getAsset(
        asset, p.joinAll([documentsDir, ...asset.uri.pathSegments]),
        g_GithubApiDependenciesRelase, context, !downloadAllowed
      );
      downloadAllowed = true;
    }
  }

}

/// Checks if an `asset` exists in the `documentsDir` Returns
/// true if `asset` exists in the `documentsDir`
/// false otherwise 
bool checkAssetExists(String documentsDir, FileSystemEntity asset){

  return !(!File(p.joinAll([documentsDir, ...asset.uri.pathSegments])).existsSync() &&
    !Directory(p.joinAll([documentsDir, ...asset.uri.pathSegments])).existsSync());

}

/// Setup the DaKanji window on desktop platforms
void desktopWindowSetup() {
  
  if(kReleaseMode) windowManager.center();

  windowManager.setMinimumSize(g_minDesktopWindowSize);
  windowManager.setTitle(g_AppTitle);
  
  windowManager.setSize(Size(
    GetIt.I<Settings>().misc.windowWidth.toDouble(), 
    GetIt.I<Settings>().misc.windowHeight.toDouble()
  ));

  if(kReleaseMode) windowManager.center();

  windowManager.setOpacity(GetIt.I<Settings>().misc.windowOpacity);
  windowManager.setAlwaysOnTop(GetIt.I<Settings>().misc.alwaysOnTop);
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

