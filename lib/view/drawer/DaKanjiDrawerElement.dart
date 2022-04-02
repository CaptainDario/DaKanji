import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/model/SettingsArguments.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



class DaKanjiDrawerElement extends StatelessWidget {
  DaKanjiDrawerElement(
    {
      required this.leading,
      required this.title,
      required this.route,
      required this.selected,
      required this.drawerWidth,
      required this.drawerController,
      this.onTap,
      Key? key
    }
  ) : super(key: key);

  /// The leading icon of this tile
  IconData leading;
  /// The title of this tile
  String title;
  /// The route to which will be navigated once the user taps on this tile
  String route;
  /// if this tile is selected or not
  bool selected;
  /// The width of the drawer
  double drawerWidth;
  /// The AnimationController to control the drawer
  AnimationController drawerController;
  /// Function which will be invoked when the user taps on this tile
  Function? onTap;

  

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16, 2, 8, 2),
        horizontalTitleGap: 4,
        dense: true,
        leading: Icon(
          leading,
          size: this.drawerWidth*0.15 < 20 ? this.drawerWidth*0.15 : 20,
        ),
        title: AutoSizeText(
          this.title,
          minFontSize: 12,
        ),
        selected: selected,
        selectedColor: Theme.of(context).highlightColor,
        onTap: () {
          if(ModalRoute.of(context)!.settings.name != this.route){
            Navigator.pushNamedAndRemoveUntil(
              context, this.route,
              (Route<dynamic> route) => false,
              arguments: SettingsArguments(true)
            );
          }
          else{
            this.drawerController.reverse();
          }
        },
      ),
    );
  }
}