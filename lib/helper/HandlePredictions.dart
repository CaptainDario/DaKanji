
import 'package:da_kanji_mobile/model/SettingsArguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:android_intent_plus/android_intent.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:get_it/get_it.dart';
import 'package:universal_io/io.dart' show Platform;
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/provider/Settings.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenLayout.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/view/DownloadAppDialogue.dart';
import 'package:da_kanji_mobile/view/WebviewScreen.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// Convenience classes to handle long and short presses for the 
/// predictions of the drawing screens.
void handlePress(BuildContext context){

  // presses should be inverted
  if(GetIt.I<Settings>().invertShortLongPress){
    if(!GetIt.I<DrawScreenState>().drawingLookup.longPress)
      openDictionary(context, GetIt.I<DrawScreenState>().drawingLookup.chars);
    else
      copy(context, GetIt.I<DrawScreenState>().drawingLookup.chars);
  }
  // presses should NOT be inverted
  if(!GetIt.I<Settings>().invertShortLongPress){
    if(!GetIt.I<DrawScreenState>().drawingLookup.longPress)
      copy(context, GetIt.I<DrawScreenState>().drawingLookup.chars);
    else
      openDictionary(context, GetIt.I<DrawScreenState>().drawingLookup.chars);
  }
}


/// Copies [char] to the system clipboard and show a snackbar using [context].
void copy(BuildContext context, String char){
  if (char != " " && char != ""){
    Clipboard.setData(new ClipboardData(text: char));
    // display a snackbar for 1s 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text("copied " + char + " to clipboard"),
      )
    );
  }
}

