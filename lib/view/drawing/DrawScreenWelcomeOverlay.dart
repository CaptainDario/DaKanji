import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';



class DrawScreenWelcomeOverlay extends StatelessWidget {

  const DrawScreenWelcomeOverlay({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: double.infinity, //constraints.maxHeight
      color: MediaQuery.of(context).platformBrightness == Brightness.dark ?
        Color.fromARGB(199, 32, 32, 32) : 
          Color.fromARGB(220, 0, 0, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.DrawScreen_tutorial_begin_title.tr() + '\n',
              textScaleFactor: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Text(
              LocaleKeys.DrawScreen_tutorial_begin_text.tr() + '\n',
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text(
                  LocaleKeys.DrawScreen_tutorial_begin_continue.tr(),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}