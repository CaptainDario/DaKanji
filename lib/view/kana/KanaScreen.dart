import 'dart:ui';

import 'package:da_kanji_mobile/view/kana/KanaGrid.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:da_kanji_mobile/model/kana/kana.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/view/kana/KanaInfoCard.dart';



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

class _KanaScreenState extends State<KanaScreen> with SingleTickerProviderStateMixin {

  /// Is the speed dial open
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  /// The table of kana to be displayed
  List<List<String>> currentKanaTable = hiragana;
  /// Are currently hiragana being shown
  bool isHiragana = true;
  /// Are romaji being shown
  bool showRomaji = true;

  /// The currently selected kana
  String? currentKana;
  /// The x position of the tapped kana
  double currentKanaX = 0;
  /// The y position of the tappped kana
  double currentKanaY = 0;
  /// The animation controller for the kana info card
  late AnimationController _controller;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250)
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    /// The menu items to be displayed in the speed dial
    List<String> menuItems = ["゜" ,",,", "きゃ", "ひ", "R"];
    /// The functions to be called when the menu items are pressed
    List<Function> menuFunctions = [
      () => print("Menu item 2 pressed"),
      () => print("Menu item 3 pressed"),
      () => print("Menu item 4 pressed"),
      () => kanaDialPressed(),
      () => romajiDialPressed(),
    ];  
    /// The number of columns in the grid
    int gridColumnCount = currentKanaTable[0].length;
    /// the number of rows in the grid
    /// +3 for the empty rows at the bottom
    int gridRowCount = currentKanaTable.length + 3;
    /// the width of a cell in the grid
    double cellWidth = MediaQuery.of(context).size.width / gridColumnCount;
    /// the height of a cell in the grid
    double cellHeight = MediaQuery.of(context).size.height / gridRowCount;


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
                  child: Text(
                    menuItems[i],
                    textScaleFactor: 1.25,
                  ),
                  backgroundColor: g_Dakanji_green,
                  onTap: () {
                    setState(() => menuFunctions[i]());
                  },
                )
            ],
          )
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: KanaGrid(
                    currentKanaTable,
                    showRomaji: showRomaji,
                    onTap: (String kana) {
                      print("Pressed: $kana");
                      setState(() {
                        currentKana = kana;
                        currentKanaX =
                          MediaQuery.of(context).size.width / gridColumnCount * getKanaX(kana)
                          + cellWidth/2;
                        currentKanaY = MediaQuery.of(context).size.height / gridRowCount * getKanaY(kana)
                          + cellHeight/2;
                        _controller.forward(from: 0);
                        print("currentKanaX: $currentKanaX");
                      });
                    },
                  ),
                ),
                // gray background -> close popup
                if(currentKana != null)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.reverse(from: 1).then(
                            (value) {
                              Future.delayed(Duration(milliseconds: 50), () {
                                setState(() {
                                  currentKana = null;
                                });
                              }
                            );
                          });
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    )
                  ),
                // popup
                if(currentKana != null)
                  AnimatedBuilder(
                    animation: _controller,
                    child: KanaInfoCard(currentKana!),
                    builder: (context, child) {
                      return Positioned(
                        left: lerpDouble(currentKanaX,
                          (MediaQuery.of(context).size.width/2 - MediaQuery.of(context).size.width/3),
                          _controller.value
                        ),
                        top: lerpDouble(currentKanaY,
                          (constraints.maxHeight/2 - constraints.maxHeight/6),
                          _controller.value
                        ),
                        width: MediaQuery.of(context).size.width/1.5 * _controller.value,
                        height: constraints.maxHeight/3 * _controller.value,
                        child: Opacity(
                          opacity: _controller.value,
                          child: child!
                        ),
                      );
                    }
                  )
              ],
            );
          }
        )
      ),
    );
  }

  /// Returns the x position of the kana in the kana table
  double getKanaX(String kana){
    for(int i = 0; i < currentKanaTable.length; i++){
      for(int j = 0; j < currentKanaTable[i].length; j++){
        if(currentKanaTable[i][j] == kana){
          return j.toDouble();
        }
      }
    }
    return 0;
  }
  /// Returns the y position of the kana in the kana table
  double getKanaY(String kana){
    for(int i = 0; i < currentKanaTable.length; i++){
      for(int j = 0; j < currentKanaTable[i].length; j++){
        if(currentKanaTable[i][j] == kana){
          return i.toDouble();
        }
      }
    }
    return 0;
  }


  /// Toggles between hiragana and katakana
  void kanaDialPressed(){
    if(isHiragana){
      isHiragana = false;
      currentKanaTable = katakana;
    } else {
      isHiragana = true;
      currentKanaTable = hiragana;
    }
  }

  /// Toggles between showing and not showing romaji
  void romajiDialPressed() {
    if(showRomaji){
      showRomaji = false;
    } else {
      showRomaji = true;
    }
  }
}