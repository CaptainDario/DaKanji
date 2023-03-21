import 'package:da_kanji_mobile/helper/iso/iso_table.dart';
import 'package:da_kanji_mobile/model/kana/kana.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';



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

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  //List<String> menuItems = ["゜" ,"あ", "ア"];

  @override
  Widget build(BuildContext context) {

    List<String> menuItems = ["゜" ,",,", "きゃ", "->"];

    
    return DaKanjiDrawer(
      currentScreen: Screens.kana,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          focusColor: g_Dakanji_green,
          onPressed: () => isDialOpen.value = !isDialOpen.value,
          child: SpeedDial(
            icon: Icons.menu,
            activeIcon: Icons.close,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: g_Dakanji_green,
            activeBackgroundColor: g_Dakanji_red,
            spacing: 10,
            children: [
              for (int i = 0; i < menuItems.length; i++)
                SpeedDialChild(
                  child: Text(menuItems[i], textScaleFactor: 1.25,),
                  backgroundColor: g_Dakanji_green,
                  onTap: () => print("Menu item ${menuItems[i]} pressed"),
                )
            ],
          )
        ),
        body: AnimationLimiter(
          child: GridView.count(
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: hiragana[0].length,
            childAspectRatio: 1.25,
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            children: List.generate(hiragana.length*hiragana[0].length, (index) => 
               AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: hiragana[0].length,
                duration: Duration(milliseconds: 300),
                child: FadeInAnimation(
                  child: ScaleAnimation(
                    child: TextButton(
                      onPressed: () {
                        print("Pressed ${hiragana[index~/5][index%5]}");
                      },
                      child: Text(
                        katakana[index~/5][index%5],
                        textScaleFactor: 2,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              )
            )
          ),
        )
      ),
    );
  }

}