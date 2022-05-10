library my_prj.globals;

import 'package:auto_size_text/auto_size_text.dart';


/// the title of the app
const String APP_TITLE = "DaKanji";

/// deep link pattern
const String APP_LINK = r"dakanji://dakanji/";

/// the version number of this app
String VERSION = "";
/// Minimum number of app starts until the user gets the option to never show
/// the rate dialogue again
const int MIN_TIMES_OPENED_ASK_NOT_SHOW_RATE = 51;
/// all versions which implemented new features for the drawing screen
// ignore: non_constant_identifier_names
List<String> DRAWING_SCREEN_NEW_FEATURES = ["0.0.1", "1.0.0", "1.1.0", "2.1.0"];
/// all versions which implemented new pages for the OnBoarding
// ignore: non_constant_identifier_names
List<String> ONBOARDING_NEW_PAGES = ["0.0.0", "2.0.0"];
/// all languages which are supported in DaKanji
const SUPPORTED_LANGUAGES = ["en", "de", "pl"];


/// is the app running to test the drawscreen
bool IS_TESTING_DRAWSCREEN = false;
/// is the app running to test the app startup situations
bool IS_TESTING_APP_STARTUP = false;
/// is the app running to test the misc. settings
bool IS_TESTING_SETTINGS = false;
/// is the app running to test if the onboarding shows again if there are new
/// pages added to it
bool IS_TESTING_APP_STARTUP_ONBOARDING_NEW_FEATURES = false;
/// is the app running to test if the DrawScreen tutorial shows again if there are new
/// points added to it
bool IS_TESTING_APP_STARTUP_DRAWSCREEN_NEW_FEATURES = false;


//about page
/// link to the github repo
const GITHUB_REPO_URL = "https://github.com/CaptainDario/DaKanji";
/// link to the github repos issues
const GITHUB_ISSUES = GITHUB_REPO_URL + "/issues/new";
/// link to the github repos release page
const GITHUB_RELEASES_PAGE = GITHUB_REPO_URL + "/releases";

/// link to join the discord server
const DISCORD_INVITE = "https://discord.com/invite/gdqaux3r4P";

/// the base url to ANY app on the PlayStore
const PLAYSTORE_BASE_URL = "https://play.google.com/store/apps/details?id=";
/// the url to the PlayStore page of Dakanji 
const PLAYSTORE_PAGE = PLAYSTORE_BASE_URL + "com.DaAppLab.DaKanjiRecognizer";
/// the base intent to open the playstore's android app
const PLAYSTORE_BASE_INTENT =  "market://details?id=";
/// the url to DaAppLab's playstore page
const DAAPPLAB_PLAYSTORE_PAGE = "https://play.google.com/store/apps/developer?id=DaAppLab";

/// the base url to ANY app on the AppStore
const APPSTORE_BASE_URL = "itms-apps://itunes.apple.com/app/";
/// DaKanji's ID on the AppStore
const APPSTORE_ID = "1593741764";
///
const APPSTORE_PAGE = "https://apps.apple.com/de/app/DaKanji/id" + APPSTORE_ID;
///the url to developer's AppStore page
const DAAPPLAB_APPSTORE_PAGE = "https://apps.apple.com/us/developer/dario-klepoch/id1193537491";

/// DaKanji's ID on the MicrosoftStore
const MICROSOFT_STORE_ID = "9n08051t2xtv";
/// the url to the MicrosoftStore page of Dakanji 
const MICROSOFT_STORE_PAGE = "https://www.microsoft.com/p/dakanji/" + MICROSOFT_STORE_ID;
/// uri to open DaAppLab's page in the Microsoft store 
const MICROSOFT_STORE_DAAPPLAB_PAGE = "ms-windows-store://publisher/?name=DaAppLab";

/// the url to the SnapStore page of Dakanji 
const SNAPSTORE_PAGE = "https://snapcraft.io/dakanji";
/// DaAppLab page in the snap store
const SNAPSTORE_DAAPPLAB_PAGE = "";

/// id of the takoboto package on android
const TAKOBOTO_ID = "jp.takoboto";
/// id of the akebi package on android
const AKEBI_ID = "com.craxic.akebifree";
/// id of the aedict package on android
const AEDICT_ID = "sk.baka.aedict3";
/// id of the google translate package on android
const GOOGLE_TRANSLATE_ID = "com.google.android.apps.translate";

/// id of the shirabe package on ios
const SHIRABE_ID = "id1005203380";
/// id of the imiwa on ios
const IMIWA_ID = "id288499125";
/// id of the japanese on ios
const JAPANESE_ID = "id290664053";
/// id of the midori on ios
const MIDORI_ID = "id385231773";


/// url to the privacy police of DaKanji
const PRIVACY_POLICE = "https://sites.google.com/view/dakanjirecognizerprivacypolicy";


/// AutoSizeGroup for the settings screen -> all list entries have same font size
AutoSizeGroup settingsAutoSizeGroup = AutoSizeGroup();
/// AutoSizeGroup for the drawer -> all list entries have same font size
AutoSizeGroup drawerAutoSizeGroup = AutoSizeGroup();
/// Global minimum font size for autosizing texts
double GlobalMinFontSize = 8;