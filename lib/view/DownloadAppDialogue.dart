import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';



/// Show a dialogue using [context] with a [title], some [text] and a button
/// to open the [url].
void showDownloadDialogue(
  BuildContext context, String title, String text, String url){

  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.WARNING,
    headerAnimationLoop: false,
    body: Column(
      children: [
        Text(title, textScaleFactor: 2,),
        Center( 
          child: Container(
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    launch(url);
                  },
                  child: Text(text)
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(LocaleKeys.General_close.tr())
                ),
              ]
            )
          )
        )
      ]
    )
  )..show();
}