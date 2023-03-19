import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/model/kana/kana.dart';



class KanaScreen extends StatefulWidget {
  
  /// If the screen was navigated by the drawer
  final bool navigatedByDrawer;
  
  const KanaScreen(
    this.navigatedByDrawer,
    {
      super.key
    }
  );

  @override
  State<KanaScreen> createState() => _KanaScreenState();
}

class _KanaScreenState extends State<KanaScreen> {

  List<String> menuItems = ["゜" ,"Hiragana", "Katakana"];

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.kana,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: g_Dakanji_green,
          onPressed: null,
          child: PopupMenuButton(
            itemBuilder: (context) {
              return [
                for (int i = 0; i < menuItems.length; i++)
                PopupMenuItem(
                  child: Text(menuItems[i]),
                  value: i,
                )
              ];
            },
            child: Icon(
              color: Colors.white,
              Icons.menu
            ),
          )
        ),
        body: Container(
          child: Text(
            hiragana[0][0],
          )
        ),
      ),
    );
  }

}