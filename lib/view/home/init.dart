import 'dart:async';
import 'package:da_kanji_mobile/view/home/download_popup.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:window_manager/window_manager.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:archive/archive_io.dart';
import 'package:database_builder/database_builder.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

import 'package:da_kanji_mobile/model/DrawScreen/drawing_interpreter.dart';
import 'package:da_kanji_mobile/model/DictionaryScreen/dictionary_search.dart';
import 'package:da_kanji_mobile/model/search_history.dart';
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
import 'package:da_kanji_mobile/provider/isars.dart';



/// If the user pressed the ok-button in the download popup, this will be set to
/// true.
bool userAllowedToDownload = false;

/// Initializes the app, by initializing all the providers, services, etc.
Future<bool> init() async {

  // wait for localization to be ready
  await EasyLocalization.ensureInitialized();
  // init window Manager
  if(g_desktopPlatform)
    await windowManager.ensureInitialized();

  await initServices();

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

/// Loads all services from disk that DO NOT dpend on data in the documents
/// directory.
Future<void> initServices() async {
  Map yaml = loadYaml(await rootBundle.loadString("pubspec.yaml"));
  print("Starting DaKanji ${yaml['version']}");
  g_Version = yaml['version'];
  g_VersionNumber = g_Version.substring(0, g_Version.indexOf("+"));
  g_BuildNumber = g_Version.substring(g_Version.indexOf("+")+1);

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

  GetIt.I.registerSingleton<DrawScreenState>(DrawScreenState(
    Strokes(), KanjiBuffer(), DrawingLookup(), DrawScreenLayout.portrait)
  );

  GetIt.I.registerSingleton<KanaKit>(const KanaKit());

  GetIt.I.registerSingleton<DrawerListener>(DrawerListener());
}

/// Loads all services from disk that DO depend on data in the documents
/// directory.
Future<void> initDocumentsServices(BuildContext context) async {

  // check if the data in the documents directory is available
  await initDocumentsAssets(context);

  // ISAR / database services
  String documentsDir =
    (await path_provider.getApplicationDocumentsDirectory()).path;
  String isarPath = p.joinAll([documentsDir, "DaKanji", "assets", "dict"]);

  GetIt.I.registerSingleton<Isars>(
    Isars(
      dictionary: Isar.openSync(
        [KanjiSVGSchema, JMNEdictSchema, JMdictSchema, Kanjidic2Schema],
        directory: isarPath, name: "dictionary", maxSizeMiB: 512
      ),
      examples: Isar.openSync(
        [ExampleSentenceSchema], directory: isarPath,
        name: "examples", maxSizeMiB: 512
      ),
      searchHistory: Isar.openSync(
        [SearchHistorySchema], directory: isarPath,
        name: "searchHistory", maxSizeMiB: 512
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

  // Mecab
  GetIt.I.registerSingleton<Mecab>(Mecab());
  await GetIt.I<Mecab>().init(
    "assets/ipadic",
    true,
    dicDir: documentsDir + "/DaKanji/assets/ipadic/"
  );
}

/// Initializes the document assets, by copying the assets from the assets
/// Checks if a different version of
/// * the dictionary DB
/// * the examples DB
/// * mecab's ipadic
/// is needed for this release. If so, copy the new one from assets / donwload
/// from GitHub. The context is used for showing a popup 
Future<void> initDocumentsAssets(BuildContext context) async {

  String documentsDir =
    p.join((await path_provider.getApplicationDocumentsDirectory()).path, "DaKanji");
  List<FileSystemEntity> assets = [
    File("assets/dict/dictionary.isar"), File("assets/dict/examples.isar"), 
    Directory("assets/ipadic")
  ];

  // copy assets from assets to documents directory, or download them from GH
  for (FileSystemEntity asset in assets) {
    
    if((!File(p.joinAll([documentsDir, ...asset.uri.pathSegments])).existsSync() &&
      !Directory(p.joinAll([documentsDir, ...asset.uri.pathSegments])).existsSync()) ||
      (g_NewDictionary.contains(g_VersionNumber) && 
        GetIt.I<UserData>().dictVersionUsed != g_VersionNumber))
    {
      await getAsset(
        asset, p.joinAll([documentsDir, ...asset.uri.pathSegments]),
        g_GithubApiDependenciesRelase, context
      );
      GetIt.I<UserData>().dictVersionUsed = g_VersionNumber;
      await GetIt.I<UserData>().save();
    }
  }

}

/// Tries to copy `asset` from assets and if that fails,
/// downloads it from `url` (github). `path` is the destination folder inside of
/// `applications_documents_directory/DaKanji/` where, the file extracts the
/// zip will be extracted.
/// 
/// Note: `assetName` is expected to be a zipped file in assets/github
Future<void> getAsset(FileSystemEntity asset, String dest, String url,
  BuildContext context) async
{
  // Search and create db file destination folder if not exist
  final documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  print("documents directory: ${documentsDirectory.toString()}");

  // if the file already exists delete it
  final dbFile = File(p.joinAll([documentsDirectory.path, "DaKanji", ...asset.path.split("/")]));
  if (dbFile.existsSync()) {
    dbFile.deleteSync();
    print("Deleted ${asset.uri.pathSegments.last} ISAR");
  }
  // otherwise create the folder sstructure
  else{
    dbFile.parent.createSync(recursive: true);
  }

  try {
    await copyFromAssets(asset.path, dbFile.parent);
  }
  catch (e){
    if(!userAllowedToDownload)
      await downloadPopup(
        context: context,
        btnOkOnPress: () => userAllowedToDownload = true
      ).show();
    await downloadAssetFromGithubRelease(dbFile, url,);
  }
}

/// copies the zipped database from assets to the user's documents directory
/// and unzips it, if it does not exist already
/// 
/// Caution: throws exception if the asset does not exist
Future<void> copyFromAssets(String assetPath,  Directory dest) async {
  // Get pre-populated db file and copy it to the documents directory
  ByteData data = await rootBundle.load(assetPath);
  final archive = ZipDecoder().decodeBytes(data.buffer.asInt8List());
  extractArchiveToDisk(archive, dest.path);
}

/// Downloads the given `assetName` from the given GitHub release
Future<void> downloadAssetFromGithubRelease(File destination, String url) async 
{
  // get all releases
  Dio dio = Dio(); String downloadUrl = "";
  Response response = await dio.get(url);
  String extension = destination.uri.pathSegments.last.split(".").length > 1
    ? "." + destination.uri.pathSegments.last.split(".").last
    : "";

  // iterate over the releases
  for (var release in response.data){
    // if the version number matches the current version
    if(release["tag_name"] == "v" + g_VersionNumber){
      // iterate over the assets in this release
      for (var element in release["assets"]) {
        if((element["name"] as String).startsWith(destination.uri.pathSegments.last.replaceAll(extension, ""))) {
          downloadUrl = element["browser_download_url"];
          break;
        }
      }
    }
  }
    
  // download the asset
  await Dio().download(downloadUrl, destination.path + ".zip");
  print("Downloaded ${destination.uri.pathSegments.last} to ${destination.path}");

  // unzip the asset
  await extractFileToDisk(
    destination.path + ".zip",
    destination.parent.path
  );
  print("Extracted $destination");
  
  // delete the zip file
  File(destination.path + ".zip").deleteSync();
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

