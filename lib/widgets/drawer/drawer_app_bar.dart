import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({
    Key? key,
    required AnimationController drawerController,
    required this.currentScreen,
    required this.height,
  }) : _drawerController = drawerController, super(key: key);

  /// controller to open and close the drawer
  final AnimationController _drawerController;
  /// The currently opened screen
  final Screens currentScreen;
  /// the height of the appbar
  final double height;



  @override
  Widget build(BuildContext context) {



    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: height*0.2,),
        SizedBox(
          height: height * 0.99,
          width: height * 0.99,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _drawerController.forward(from: 0.0);
                //close onscreen keyboard if one is opened
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Icon(
                Icons.menu,
                size: height*0.5,
              )
            ),
          ),
        ),
        SizedBox(width: height*0.2,),
        SizedBox(
          height: height*0.5,
          child: Center(
            child: AutoSizeText(
              (){
                String title;
                switch (currentScreen){
                  case Screens.about:
                    title = LocaleKeys.AboutScreen_title.tr();
                    break;
                  case Screens.changelog:
                    title = LocaleKeys.ChangelogScreen_title.tr();
                    break;
                  case Screens.drawing:
                    title = LocaleKeys.DrawScreen_title.tr();
                    break;
                  case Screens.dictionary:
                    title = LocaleKeys.DictionaryScreen_title.tr();
                    break;
                  case Screens.text:
                    title = LocaleKeys.TextScreen_title.tr();
                    break;
                  case Screens.kanji:
                    title = LocaleKeys.KanjiScreen_title.tr();
                    break;
                  case Screens.kana_chart:
                    title = LocaleKeys.KanaChartScreen_title.tr();
                    break;
                  case Screens.kuzushiji:
                    title = LocaleKeys.KuzushijiScreen_title.tr();
                    break;
                  case Screens.word_lists:
                    title = LocaleKeys.WordListsScreen_title.tr();
                    break;
                  case Screens.manual:
                    title = LocaleKeys.ManualScreen_title.tr();
                    break;
                  case Screens.home:
                    throw Exception("HomeScreen should not be navigated to via drawer");
                  case Screens.settings:
                    title = LocaleKeys.SettingsScreen_title.tr();
                    break;
                  case Screens.onboarding:
                    throw Exception("OnBoardingScreen should not be navigated to via drawer");
                  case Screens.webviewDict:
                    title = LocaleKeys.WebviewScreen_title.tr();
                    break;
                }
                return title;
              } (),
              maxLines: 1,
              minFontSize: g_MinFontSize,
            ),
          ),
        ),
      ],
    );
  }
}