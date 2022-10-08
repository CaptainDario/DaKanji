import 'dart:async';
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

    print("Stream: "+ (link ?? "none"));
    handleLink(link);

  },
  onError: (err) {
    print("An error occurred handling the DeepLink stream!");
  });
}

/// 
Future<void> getInitialDeepLink() async {
  
  try {
    String? initialLink = await getInitialLink();
    print("Initial Link: " + (initialLink ?? "none"));
    handleLink(initialLink);
  }
  on PlatformException {
    print("Not started by DeepLink.");
  }
}

void handleLink(String? link){

  if(link == null) return;

  String short = link.replaceFirst(APP_LINK, "");

  if(short.startsWith("jisho")){
    print("contains jisho");
    GetIt.I<Settings>().selectedDictionary =
      GetIt.I<Settings>().settingsDrawing.dictionaries[0];
  }
  else if(short.startsWith("wadoku")){
    print("contains wadoku");
    GetIt.I<Settings>().selectedDictionary =
      GetIt.I<Settings>().settingsDrawing.dictionaries[1];
  }
  else if(short.startsWith("weblio")){
    print("contains weblio");
    GetIt.I<Settings>().selectedDictionary =
      GetIt.I<Settings>().settingsDrawing.dictionaries[2];
  }
  else if(short.startsWith("URL")){
    print("contains custom URL");
    GetIt.I<Settings>().selectedDictionary =
      GetIt.I<Settings>().settingsDrawing.dictionaries[3];
    short = Uri.decodeFull(short.replaceFirst("URL/", ""));
    print("given custom url:" + short);
    GetIt.I<Settings>().customURL = short;
  }
  else if(Platform.isAndroid){
    if(short.startsWith("aedict")){
      print("contains aedict");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[5];
    }
    else if(short.startsWith("akebi")){
      print("contains akebi");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[6];
    }
    else if(short.startsWith("takoboto")){
      print("contains takoboto");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[7];
    }
  }
  else if(Platform.isIOS){
    if(short.startsWith("shirabe")){
      print("contains shirabe");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[4];
    }
    else if(short.startsWith("imiwa")){
      print("contains imiwa");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[5];
    }
    else if(short.startsWith("japanese")){
      print("contains japanese");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[6];
    }
    else if(short.startsWith("midori")){
      print("contains midori");
      GetIt.I<Settings>().selectedDictionary =
        GetIt.I<Settings>().settingsDrawing.dictionaries[7];
    }
  }
  else{
    print("No matching dictionary found!");
  }
}
