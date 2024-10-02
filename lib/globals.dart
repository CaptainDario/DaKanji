library my_prj.globals;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:app_links/app_links.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/files/path_manager.dart';
import 'package:da_kanji_mobile/entities/releases/version.dart';
import 'package:da_kanji_mobile/init.dart';

/// the title of the app
const String g_AppTitle = "DaKanji";

/// deep link pattern (https://)
const String g_AppLinkHttps   = r"https://dakanji.app/app/";
/// deep link pattern (dakanji://)
const String g_AppLinkDaKanji = r"dakanji://";
/// Instance to catch incoming deep links
final AppLinks g_AppLinks = AppLinks();
/// Has the initial deep link been handled
bool g_initialDeepLinkHandled = false;

/// The green tone that dakanji uses
const Color g_Dakanji_green = Color.fromARGB(255, 26, 93, 71);
/// The red tone that dakanji uses
const Color g_Dakanji_red =  Color.fromARGB(255, 194, 32, 44);
/// The grey tone that dakanji uses
const Color g_Dakanji_grey =  Color.fromARGB(255, 33, 33, 33);
/// The blue tone that dakanji uses
const Color g_Dakanji_blue =  Color.fromARGB(255, 27, 3, 81);

/// The font for Japanese text
const String g_japaneseFontFamily = "NotoSansJP";

/// The key of the global navigator (material app)
GlobalKey<NavigatorState> g_NavigatorKey = GlobalKey<NavigatorState>();
/// The global key for screensaver
GlobalKey g_ScreensaverKey = GlobalKey();

// INITIALIZE APP
/// global init function feature that needs to complete before the app can be
/// started
var g_initApp = init();
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
/// all localizations that are available in DaKanji
const g_DaKanjiLocalizations = ["en", "de", "ru", "ja", "zh", "it", "fr", "es", "pl"];
/// variable that indicates if a webivew is available on this platform
final bool g_webViewSupported =
  Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
final bool g_desktopPlatform = 
  Platform.isWindows || Platform.isMacOS || Platform.isLinux;
/// browser user agent to fake a mobile device on desktop
String g_mobileUserAgentArg = 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.6045.66 Mobile Safari/537.36';


/// The minimum size of the desktop window in normal mode
const Size g_minDesktopWindowSize = Size(480, 720);

// PATHS
/// manager of frequently used paths
late PathManager g_DakanjiPathManager;

//about page
/// link to the github repo
const g_GithubRepoUrl = "https://github.com/CaptainDario/DaKanji";
/// link to the github repos issues
const g_GithubIssues = "$g_GithubRepoUrl/issues/new";
/// link to the github repos release page
const g_GithubReleasesPage = "$g_GithubRepoUrl/releases";
/// link to the latest github release
const g_GithubLatestReleasesPage = "$g_GithubRepoUrl/releases/latest";
/// the github api endpoint to query releases
const g_GithubReleasesApi = "https://api.github.com/repos/CaptainDario/DaKanji/releases";
/// lin to the github repo with dependencies needed for dakanji
const g_GithubApiDependenciesRelase = "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases";

/// link to join the discord server
const g_DiscordInvite = "https://discord.com/invite/gdqaux3r4P";

/// the base url to ANY app on the PlayStore
const g_PlaystoreBaseUrl = "https://play.google.com/store/apps/details?id=";
/// the url to the PlayStore page of Dakanji 
const g_PlaystorePage = "${g_PlaystoreBaseUrl}com.DaAppLab.DaKanjiRecognizer";
/// the base intent to open the playstore's android app
const g_PlaystoreBaseIntent =  "market://details?id=";
/// the url to DaAppLab's playstore page
const g_DaAppLabPlaystorePage = "https://play.google.com/store/apps/developer?id=DaAppLab";

/// the base url to ANY app on the AppStore
const g_AppStoreBaseUrl = "itms-apps://itunes.apple.com/app/";
/// DaKanji's ID on the AppStore
const g_AppStoreId = "1593741764";
/// link to DaKanji's appstore page
const g_AppStorePage = "https://apps.apple.com/de/app/DaKanji/id$g_AppStoreId";
///the url to developer's AppStore page
const g_DaAppLabAppStorepage = "https://apps.apple.com/us/developer/dario-klepoch/id1193537491";

/// DaKanji's ID on the MicrosoftStore
const g_MicrosoftStoreId = "9n08051t2xtv";
/// the url to the MicrosoftStore page of Dakanji 
const g_MicrosoftStorePage = "https://www.microsoft.com/p/dakanji/$g_MicrosoftStoreId";
/// uri to open DaAppLab's page in the Microsoft store 
const g_MicrosoftStoreDaAppLabPage = "ms-windows-store://publisher/?name=DaAppLab";

/// the url to the SnapStore page of Dakanji 
const g_SnapStorePage = "https://snapcraft.io/dakanji";
/// DaAppLab page in the snap store
const g_SnapStoreDaAppLabPage = "";
/// Link to the flatpak store
const g_FlatpakStorePage = g_GithubReleasesPage;

/// id of the takoboto package on android
const g_TakobotoId = "jp.takoboto";
/// id of the akebi package on android
const g_AkebiId = "com.craxic.akebifree";
/// id of the aedict package on android
const g_AedictId = "sk.baka.aedict3";
/// id of the google translate package on android
const g_GoogleTranslateId = "com.google.android.apps.translate";

/// id of the shirabe package on ios
const g_ShirabeId = "id1005203380";
/// id of the imiwa on ios
const g_ImiwaId = "id288499125";
/// id of the japanese on ios
const g_JapaneseId = "id290664053";
/// id of the midori on ios
const g_MidoriId = "id385231773";


/// url to the privacy police of DaKanji
const g_PrivacyPoliceUrl = "https://dakanji.app/dakanji-app-privacy-policy/";

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

/// AutoSizeGroup for the settings screen -> all list entries have same font size
AutoSizeGroup g_SettingsAutoSizeGroup = AutoSizeGroup();
/// AutoSizeGroup for the drawer -> all list entries have same font size
AutoSizeGroup g_DrawerAutoSizeGroup = AutoSizeGroup();
/// Global minimum font size for autosizing texts
double g_MinFontSize = 8;

/// Some japanese sample text
const String g_SampleText = """東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。

慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。
身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。

新海誠監督長編アニメーション『君の名は。』の世界を掘り下げる、スニーカー文庫だけの特別編。""";
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
