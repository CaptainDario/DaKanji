import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher_string.dart';



/// Show a dialogue using [context] with a [title], some [text] and a button
/// to open the [url] and one to close the dialog.
void showDownloadDialogue(
  BuildContext context, String title, String text, String url){

  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    headerAnimationLoop: false,
    body: Column(
      children: [
        Text(
          title, 
          textScaleFactor: 2,
          textAlign: TextAlign.center,
        ),
        Center( 
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    launchUrlString(url);
                  },
                  child: Text(text)
                ),
                const SizedBox(width: 10,),
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
  ).show();
}