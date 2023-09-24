// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/globals.dart';
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
                  case Screens.dojg:
                    title = LocaleKeys.DojgScreen_title.tr();
                    break;
                  case Screens.text:
                    title = LocaleKeys.TextScreen_title.tr();
                    break;
                  case Screens.clipboard:
                    title = LocaleKeys.ClipboardScreen_title.tr();
                    break;
                  case Screens.kanjiTrainer:
                    title = LocaleKeys.KanjiTrainerScreen_title.tr();
                    break;
                  case Screens.kanjiTable:
                    title = LocaleKeys.KanjiTableScreen_title.tr();
                    break;
                  case Screens.kanaTable:
                    title = LocaleKeys.KanaTableScreen_title.tr();
                    break;
                  case Screens.kanaTrainer:
                    title = LocaleKeys.KanaTrainerScreen_title.tr();
                    break;
                  case Screens.kuzushiji:
                    title = LocaleKeys.KuzushijiScreen_title.tr();
                    break;
                  case Screens.wordLists:
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
                  case Screens.test:
                    title = "Testing";
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
