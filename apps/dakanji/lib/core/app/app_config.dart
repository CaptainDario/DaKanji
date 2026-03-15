import 'package:language_processing/language_processing.dart';



abstract class AppConfig {

  Iso639_3 get languageCode;
  String get appTitle;

  // deep links
  String get appLinkHttps;
  String get appLink;

  String get fontFamily;
  
  String get sampleText;

  // privacy policy
  String get privacyPolicyUrl;

  // discord server
  String get discordInviteLink;

  // github link for this app
  /// link to the github repo
  String get githubRepoUrl;
  /// link to the github repos issues
  String get githubIssues => "$githubRepoUrl/issues/new";
  /// link to the github repos release page
  String get githubReleasesPage => "$githubRepoUrl/releases";
  /// link to the latest github release
  String get githubLatestReleasesPage => "$githubRepoUrl/releases/latest";
  /// the github api endpoint to query releases
  String get githubReleasesApi;
  /// lin to the github repo with dependencies needed for dakanji
  String get githubApiDataRelase;

  // playstore
  String get playstoreBaseUrl => "https://play.google.com/store/apps/details?id=";
  String get playstoreBaseIntent => "market://details?id=";
  String get playstorePage;

  // appstore
  String get appStoreBaseUrl => "itms-apps://itunes.apple.com/app/";
  String get appStoreId;
  String get appStorePage => "https://apps.apple.com/de/app/DaKanji/id$appStoreId";

  // microsoft store
  String get microsoftStoreId;
  String get microsoftStorePage => "https://www.microsoft.com/p/dakanji/$microsoftStoreId";

  // Snapstore
  /// the url to the SnapStore page of Dakanji 
  String get snapStorePage => "https://snapcraft.io/${appTitle.toLowerCase()}";  

}