// Package imports:
import 'package:universal_io/io.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Class to handle platform dependent variables

class PlatformDependentVariables {

  /// the link to DaKanji in the app store
  late String _appStoreLink;
  /// the link to the daapplab developer account
  late String _daapplabStorePage;

  get appStoreLink{
    return _appStoreLink;
  }

  get daapplabStorePage{
    return _daapplabStorePage;
  }

  PlatformDependentVariables(){
    _appStoreLink = ""; 

    if(Platform.isAndroid){
      _appStoreLink = g_PlaystorePage;
      _daapplabStorePage = g_DaAppLabPlaystorePage;
    }
    else if(Platform.isIOS){
      _appStoreLink = g_AppStorePage;
      _daapplabStorePage = g_DaAppLabAppStorepage;
    }
    else if(Platform.isWindows){
      _appStoreLink = g_MicrosoftStorePage;
      _daapplabStorePage = g_MicrosoftStoreDaAppLabPage;
    }    
    else if(Platform.isLinux){
      _appStoreLink = g_SnapStorePage;
      _daapplabStorePage = g_SnapStoreDaAppLabPage;
    }
    else if(Platform.isMacOS){
      _appStoreLink = g_AppStorePage;
      _daapplabStorePage = g_DaAppLabAppStorepage;
    }
    else{
      _appStoreLink = "None";
      _daapplabStorePage = "None";
    }
  }

}
