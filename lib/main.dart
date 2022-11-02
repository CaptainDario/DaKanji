import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaml/yaml.dart';
import 'package:isar/isar.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:universal_io/io.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:window_size/window_size.dart';
import 'package:database_builder/database_builder.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:archive/archive_io.dart';
import 'package:feedback/feedback.dart';
import 'package:database_builder/src/jm_enam_and_dict_to_Isar/data_classes.dart' as isar_entry;
import 'package:database_builder/src/kanjiVG_to_Isar/data_classes.dart' as isar_kanji;

import 'package:da_kanji_mobile/dakanji_splash.dart';
import 'package:da_kanji_mobile/dakanji_app.dart';
import 'package:da_kanji_mobile/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/model/DrawScreen/drawing_interpreter.dart';
import 'package:da_kanji_mobile/helper/deep_links.dart';
import 'package:da_kanji_mobile/model/DrawScreen/draw_screen_state.dart';
import 'package:da_kanji_mobile/model/DrawScreen/draw_screen_layout.dart';
import 'package:da_kanji_mobile/model/changelog.dart';
import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:da_kanji_mobile/provider/drawing/drawing_lookup.dart';
import 'package:da_kanji_mobile/provider/drawing/strokes.dart';
import 'package:da_kanji_mobile/provider/drawing/kanji_buffer.dart';
import 'package:da_kanji_mobile/model/user_data.dart';
import 'package:da_kanji_mobile/model/platform_dependent_variables.dart';
import 'package:da_kanji_mobile/provider/drawer_listener.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/codegen_loader.dart';
import 'package:da_kanji_mobile/feedback_localization.dart';



Future<void> main() async {
  
  runApp(
    DaKanjiSplash()
  );

  // initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();

  await init();

  
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
            CustomFeedbackLocalizationsDelegate(),
          ],
          mode: FeedbackMode.navigate,
          child: const DaKanjiApp(),
        ),
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
  
  // NOTE: uncomment to clear the SharedPreferences
  //await clearPreferences();

  // read the applications version from pubspec.yaml
  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  debugPrint(yaml['version']);
  g_Version = yaml['version'];  

  await copyDatabaseFilesFromAssets();

  await initGetIt();

  if(Platform.isAndroid || Platform.isIOS){
    await initDeepLinksStream();
    await getInitialDeepLink();
  }
  if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
    desktopWindowSetup();
  }
}

/// Download the objectbox databases, TF Lite models, ... and store them
/// on disk
Future<void> downloadAssets() async {
  
  
  
}

Future<void> copyDatabaseFilesFromAssets() async {
  // Search and create db file destination folder if not exist
  final documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  final objectBoxDirectory = Directory(documentsDirectory.path + "/objectbox");
  
  if (!objectBoxDirectory.existsSync()) {
    await objectBoxDirectory.create(recursive: true);
  }

  final dbFile = File(objectBoxDirectory.path + '/data.mdb');
  if (!dbFile.existsSync()) {
    // Get pre-populated db file.
    ByteData data = await rootBundle.load("assets/dict/data.zip");

    final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());

    // Copying source data into destination file.
    extractArchiveToDisk(archive, objectBoxDirectory.path);
  }
}

/// Convenience function to clear the SharedPreferences
Future<void> clearPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  debugPrint("CLEARED PREFERENCES AT APP START.");
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
  
  // inference services
  GetIt.I.registerSingleton<DrawingInterpreter>(DrawingInterpreter());

  // draw screen services 
  GetIt.I.registerSingleton<DrawScreenState>(DrawScreenState(
    Strokes(), KanjiBuffer(), DrawingLookup(), DrawScreenLayout.portrait)
  );

  // tutorial services
  GetIt.I.registerSingleton<Tutorials>(Tutorials());
  
  // Kagome
  GetIt.I.registerSingleton<Kagome>(Kagome());

  // package for converting between kana
  GetIt.I.registerSingleton<KanaKit>(const KanaKit());

  // ObjectBox
  Store store = openStore(
    directory: (await path_provider.getApplicationDocumentsDirectory()).path + "/objectbox"
  );
  //GetIt.I.registerSingleton<Box<Entry>>(store.box<Entry>());
  //GetIt.I.registerSingleton<Box<KanjiSVG>>(store.box<KanjiSVG>());
  GetIt.I.registerSingleton<Box<Kanjidic2Entry>>(store.box<Kanjidic2Entry>());

  String path = (await path_provider.getApplicationDocumentsDirectory()).path + "/isar";

  await compute(openIsarInIsolate, path).then((value) {
    GetIt.I.registerSingleton<Isar>(
      Isar.openSync(
        [isar_kanji.KanjiSVGSchema, isar_entry.EntrySchema],
        directory: path
      )
    );
  });
  

  // Drawer
  GetIt.I.registerSingleton<DrawerListener>(DrawerListener());
}

/// Setup the DaKanji window on desktop platforms
void desktopWindowSetup() {
  setWindowMinSize(const Size(480, 720));
  setWindowTitle(g_AppTitle);
  
  setWindowFrame(
    Rect.fromLTWH(
      0,
      0, 
      GetIt.I<Settings>().misc.windowWidth.toDouble(), 
      GetIt.I<Settings>().misc.windowHeight.toDouble()
    )
  );
}

/// Opens the ISAR dictionary database in an isolate to prevent the UI-isolate
/// from being blocked.
void openIsarInIsolate(String directory) {
  Isar.openSync(
    [isar_kanji.KanjiSVGSchema, isar_entry.EntrySchema],
    directory: directory
  );
}
