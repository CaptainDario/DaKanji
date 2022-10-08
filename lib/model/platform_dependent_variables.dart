import 'package:universal_io/io.dart';

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
      _appStoreLink = globalPlaystorePage;
      _daapplabStorePage = globalDaAppLabPlaystorePage;
    }
    else if(Platform.isIOS){
      _appStoreLink = globalAppStorePage;
      _daapplabStorePage = globalDaAppLabAppStorepage;
    }
    else if(Platform.isWindows){
      _appStoreLink = globalMicrosoftStorePage;
      _daapplabStorePage = globalMicrosoftStoreDaAppLabPage;
    }    
    else if(Platform.isLinux){
      _appStoreLink = globalSnapStorePage;
      _daapplabStorePage = globalSnapStoreDaAppLabPage;
    }
    else if(Platform.isMacOS){
      _appStoreLink = globalAppStorePage;
      _daapplabStorePage = globalDaAppLabAppStorepage;
    }
    else{
      _appStoreLink = "None";
      _daapplabStorePage = "None";
    }
  }

}