library my_prj.globals;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:app_links/app_links.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:universal_io/io.dart';
import 'package:da_kanji_mobile/core/storage/path_manager.dart';

// Project imports:
import 'package:da_kanji_mobile/core/releases/version.dart';
import 'package:da_kanji_mobile/features/init/controller/init.dart';
import 'package:language_processing/language_processing.dart';
import 'package:da_kanji_mobile/core/app/app_config.dart';


/// the app config (specialized per language/app)
late AppConfig g_AppConfig;

/// Instance to catch incoming deep links
final AppLinks g_AppLinks = AppLinks();
/// Has the initial deep link been handled
bool g_initialDeepLinkHandled = false;

/// The green tone that the app uses
const Color g_color_scheme_green = Color.fromARGB(255, 26, 93, 71);
/// The red tone that the app uses
const Color g_color_scheme_red =  Color.fromARGB(255, 194, 32, 44);
/// The grey tone that the app uses
const Color g_color_scheme_grey =  Color.fromARGB(255, 33, 33, 33);
/// The blue tone that the app uses
const Color g_color_scheme_blue =  Color.fromARGB(255, 4, 62, 120);

/// The key of the global navigator (material app)
GlobalKey<NavigatorState> g_NavigatorKey = GlobalKey<NavigatorState>();
/// The global key for screensaver
GlobalKey g_ScreensaverKey = GlobalKey();

// INITIALIZE APP
/// global init function feature that needs to complete before the app can be
/// started
late Future<bool> g_initApp;
/// have the documents services been initialized
bool g_documentsServicesInitialized = false;
/// The progress of initializing the app
StreamController<String> g_initAppInfoStream = StreamController<String>.broadcast();

/// the complete version number of this app: version + build number
Version g_Version = Version(0, 0, 0);
/// Minimum number of app starts until the user gets the option to never show
/// the rate dialogue again
const int g_MinTimesOpenedToAsknotShowRate = 401;
/// How often does the app need to be opened to ask the user to rate the app
const int g_AskRateAfterEach = 20;
/// The amount of days to wait before asking the user to update the app again
const int g_daysToWaitBeforeAskingForUpdate = 14;
/// all versions which implemented new features for the drawing screen
List<Version> g_DrawingScreenNewFeatures = [
  Version(0, 0, 1), Version(1, 0, 0), Version(1, 0, 0), Version(1, 1, 0), Version(2, 1, 0)
];
/// all versions which implemented new pages for the OnBoarding
List<Version> g_OnboardingNewPages = [
  Version(0, 0, 0), Version(2, 0, 0), Version(3, 0, 0), Version(3, 3, 0)
];
/// all versions that implemented new dictionary versions (ISAR DB)
List<Version> g_NewDictionary = [
  Version(3, 0, 0, build: 47), 
  Version(3, 1, 0, build: 51), Version(3, 1, 0, build: 52), Version(3, 1, 0, build: 53), Version(3, 1, 0, build: 56), 
  Version(3, 3, 0, build: 76)
];
/// all versions that implemented new examples versions (ISAR DB)
List<Version> g_NewExamples = [
  Version(3, 0, 0, build: 47),
  Version(3, 3, 0, build: 76)
];
/// all versions that implemented new radiclas data (ISAR DB)
List<Version> g_NewRadicals = [
  Version(3, 1, 0),
  Version(3, 2, 0, build: 67),
  Version(3, 3, 0, build: 76)
];
/// Versions that require to setup the anki integration again
List<Version> g_ResetAnki = [
  Version(3, 5, 0), Version(3, 5, 1), Version(3, 5, 2), Version(3, 5, 3)
];

// TODO remove for v4
/// The maxMiB size of the dictionary isar
int g_IsarDictMaxMiB = Platform.isIOS ? 384 : 512;
/// The maxMiB size of the examples isar
int g_IsarExampleMaxMiB = Platform.isIOS ? 384 : 512;

/// all localizations that are available in DaKanji
const g_DaKanjiLocalizations = [
  Iso639_3.eng, Iso639_3.deu, Iso639_3.rus, Iso639_3.jpn,
  Iso639_3.zho, Iso639_3.ita, Iso639_3.fra, Iso639_3.spa, Iso639_3.pol
];

