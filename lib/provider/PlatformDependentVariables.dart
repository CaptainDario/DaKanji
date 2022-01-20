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
      _appStoreLink = PLAYSTORE_PAGE;
      _daapplabStorePage = DAAPPLAB_PLAYSTORE_PAGE;
    }
    else if(Platform.isIOS){
      _appStoreLink = APPSTORE_PAGE;
      _daapplabStorePage = DAAPPLAB_APPSTORE_PAGE;
    }
    else{
      _appStoreLink = "None";
      _daapplabStorePage = "None";
    }
  }

}