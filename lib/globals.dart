library my_prj.globals;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


/// the title of the app
const String g_AppTitle = "DaKanji";

/// deep link pattern
const String g_AppLink = r"dakanji://dakanji/";

/// the version number of this app
String g_Version = "";
/// Minimum number of app starts until the user gets the option to never show
/// the rate dialogue again
const int g_MinTimesOpenedToAsknotShowRate = 51;
/// all versions which implemented new features for the drawing screen
// ignore: non_constant_identifier_names
List<String> g_DrawingScreenNewFeatures = ["0.0.1", "1.0.0", "1.1.0", "2.1.0"];
/// all versions which implemented new pages for the OnBoarding
// ignore: non_constant_identifier_names
List<String> g_OnboardingNewPages = ["0.0.0", "2.0.0"];
/// all localizations that are available in DaKanji
const g_DaKanjiLocalizations = ["en", "de", "ru", "ja", "zh", "it", "fr", "es", "pl"];
/// variable that indicates if a webivew is available on this platform
final bool g_webViewSupported =
  Platform.isWindows || Platform.isAndroid || Platform.isIOS || kIsWeb;
final bool g_desktopPlatform = 
  Platform.isWindows || Platform.isMacOS || Platform.isLinux;
/// browser user agent to fake a mobile device on desktop
String mobileUserAgentArg = '--user-agent="Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36"';

/// is the app running to test the drawscreen
bool g_IsTestingDrawscreen = false;
/// is the app running to test the app startup situations
bool g_IsTestingAppStartup = false;
/// is the app running to test the misc. settings
bool g_IsTestingSettings = false;
/// is the app running to test if the onboarding shows again if there are new
/// pages added to it
bool g_IsTestingAppStartupOnboardingNewFeatures = false;
/// is the app running to test if the DrawScreen tutorial shows again if there are new
/// points added to it
bool g_IsTestingAppStartupDrawscreenNewFeatures = false;


//about page
/// link to the github repo
const g_GithubRepoUrl = "https://github.com/CaptainDario/DaKanji";
/// link to the github repos issues
const g_GithubIssues = g_GithubRepoUrl + "/issues/new";
/// link to the github repos release page
const g_GithubReleasesPage = g_GithubRepoUrl + "/releases";

/// link to join the discord server
const g_DiscordInvite = "https://discord.com/invite/gdqaux3r4P";

/// the base url to ANY app on the PlayStore
const g_PlaystoreBaseUrl = "https://play.google.com/store/apps/details?id=";
/// the url to the PlayStore page of Dakanji 
const g_PlaystorePage = g_PlaystoreBaseUrl + "com.DaAppLab.DaKanjiRecognizer";
/// the base intent to open the playstore's android app
const g_PlaystoreBaseIntent =  "market://details?id=";
/// the url to DaAppLab's playstore page
const g_DaAppLabPlaystorePage = "https://play.google.com/store/apps/developer?id=DaAppLab";

/// the base url to ANY app on the AppStore
const g_AppStoreBaseUrl = "itms-apps://itunes.apple.com/app/";
/// DaKanji's ID on the AppStore
const g_AppStoreId = "1593741764";
/// link to DaKanji's appstore page
const g_AppStorePage = "https://apps.apple.com/de/app/DaKanji/id" + g_AppStoreId;
///the url to developer's AppStore page
const g_DaAppLabAppStorepage = "https://apps.apple.com/us/developer/dario-klepoch/id1193537491";

/// DaKanji's ID on the MicrosoftStore
const g_MicrosoftStoreId = "9n08051t2xtv";
/// the url to the MicrosoftStore page of Dakanji 
const g_MicrosoftStorePage = "https://www.microsoft.com/p/dakanji/" + g_MicrosoftStoreId;
/// uri to open DaAppLab's page in the Microsoft store 
const g_MicrosoftStoreDaAppLabPage = "ms-windows-store://publisher/?name=DaAppLab";

/// the url to the SnapStore page of Dakanji 
const g_SnapStorePage = "https://snapcraft.io/dakanji";
/// DaAppLab page in the snap store
const g_SnapStoreDaAppLabPage = "";

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
const g_PrivacyPoliceUrl = "https://sites.google.com/view/dakanjirecognizerprivacypolicy";

/// LINKS
/// Link to japanese wikipedia
const g_WikipediaJpUrl = "https://ja.wikipedia.org/wiki/";
/// Link to english wikipedia
const g_WikipediaEnUrl = "https://en.wikipedia.org/wiki/";
/// Link to DBPedia
const g_DbpediaUrl = "https://dbpedia.org/page/";
/// Link to Wiktionary
const g_WiktionaryUrl = "https://en.wiktionary.org/wiki/";
/// Link to search on Massif.la
const g_Massif = "https://massif.la/ja/search?q=";
/// Link to search for an images on google image search
const g_GoogleImgSearchUrl = "https://www.google.com/search?tbm=isch&q=";
/// url to look up a word in deepL 
const g_deepLUrl = "https://www.deepl.com/en/translator#ja/en/";
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
const String g_SampleText = """第二王子の成人と共に王太子が決まる大事な時期に、婚約者である第一王子から「少しの間、自由が欲しい」と言われて困惑した。あと二ヶ月しかないのに、ルエラが教育や社交などを放棄してしまえば、王太子には第二王子が選ばれることになる。

そう説明しようとしたが、口の中が痺れてきた。何かがおかしいと思ったが、目の前が突然真っ暗になった。

目を開ければ、そこは自分の部屋だった。どうやら王家の秘毒を飲まされたようだ。婚約者に毒を盛られたことで気持ちが一気に冷めた。しかも毒の副作用なのか、体に痺れが残っていた。毒の後遺症が残り、婚約は白紙に戻された。""";