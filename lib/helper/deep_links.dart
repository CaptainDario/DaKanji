import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:uni_links/uni_links.dart';

import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:universal_io/io.dart';


StreamSubscription? linkSub;

Future<void> initDeepLinksStream() async {
  // ... check initialUri

  // Attach a listener to the stream
  linkSub = linkStream.listen((String? link) {

    debugPrint("Stream: "+ (link ?? "none"));
    handleLink(link);

  },
  onError: (err) {
    debugPrint("An error occurred handling the DeepLink stream!");
  });
}

/// 
Future<void> getInitialDeepLink() async {
  
  try {
    String? initialLink = await getInitialLink();
    debugPrint("Initial Link: " + (initialLink ?? "none"));
    handleLink(initialLink);
  }
  on PlatformException {
    debugPrint("Not started by DeepLink.");
  }
}

void handleLink(String? link){

  if(link == null) return;

  String short = link.replaceFirst(globalAppLink, "");

  if(short.startsWith("jisho")){
    debugPrint("contains jisho");
    GetIt.I<Settings>().drawing.selectedDictionary =
      GetIt.I<Settings>().drawing.dictionaries[0];
  }
  else if(short.startsWith("wadoku")){
    debugPrint("contains wadoku");
    GetIt.I<Settings>().drawing.selectedDictionary =
      GetIt.I<Settings>().drawing.dictionaries[1];
  }
  else if(short.startsWith("weblio")){
    debugPrint("contains weblio");
    GetIt.I<Settings>().drawing.selectedDictionary =
      GetIt.I<Settings>().drawing.dictionaries[2];
  }
  else if(short.startsWith("URL")){
    debugPrint("contains custom URL");
    GetIt.I<Settings>().drawing.selectedDictionary =
      GetIt.I<Settings>().drawing.dictionaries[3];
    short = Uri.decodeFull(short.replaceFirst("URL/", ""));
    debugPrint("given custom url:" + short);
    GetIt.I<Settings>().drawing.customURL = short;
  }
  else if(Platform.isAndroid){
    if(short.startsWith("aedict")){
      debugPrint("contains aedict");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[5];
    }
    else if(short.startsWith("akebi")){
      debugPrint("contains akebi");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[6];
    }
    else if(short.startsWith("takoboto")){
      debugPrint("contains takoboto");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[7];
    }
  }
  else if(Platform.isIOS){
    if(short.startsWith("shirabe")){
      debugPrint("contains shirabe");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[4];
    }
    else if(short.startsWith("imiwa")){
      debugPrint("contains imiwa");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[5];
    }
    else if(short.startsWith("japanese")){
      debugPrint("contains japanese");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[6];
    }
    else if(short.startsWith("midori")){
      debugPrint("contains midori");
      GetIt.I<Settings>().drawing.selectedDictionary =
        GetIt.I<Settings>().drawing.dictionaries[7];
    }
  }
  else{
    debugPrint("No matching dictionary found!");
  }
}
