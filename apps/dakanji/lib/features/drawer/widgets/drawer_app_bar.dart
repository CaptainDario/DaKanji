// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_appbar_action.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({
    super.key,
    required AnimationController drawerController,
    required this.currentScreen,
    required this.height,
    this.useBackArrowAppBar = false,
  }) : _drawerController = drawerController;

  /// controller to open and close the drawer
  final AnimationController _drawerController;
  /// The currently opened screen
  final Screens currentScreen;
  /// the height of the appbar
  final double height;

  final bool useBackArrowAppBar;



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
                if(useBackArrowAppBar){
                  Navigator.of(context).pop();
                }
                else{
                  _drawerController.forward(from: 0.0);
                }
                //close onscreen keyboard if one is opened
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Icon(
                () {
                  if(useBackArrowAppBar) return Icons.arrow_back;
                  else return Icons.menu;
                } (),
                size: height*0.5,
              )
            ),
          ),
        ),
        SizedBox(width: height*0.2,),
        SizedBox(
          height: height*0.5,
          child: Center(
            child: FittedBox(
              child: Text(
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
                    case Screens.ocr:
                      title = LocaleKeys.OcrScreen_title.tr();
                      break;
                    case Screens.immersion:
                      title = LocaleKeys.ImmersionScreen_title.tr();
                      break;
                    case Screens.webbrowser:
                      title = LocaleKeys.WebbrowserScreen_title.tr();
                      break;
                    case Screens.youtube:
                      title = LocaleKeys.YoutubeScreen_title.tr();
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
                    case Screens.wordLists:
                      title = LocaleKeys.WordListsScreen_title.tr();
                      break;
                    case Screens.shop:
                      title = LocaleKeys.ShopScreen_title.tr();
                      break;
                    case Screens.manual:
                      title = LocaleKeys.ManualScreen_title.tr();
                      break;
                    case Screens.init:
                      throw Exception("${Screens.init.name}Screen should not be navigated to via drawer");
                    case Screens.settings:
                      title = LocaleKeys.SettingsScreen_title.tr();
                      break;
                    case Screens.onboarding:
                      throw Exception("OnBoardingScreen should not be navigated to via drawer");
                    case Screens.home:
                      title = LocaleKeys.HomeScreen_title.tr();
                      break;
                    case Screens.webviewDict:
                      title = LocaleKeys.WebviewScreen_title.tr();
                      break;
                  }
                  return title;
                } (),
                maxLines: 1,
              ),
            ),
          ),
        ),
        Spacer(), // move the tools
        TimeTrackingAppbarAction(),
        SizedBox(width: 16,), //spacing at the end
      ],
    );
  }
}
