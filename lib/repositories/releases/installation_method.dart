import 'package:store_checker/store_checker.dart';
import 'package:universal_io/io.dart';


/// Tries to find the way this application has been installed
Future<String> findInstallationMethod() async {

  String installationMethod = "";

  if(Platform.isAndroid){
    installationMethod = await _findInstallationMethodAndroid();
  }
  else if(Platform.isIOS){
    installationMethod = await _findInstallationMethodiOS();
  }
  else if(Platform.isMacOS){
    installationMethod = await _findInstallationMethodMac();
  }
  else if(Platform.isLinux){
    installationMethod = await _findInstallationMethodLinux();
  }
  else if(Platform.isWindows){
    installationMethod = await _findInstallationMethodWindows();
  }

  return installationMethod;

}

/// Android implementation of `_findInstallationMethod`
Future<String> _findInstallationMethodAndroid() async {
  
  Source installationSource = await StoreChecker.getSource;

  String source = "";
  switch (installationSource) {
    case Source.IS_INSTALLED_FROM_PLAY_STORE:
      // Installed from Play Store
      source = "Play Store";
      break;
    case Source.IS_INSTALLED_FROM_PLAY_PACKAGE_INSTALLER:
      // Installed from Google Package installer
      source = "Google Package installer";
      break;
    case Source.IS_INSTALLED_FROM_LOCAL_SOURCE:
      // Installed using adb commands or side loading or any cloud service
      source = "Local Source";
      break;
    case Source.IS_INSTALLED_FROM_AMAZON_APP_STORE:
      // Installed from Amazon app store
      source = "Amazon Store";
      break;
    case Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY:
      // Installed from Huawei app store
      source = "Huawei App Gallery";
      break;
    case Source.IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE:
      // Installed from Samsung app store
      source = "Samsung Galaxy Store";
      break;
    case Source.IS_INSTALLED_FROM_SAMSUNG_SMART_SWITCH_MOBILE:
      // Installed from Samsung Smart Switch Mobile
      source = "Samsung Smart Switch Mobile";
      break;  
    case Source.IS_INSTALLED_FROM_XIAOMI_GET_APPS:
      // Installed from Xiaomi app store
      source = "Xiaomi Get Apps";
      break;
    case Source.IS_INSTALLED_FROM_OPPO_APP_MARKET:
      // Installed from Oppo app store
      source = "Oppo App Market";
      break;
    case Source.IS_INSTALLED_FROM_VIVO_APP_STORE:
      // Installed from Vivo app store
      source = "Vivo App Store";
      break;
    case Source.IS_INSTALLED_FROM_RU_STORE:
      // Installed apk from RuStore
      source = "RuStore";
      break;
    case Source.IS_INSTALLED_FROM_OTHER_SOURCE:
      // Installed from other market store
      source = "Other Source";
      break;
    case Source.UNKNOWN:
      // Installed from Unknown source
      source = "Unknown Source";
      break;
    default:
      source = "Unkown";
      break;
  }

  return source;
}

/// Tries to find the way this application has been installed
Future<String> _findInstallationMethodiOS() async {

  Source installationSource = await StoreChecker.getSource;

  String source = "";
  switch (installationSource) {
    case Source.IS_INSTALLED_FROM_APP_STORE:
      // Installed from app store
      source = "App Store";
      break;
    case Source.IS_INSTALLED_FROM_TEST_FLIGHT:
      // Installed from Test Flight
      source = "Test Flight";
      break;
    case Source.UNKNOWN:
      // Installed from Unknown source
      source = "Unknown Source";
      break;
    default:
      source = "Unkown";
      break;
  }

  return source;
}

/// Tries to find the way this application has been installed
Future<String> _findInstallationMethodMac(){

  return Future.sync(() => "Mac");

}

/// Tries to find the way this application has been installed
Future<String> _findInstallationMethodLinux(){

  String method = "";

  Map env = Platform.environment;

  if(env.containsKey("SNAP")){
    method = "SNAP";
  }
  else if(env.containsKey("APPIMAGE")){
    method = "APPIMAGE";
  }
  else if(env.containsKey("container")){
    method = "Flatpak";
  }
  else {
    method = "Portable";
  }

  return Future.sync(() => method);

}

/// Tries to find the way this application has been installed
Future<String> _findInstallationMethodWindows(){

  String method = "";

  String resolvedExecutable = Platform.resolvedExecutable;

  if(resolvedExecutable.contains(r"Program Files\WindowsApps")){
    method = "MSIX";
  }
  else {
    method = "exe";
  }

  return Future.sync(() => method);

}