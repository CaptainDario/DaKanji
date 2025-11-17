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
      appStoreLink = g_PlaystorePage;
      daapplabStorePage = g_DaAppLabPlaystorePage;
    }
    else if(Platform.isIOS){
      appStoreLink = g_AppStorePage;
      daapplabStorePage = g_DaAppLabAppStorepage;
    }
    else if(Platform.isWindows){
      appStoreLink = g_MicrosoftStorePage;
      daapplabStorePage = g_MicrosoftStoreDaAppLabPage;
    }    
    else if(Platform.isLinux){
      appStoreLink = g_SnapStorePage;
      daapplabStorePage = g_SnapStoreDaAppLabPage;
    }
    else if(Platform.isMacOS){
      appStoreLink = g_AppStorePage;
      daapplabStorePage = g_DaAppLabAppStorepage;
    }
    else{
      appStoreLink = "None";
      daapplabStorePage = "None";
    }
  }

}