/// Open [char] in the dictionary selected in the settings.
/// 
/// If the selected dictionary is not installed show a dialogue to ask the 
/// user if he/she wants to download it.
void openDictionary(BuildContext context, String char) async {

  // only open a page when there is a prediction
  if (char != " " && char != "") {
    // url dict
    if(GetIt.I<Settings>().settingsDrawing.webDictionaries.contains(
      GetIt.I<Settings>().selectedDictionary)
    ){ 
      // use the default browser
      if(!GetIt.I<Settings>().useWebview){
        launchUrlString(openWithSelectedDictionary(char));
      }
      else{ 
        if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.Portrait ||
          GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.Landscape)
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (BuildContext context) => WebviewScreen()
            )
          );
        else if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.LandscapeWithWebview){
            
          //print("webview is side by side");
        }
      }
    }
    //
    else if(GetIt.I<Settings>().selectedDictionary ==
      GetIt.I<Settings>().settingsDrawing.inbuiltDictId){
      Navigator.pushNamedAndRemoveUntil(
        context, "/dictionary", (route) => false,
        arguments: NavigationArguments(false, char)
      );
    }
    // handle dictionary opening on ANDROID
    else if(Platform.isAndroid){
      // the prediction should be translated with system dialogue
      if(GetIt.I<Settings>().selectedDictionary == 
        GetIt.I<Settings>().settingsDrawing.androidDictionaries[0]){ 
          AndroidIntent intent = AndroidIntent(
            action: 'android.intent.action.TRANSLATE',
            arguments: <String, dynamic>{
              "android.intent.extra.TEXT" : char
            }
          );
          bool? cra = await intent.canResolveActivity();
          if(cra != null && cra)
            await intent.launch();
          else{
            showDownloadDialogue(
              context,
              "No translator installed", 
              LocaleKeys.General_download.tr(),
              PLAYSTORE_BASE_URL + GOOGLE_TRANSLATE_ID
            );
          }
      }
      // offline dictionary aedict3 (android)
      else if(GetIt.I<Settings>().selectedDictionary ==
        GetIt.I<Settings>().settingsDrawing.androidDictionaries[1]){
        try{
          
          AndroidIntent intent = AndroidIntent(
              package: AEDICT_ID,
              type: "text/plain",
              action: 'android.intent.action.SEND',
              category: 'android.intent.category.DEFAULT',
              arguments: <String, dynamic>{
                "android.intent.extra.TEXT": char,
              }
          );
          bool? cra = await intent.canResolveActivity();
          if(cra != null && cra)
            await intent.launch();
        }
        catch (e){
          showDownloadDialogue(context,
            LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
              "DICTIONARY" : "aedict"
            }), 
            LocaleKeys.General_download.tr(), 
            PLAYSTORE_BASE_URL + AEDICT_ID 
          );
        }
      }
      // offline dictionary akebi (android)
      else if(GetIt.I<Settings>().selectedDictionary ==
        GetIt.I<Settings>().settingsDrawing.androidDictionaries[2]){
        if(Platform.isAndroid){
          AndroidIntent intent = AndroidIntent(
              package: AKEBI_ID,
              componentName: 
                'com.craxic.akebifree.activities.search.SearchActivity',
              type: "text/plain",
              action: 'android.intent.action.SEND',
              arguments: <String, dynamic>{
                "android.intent.extra.TEXT": char,
              }
          );
          bool? cra = await intent.canResolveActivity();
          if(cra != null && cra)
            await intent.launch();
          else
            showDownloadDialogue(context,
              LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
                "DICTIONARY" : "akebi"
              }), 
              LocaleKeys.General_download.tr(), 
              PLAYSTORE_BASE_URL + AKEBI_ID
            );
        }
      }
      // offline dictionary takoboto (android)
      else if(GetIt.I<Settings>().selectedDictionary == 
        GetIt.I<Settings>().settingsDrawing.androidDictionaries[3]){
        if(Platform.isAndroid){
          AndroidIntent intent = AndroidIntent(
              package: TAKOBOTO_ID,
              action: 'jp.takoboto.SEARCH',
              arguments: <String, dynamic>{
                "android.intent.extra.PROCESS_TEXT": char,
              }
          );
          bool? cra = await intent.canResolveActivity();
          if(cra != null && cra)
            await intent.launch();
          else{
            showDownloadDialogue(context,
              LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
                "DICTIONARY" : "takoboto"
              }), 
              LocaleKeys.General_download.tr(), 
              PLAYSTORE_BASE_URL + TAKOBOTO_ID
            );
          }
        }
      }
    }
    // iOS DICTIONARIES
    // shirabe jisho
    else if(Platform.isIOS){
      // dictionary shirabe (iOS)
      if(GetIt.I<Settings>().selectedDictionary ==
        GetIt.I<Settings>().settingsDrawing.iosDictionaries[0]){
        print("iOS shirabe");
        final url = Uri.encodeFull("shirabelookup://search?w=" + char);
        if(await canLaunchUrlString(url)) 
          launchUrlString(url);
        else {
          print("cannot launch " + url);
          showDownloadDialogue(context,
            LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
              "DICTIONARY" : "Shirabe Jisho"
            }),
            LocaleKeys.General_download.tr(), 
            APPSTORE_BASE_URL + SHIRABE_ID
          );
        }
      }
      // imiwa?
      else if(GetIt.I<Settings>().selectedDictionary ==
        GetIt.I<Settings>().settingsDrawing.iosDictionaries[1]){
        print("iOS imiwa?");
        final url = Uri.encodeFull("imiwa://dictionary?search=" + char);
        if(await canLaunchUrlString(url))
          launchUrlString(url);
        else {
          print("cannot launch " + url);
          showDownloadDialogue(context,
            LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
              "DICTIONARY" : "Imiwa?"
            }),
            LocaleKeys.General_download.tr(),
            APPSTORE_BASE_URL + IMIWA_ID
          );
        }
      }
      // Japanese
      else if(GetIt.I<Settings>().selectedDictionary ==
        GetIt.I<Settings>().settingsDrawing.iosDictionaries[2]){
        print("iOS Japanese");
        final url = Uri.encodeFull("japanese://search/word/" + char);
        if(await canLaunchUrlString(url)) 
          launchUrlString(url);
        else {
          print("cannot launch " + url);
          showDownloadDialogue(context, 
            LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
              "DICTIONARY" : "Japanese"
            }),
            LocaleKeys.General_download.tr(),
            APPSTORE_BASE_URL + JAPANESE_ID
          );
        }
      }
      else if(GetIt.I<Settings>().selectedDictionary ==
        GetIt.I<Settings>().settingsDrawing.iosDictionaries[3]){
        print("iOS midori");
        final url = Uri.encodeFull("midori://search?text=" + char);
        if(await canLaunchUrlString(url)) 
          launchUrlString(
            url,
          );
        else {
          print("cannot launch" + url);
          showDownloadDialogue(context, 
            LocaleKeys.DrawScreen_not_installed.tr(namedArgs: {
              "DICTIONARY" : "Midori"
            }),
            LocaleKeys.General_download.tr(),
            APPSTORE_BASE_URL + MIDORI_ID
          );
        }
      }
    }
    else if(Platform.isWindows){
      print("There are no app dictionaries for windows available!");
    }
    
  }
}


/// Get the URL to the predicted kanji in the selected dictionary.
///
/// @returns The URL which leads to the predicted kanji in the selected dict.
String openWithSelectedDictionary(String kanji) {
  String url = "";

  // determine which URL should be used for finding the character
  if(GetIt.I<Settings>().selectedDictionary ==
    GetIt.I<Settings>().settingsDrawing.dictionaries[0])
    url = GetIt.I<Settings>().settingsDrawing.jishoURL;
  else if(GetIt.I<Settings>().selectedDictionary ==
    GetIt.I<Settings>().settingsDrawing.dictionaries[1])
    url = GetIt.I<Settings>().settingsDrawing.wadokuURL;
  else if(GetIt.I<Settings>().selectedDictionary ==
    GetIt.I<Settings>().settingsDrawing.dictionaries[2])
    url = GetIt.I<Settings>().settingsDrawing.weblioURL;
  else if(GetIt.I<Settings>().selectedDictionary ==
    GetIt.I<Settings>().settingsDrawing.dictionaries[3])
    url = GetIt.I<Settings>().customURL;

  if(url != ""){
    // check that the URL starts with protocol, otherwise launch() fails
    if (!(url.startsWith("http://") || url.startsWith("https://")))
      url = "https://" + url;

    // replace the placeholder with the actual character
    url = url.replaceFirst(
      new RegExp(GetIt.I<Settings>().settingsDrawing.kanjiPlaceholder), kanji
    );
    url = Uri.encodeFull(url);
  }
  return url;
}
