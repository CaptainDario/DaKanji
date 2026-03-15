// Package imports:
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Class to handle platform dependent variables

class PlatformDependentVariables {

  /// the link to DaKanji in the app store
  late final String appStoreLink;

  /// the link to the daapplab developer account
  late final String daapplabStorePage;


  PlatformDependentVariables(){

    if(Platform.isAndroid){
      appStoreLink = g_AppConfig.playstorePage;
      daapplabStorePage = g_DaAppLabPlaystorePage;
    }
    else if(Platform.isIOS){
      appStoreLink = g_AppConfig.appStorePage;
      daapplabStorePage = g_DaAppLabAppStorepage;
    }
    else if(Platform.isWindows){
      appStoreLink = g_AppConfig.microsoftStorePage;
      daapplabStorePage = g_MicrosoftStoreDaAppLabPage;
    }    
    else if(Platform.isLinux){
      appStoreLink = g_AppConfig.snapStorePage;
      daapplabStorePage = g_SnapStoreDaAppLabPage;
    }
    else if(Platform.isMacOS){
      appStoreLink = g_AppConfig.appStorePage;
      daapplabStorePage = g_DaAppLabAppStorepage;
    }
    else{
      appStoreLink = "None";
      daapplabStorePage = "None";
    }
  }

}

