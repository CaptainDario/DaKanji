library my_prj.globals;

import 'package:auto_size_text/auto_size_text.dart';


/// the title of the app
const String globalAppTitle = "DaKanji";

/// deep link pattern
const String globalAppLink = r"dakanji://dakanji/";

/// the version number of this app
String globalVersion = "";
/// Minimum number of app starts until the user gets the option to never show
/// the rate dialogue again
const int globalMinTimesOoenedToAsknotShowRate = 51;
/// all versions which implemented new features for the drawing screen
// ignore: non_constant_identifier_names
List<String> globalDrawingScreenNewFeatures = ["0.0.1", "1.0.0", "1.1.0", "2.1.0"];
/// all versions which implemented new pages for the OnBoarding
// ignore: non_constant_identifier_names
List<String> globalgOnboardingNewPages = ["0.0.0", "2.0.0"];
/// all languages which are supported in DaKanji
const globalDaKanjiLocalizations = ["en", "de", "ru", "ja", "zh", "it", "fr", "es", "pl"];


/// is the app running to test the drawscreen
bool globalIsTestingDrawscreen = false;
/// is the app running to test the app startup situations
bool globalIsTestingAppStartup = false;
/// is the app running to test the misc. settings
bool globalIsTestingSettings = false;
/// is the app running to test if the onboarding shows again if there are new
/// pages added to it
bool globalIsTestingAppStartupOnboardingNewFeatures = false;
/// is the app running to test if the DrawScreen tutorial shows again if there are new
/// points added to it
bool globalIsTestingAppStartupDrawscreenNewFeatures = false;


//about page
/// link to the github repo
const globalGithubRepoUrl = "https://github.com/CaptainDario/DaKanji";
/// link to the github repos issues
const globalGithubIssues = globalGithubRepoUrl + "/issues/new";
/// link to the github repos release page
const globalGithubReleasesPage = globalGithubRepoUrl + "/releases";

/// link to join the discord server
const globalDiscordInvite = "https://discord.com/invite/gdqaux3r4P";

/// the base url to ANY app on the PlayStore
const globalPlaystoreBaseUrl = "https://play.google.com/store/apps/details?id=";
/// the url to the PlayStore page of Dakanji 
const globalPlaystorePage = globalPlaystoreBaseUrl + "com.DaAppLab.DaKanjiRecognizer";
/// the base intent to open the playstore's android app
const globalPlaystoreBaseIntent =  "market://details?id=";
/// the url to DaAppLab's playstore page
const globalDaAppLabPlaystorePage = "https://play.google.com/store/apps/developer?id=DaAppLab";

/// the base url to ANY app on the AppStore
const globalAppStoreBaseUrl = "itms-apps://itunes.apple.com/app/";
/// DaKanji's ID on the AppStore
const globalAppStoreId = "1593741764";
/// link to DaKanji's appstore page
const globalAppStorePage = "https://apps.apple.com/de/app/DaKanji/id" + globalAppStoreId;
///the url to developer's AppStore page
const globalDaAppLabAppStorepage = "https://apps.apple.com/us/developer/dario-klepoch/id1193537491";

/// DaKanji's ID on the MicrosoftStore
const globalMicrosoftStoreId = "9n08051t2xtv";
/// the url to the MicrosoftStore page of Dakanji 
const globalMicrosoftStorePage = "https://www.microsoft.com/p/dakanji/" + globalMicrosoftStoreId;
/// uri to open DaAppLab's page in the Microsoft store 
const globalMicrosoftStoreDaAppLabPage = "ms-windows-store://publisher/?name=DaAppLab";

/// the url to the SnapStore page of Dakanji 
const globalSnapStorePage = "https://snapcraft.io/dakanji";
/// DaAppLab page in the snap store
const globalSnapStoreDaAppLabPage = "";

/// id of the takoboto package on android
const globalTakobotoId = "jp.takoboto";
/// id of the akebi package on android
const globalAkebiId = "com.craxic.akebifree";
/// id of the aedict package on android
const globalAedictId = "sk.baka.aedict3";
/// id of the google translate package on android
const globalGoogleTranslateId = "com.google.android.apps.translate";

/// id of the shirabe package on ios
const globalShirabeId = "id1005203380";
/// id of the imiwa on ios
const globalImiwaId = "id288499125";
/// id of the japanese on ios
const globalJapaneseId = "id290664053";
/// id of the midori on ios
const globalMidoriId = "id385231773";


/// url to the privacy police of DaKanji
const globalPrivacyPoliceUrl = "https://sites.google.com/view/dakanjirecognizerprivacypolicy";

/// LINKS
/// Link to japanese wikipedia
const globalWikipediaJpUrl = "https://ja.wikipedia.org/wiki/";
/// Link to english wikipedia
const globalWikipediaEnUrl = "https://en.wikipedia.org/wiki/";
/// Link to DBPedia
const globalDbpediaUrl = "https://dbpedia.org/page/";
/// Link to Wiktionary
const globalWiktionaryUrl = "https://en.wiktionary.org/wiki/";
/// Link to search for an images on google image search
const globalGoogleImgSearchUrl = "https://www.google.com/search?tbm=isch&q=";

/// AutoSizeGroup for the settings screen -> all list entries have same font size
AutoSizeGroup globalSettingsAutoSizeGroup = AutoSizeGroup();
/// AutoSizeGroup for the drawer -> all list entries have same font size
AutoSizeGroup globalDrawerAutoSizeGroup = AutoSizeGroup();
/// Global minimum font size for autosizing texts
double globalMinFontSize = 8;

/// Some japanese sample text
const String globalSampleText = """第二王子の成人と共に王太子が決まる大事な時期に、婚約者である第一王子から「少しの間、自由が欲しい」と言われて困惑した。あと二ヶ月しかないのに、ルエラが教育や社交などを放棄してしまえば、王太子には第二王子が選ばれることになる。

そう説明しようとしたが、口の中が痺れてきた。何かがおかしいと思ったが、目の前が突然真っ暗になった。

目を開ければ、そこは自分の部屋だった。どうやら王家の秘毒を飲まされたようだ。婚約者に毒を盛られたことで気持ちが一気に冷めた。しかも毒の副作用なのか、体に痺れが残っていた。毒の後遺症が残り、婚約は白紙に戻された。""";