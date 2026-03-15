import 'package:da_kanji_mobile/core/app/app_config.dart';
import 'package:language_processing/language_processing.dart';


class JapaneseAppConfig extends AppConfig {

  @override Iso639_3 get languageCode => Iso639_3.jpn;
  @override String get appTitle => "DaKanji";

  @override String get appLinkHttps => "https://dakanji.app/app/";
  @override String get appLink => "dakanji://";

  @override String get fontFamily => "NotoSansJP";
  
  @override String sampleText = """

東京に暮らす男子高校生・瀧は、夢を見ることをきっかけに田舎町の女子高生・三葉と入れ替わるようになる。

慣れない女子の身体、未知の田舎暮らしに戸惑いつつ、徐々に馴染んでいく瀧。
身体の持ち主である三葉のことをもっと知りたいと瀧が思い始めたころ、普段と違う三葉を疑問に思った周りの人たちも彼女のことを考え出して――。

食べられる
食べられました
欲しくない
失礼な
基本的

（主に関西）（五段活用・下一段活用・サ行変格活用の動詞の後について）～ない　語源：「～はせぬ」が転じたもの。

""";

  // privacy policy
  @override String get privacyPolicyUrl => "https://dakanji.app/dakanji-app-privacy-policy/";

  // discord server
  @override String get discordInviteLink => "https://discord.com/invite/gdqaux3r4P";

  // github
  @override String get githubRepoUrl => "https://github.com/CaptainDario/DaKanji";
  @override String get githubReleasesApi => "https://api.github.com/repos/CaptainDario/DaKanji/releases";
  @override String get githubApiDataRelase => "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases";

  // playstore
  @override String get playstorePage => "${playstoreBaseUrl}com.DaAppLab.DaKanjiRecognizer";

  // appstore
  @override String get appStoreId => "1593741764";

  // microsoft store
  @override String get microsoftStoreId => "9n08051t2xtv";

}