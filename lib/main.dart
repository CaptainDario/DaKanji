import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
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
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

import 'package:da_kanji_mobile/model/DrawScreen/drawing_interpreter.dart';
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

  // initialize the app
  WidgetsFlutterBinding.ensureInitialized();

  // delete settings
  //await clearPreferences();

  await SentryFlutter.init(
    (options) {
      options.dsn = '';
    },
    appRunner: () => runApp(
      FutureBuilder(
        future: init(),
        builder: (context, snapshot) {

          if(!snapshot.hasData)
            return DaKanjiSplash();

          else
            return EasyLocalization(
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
            );
        }
      )
    )
  );
  

}

/// Initializes the app, by initializing all the providers, services, etc.
Future<bool> init() async {

  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();
  // init window Manager
  if(g_desktopPlatform)
    await windowManager.ensureInitialized();

  // read the applications version from pubspec.yaml
  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  print("Starting DaKanji ${yaml['version']}");
  g_Version = yaml['version'];

  await initGetIt();

  if(Platform.isAndroid || Platform.isIOS){
    await initDeepLinksStream();
    await getInitialDeepLink();
  }
  if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
    desktopWindowSetup();
  }

  await testTFLiteBackendsForModels();

  return true;
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

  // package for converting between hiragana <-> katakana
  GetIt.I.registerSingleton<KanaKit>(const KanaKit());

  // ISAR / database services
  await setupIsarFiles();

  String documentsDir =
    (await path_provider.getApplicationDocumentsDirectory()).path;
  String isarPath = p.joinAll([documentsDir, "DaKanji", "isar"]);

  GetIt.I.registerSingleton<Isars>(
    Isars(
      dictionary: Isar.openSync(
        [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
        directory: isarPath,
        name: "dictionary",
        maxSizeMiB: 512
      ),
      examples: Isar.openSync(
        [ExampleSentenceSchema],
        directory: isarPath,
        name: "examples",
        maxSizeMiB: 512
      ),
      searchHistory: Isar.openSync(
        [SearchHistorySchema],
        directory: isarPath,
        name: "searchHistory",
        maxSizeMiB: 512
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

/// Checks if a different version of
/// * the dictionary DB
/// * the examples DB
/// * mecab's ipadic
/// is needed for this release. If so, copy the new one from assets / donwload
/// from GitHub.
Future<void> setupIsarFiles() async {

  // ISAR / database services
  String documentsDir =
    (await path_provider.getApplicationDocumentsDirectory()).path;
  String isarPath = p.joinAll([documentsDir, "DaKanji", "isar"]);

  // check if a different version of the dictionary DB is needed for this release
  // if so, copy the new one from assets / donwload from GH.
  if(!File(p.joinAll([isarPath, "dictionary.isar"])).existsSync() ||
    g_NewDictionary.contains(g_Version) && GetIt.I<UserData>().newVersionUsed)
  {
    await getAsset(File("assets/dict/dictionary.isar"), p.joinAll([isarPath, "dictionary.isar"]));
  }

  // check if a different version of the examples DB is needed for this release
  // if so, copy the new one from assets / donwload from GH
  //if(g_NewExamples.contains(g_Version) ||
  //  !File(p.joinAll([isarPath, "examples.isar"])).existsSync())
  //  await copyDictionaryFilesFromAssets('examples');

  // TODO: mecab ipadic

}

/// Tries to copy `assetName` from assets and if that fails,
/// downloads from github. `path` is the destination folder inside of
/// `applications_documents_directory/DaKanji/`.
/// 
/// Note: `assetName` is expected to be a zipped file in assets/github
Future<void> getAsset(File asset, String dest) async {
  // Search and create db file destination folder if not exist
  final documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  print("documents directory: ${documentsDirectory.toString()}");
  final databaseDirectory = Directory(
    p.joinAll([documentsDirectory.path, "DaKanji", dest])
  );

  // if the file already exists delete it
  final dbFile = File(p.joinAll([databaseDirectory.path, asset.uri.pathSegments.last]));
  if (dbFile.existsSync()) {
    dbFile.deleteSync();
    print("Deleted ${asset.uri.pathSegments.last} ISAR");
  }

  try {
    await copyFromAssets(asset, databaseDirectory);
  }
  catch (e){
    await downloadAsset(asset.uri.pathSegments.last, databaseDirectory);
  }
}

/// copies the zipped database from assets to the user's documents directory
/// and unzips it, if it does not exist already
/// 
/// Caution: throws exception if the asset does not exist
Future<void> copyFromAssets(File asset,  Directory dest) async {
  // Get pre-populated db file and copy it to the documents directory
  ByteData data = await rootBundle.load(asset.path);
  final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());
  extractArchiveToDisk(archive, dest.path);
}

/// Downloads the given `assetName` from the given GitHub release
Future<void> downloadAsset(String assetName, 
  String url,
  Directory destinationDirectory,
  {String releaseName = "latest"}) async 
{
  await Dio().download("", destinationDirectory.path);
  print("Downloaded ${assetName} to ${destinationDirectory.path}");
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

/// Tests all TF Lite models for the backends that are available on the device
/// This is done by loading the model and running a dummy input through it.
/// The results are stored in UserData, so that this function does not need to
/// be called only once.
Future<void> testTFLiteBackendsForModels() async {

  if(GetIt.I<UserData>().drawingBackend == null){
    DrawingInterpreter d = DrawingInterpreter();
    await d.init();
    await d.getBestBeckend();
  }

}

