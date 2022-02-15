library my_prj.globals;

import 'model/core/ShowcaseTuple.dart';


// the title of the app
const String APP_TITLE = "DaKanji";

// deep link pattern
const String APP_LINK = r"dakanji://dakanji/";

// the version number of this app
// ignore: non_constant_identifier_names
String VERSION = "1.4.0+28";
// the number of times the app has been opened until the user gets asked to
// if the rate dialogue should never be shown again
// ignore: non_constant_identifier_names
int MIN_TIMES_OPENED_ASK_NOT_SHOW_RATE = 31;
// all versions which implemented new features for the drawing screen
// ignore: non_constant_identifier_names
List<String> DRAWING_SCREEN_NEW_FEATURES = ["1.0.0", "1.1.0"];
// all versions which implemented new pages for the OnBoarding
// ignore: non_constant_identifier_names
List<String> ONBOARDING_NEW_PAGES = ["2.0.0"];


// showcase view keys
// ignore: non_constant_identifier_names
List<ShowcaseTuple> SHOWCASE_DRAWING = [];
// should the showcase of the draw screen be shown
// ignore: non_constant_identifier_names
bool SHOW_SHOWCASE_DRAWING = false;
// should the showcase of the draw screen be shown
// ignore: non_constant_identifier_names
bool SHOW_ONBOARDING = false;

//about page
const GITHUB_DESKTOP_REPO = "https://github.com/CaptainDario/DaKanji-Desktop";
const GITHUB_MOBILE_REPO = "https://github.com/CaptainDario/DaKanji-Mobile";
const GITHUB_CNN_SINGLE_CHAR_REPO = "https://github.com/CaptainDario/DaKanji-Single-Kanji-Recognition";
const GITHUB_ISSUES = "https://github.com/CaptainDario/DaKanji-Mobile/issues/new";

const DISCORD_INVITE = "https://discord.com/invite/gdqaux3r4P";

const PLAYSTORE_BASE_URL = "https://play.google.com/store/apps/details?id=";
const PLAYSTORE_PAGE = PLAYSTORE_BASE_URL + "com.DaAppLab.DaKanjiRecognizer";
const PLAYSTORE_BASE_INTENT =  "market://details?id=";
const DAAPPLAB_PLAYSTORE_PAGE = "https://play.google.com/store/apps/developer?id=DaAppLab";

const APPSTORE_BASE_URL = "itms-apps://itunes.apple.com/app/";
const APPSTORE_ID = "1593741764";
const APPSTORE_PAGE = "https://apps.apple.com/de/app/DaKanji/id" + APPSTORE_ID;
const DAAPPLAB_APPSTORE_PAGE = "https://apps.apple.com/us/developer/dario-klepoch/id1193537491";

const TAKOBOTO_ID = "jp.takoboto";
const AKEBI_ID = "com.craxic.akebifree";
const AEDICT_ID = "sk.baka.aedict3";

const SHIRABE_ID = "id1005203380";
const IMIWA_ID = "id288499125";
const JAPANESE_ID = "id290664053";
const MIDORI_ID = "id385231773";

const GOOGLE_TRANSLATE_ID = "com.google.android.apps.translate";

const PRIVACY_POLICE = "https://sites.google.com/view/dakanjirecognizerprivacypolicy";