/// variable that indicates if a webivew is available on this platform
late bool g_webViewSupported;

/// variable that is true if app is running on a desktop platform
final bool g_desktopPlatform = 
  Platform.isWindows || Platform.isMacOS || Platform.isLinux;

/// browser user agent to fake a mobile device on desktop
String g_mobileUserAgentArg = 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.6045.66 Mobile Safari/537.36';


/// The minimum size of the desktop window in normal mode
const Size g_minDesktopWindowSize = Size(480, 720);

// PATHS
/// manager of frequently used paths
late PathManager g_DakanjiPathManager;

/// the url to DaAppLab's playstore page
const g_DaAppLabPlaystorePage = "https://play.google.com/store/apps/developer?id=DaAppLab";

///the url to developer's AppStore page
const g_DaAppLabAppStorepage = "https://apps.apple.com/us/developer/dario-klepoch/id1193537491";

/// uri to open DaAppLab's page in the Microsoft store 
const g_MicrosoftStoreDaAppLabPage = "ms-windows-store://publisher/?name=DaAppLab";

/// DaAppLab page in the snap store
const g_SnapStoreDaAppLabPage = "";

// TODO remove
/// id of the takoboto package on android
const g_TakobotoId = "jp.takoboto";
/// id of the akebi package on android
const g_AkebiId = "com.craxic.akebifree";
/// id of the aedict package on android
const g_AedictId = "sk.baka.aedict3";
/// id of the google translate package on android
const g_GoogleTranslateId = "com.google.android.apps.translate";

// TODO remove
/// id of the shirabe package on ios
const g_ShirabeId = "id1005203380";
/// id of the imiwa on ios
const g_ImiwaId = "id288499125";
/// id of the japanese on ios
const g_JapaneseId = "id290664053";
/// id of the midori on ios
const g_MidoriId = "id385231773";

// TODO migrate to language agnostic system
/// LINKS
/// URL to japanese wikipedia
const g_WikipediaJpUrl = "https://ja.wikipedia.org/wiki/";
/// URL to english wikipedia
const g_WikipediaEnUrl = "https://en.wikipedia.org/wiki/";
/// URL to DBPedia
const g_DbpediaUrl = "https://www.dbpedia.org/?s=";
/// URL to Wiktionary
const g_WiktionaryUrl = "https://en.wiktionary.org/wiki/";
/// URL to search on Massif.la
const g_Massif = "https://massif.la/ja/search?q=";
/// URL to search on forvo.com
const g_forvo = "https://forvo.com/word/";
/// URL to search for an images on google image search
const g_GoogleImgSearchUrl = "https://www.google.com/search?tbm=isch&q=";
/// url to look up a word in deepL 
const g_deepLUrl = "https://www.deepl.com/en/translator#ja/en-us/";
/// url to open a kanji in thekanjimap.com
const g_theKanjiMapUrl = "https://thekanjimap.com/";
/// url to open a kanji in japanesegraph.com
const g_japaneseGraphUrl = "https://japanesegraph.com/";


/// The header that is included in every KanjiVG file
const String kanjiVGHeader = """
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd" [
<!ATTLIST g
xmlns:kvg CDATA #FIXED "http://kanjivg.tagaini.net"
kvg:element CDATA #IMPLIED
kvg:variant CDATA #IMPLIED
kvg:partial CDATA #IMPLIED
kvg:original CDATA #IMPLIED
kvg:part CDATA #IMPLIED
kvg:number CDATA #IMPLIED
kvg:tradForm CDATA #IMPLIED
kvg:radicalForm CDATA #IMPLIED
kvg:position CDATA #IMPLIED
kvg:radical CDATA #IMPLIED
kvg:phon CDATA #IMPLIED >
<!ATTLIST path
xmlns:kvg CDATA #FIXED "http://kanjivg.tagaini.net"
kvg:type CDATA #IMPLIED >
]>
<svg xmlns="http://www.w3.org/2000/svg" width="109" height="109" viewBox="0 0 109 109">
<g id="kvg:StrokePaths_09b31" style="fill:none;stroke:#000000;stroke-width:3;stroke-linecap:round;stroke-linejoin:round;">
""";
