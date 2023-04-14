import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:media_kit/media_kit.dart';

import 'package:da_kanji_mobile/model/kana/kana.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/view/kana/KanaInfoCard.dart';
import 'package:da_kanji_mobile/view/kana/KanaGrid.dart';



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
  /// Are dakuten being shown
  bool showDaku = false;
  /// Are yoon being shown
  bool showYoon = false;
  /// Are special yoon being shown
  bool showSpecial = false;

  /// The currently selected kana
  String? currentKana;
  /// The x position of the tapped kana
  double currentKanaX = 0;
  /// The y position of the tappped kana
  double currentKanaY = 0;
  /// The animation controller for the kana info card
  late AnimationController _controller;
  /// The functions to be called when the menu items are pressed
  late List<Function> menuFunctions;  
  /// The player for the kana sound
  final Player kanaSoundPlayer = Player();


  @override
  void initState() {

    menuFunctions = [
      dakuDialPressed,
      yoonDialPressed,
      kanaDialPressed,
      romajiDialPressed,
      showSpecialDialPressed,
    ];  

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250)
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    kanaSoundPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    /// The menu items to be displayed in the speed dial
    List<String> menuItems = [
      showDaku        ? "dakuten_on.svg"  : "dakuten_off.svg",
      showYoon        ? "yoon_on.svg"     : "yoon_off.svg",
      isHiragana      ? "switch_hira.svg" : "switch_kata.svg",
      showRomaji      ? "romaji_on.svg"   : "romaji_off.svg",
      showSpecial ? "yoon_on.svg"     : "yoon_off.svg", 
    ].map((e) => "assets/icons/kana/" + e).toList();
    
    
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
            icon: Icons.settings,
            activeIcon: Icons.close,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: g_Dakanji_green,
            activeBackgroundColor: g_Dakanji_red,
            spacing: 10,
            children: [
              for (int i = 0; i < menuItems.length; i++)
                SpeedDialChild(
                  child: SvgPicture.asset(
                    menuItems[i],
                    //color: Colors.white,
                    width: 35,
                    height: 35,
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

            bool isPortrait = constraints.maxWidth < constraints.maxHeight;
            setCurrrentKanaTable(!isPortrait);

            double popupWidth = (isPortrait ? constraints.maxWidth : constraints.maxHeight*2) / 1.5;
            double popupHeight = (isPortrait ? constraints.maxHeight : constraints.maxWidth) / 3;

            return Stack(
              children: [
                Positioned.fill(
                  child: KanaGrid(
                    currentKanaTable,
                    isPortrait,
                    showRomaji: showRomaji,
                    onTap: (String kana) async {
                      await kanaSoundPlayer.open(
                        Media("asset://assets/audios/kana/individuals/${convertToRomaji(kana)}.wav"),
                        play: true
                      );

                      setState(() {
                        currentKana = kana;
                        currentKanaX =
                          MediaQuery.of(context).size.width / gridColumnCount * getKanaX(kana)
                          + cellWidth/2;
                        currentKanaY = MediaQuery.of(context).size.height / gridRowCount * getKanaY(kana)
                          + cellHeight/2;
                        _controller.forward(from: 0);
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
                          (constraints.maxWidth/2 - popupWidth/2),
                          _controller.value
                        ),
                        top: lerpDouble(currentKanaY,
                          (constraints.maxHeight/2 - popupHeight/2),
                          _controller.value
                        ),
                        width: popupWidth * _controller.value,
                        height: popupHeight * _controller.value,
                        child: Opacity(
                          opacity: _controller.value,
                          child: child!
                        ),
                      );
                    }
                  ),
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

  /// Sets the current kana table to the one selected by the user.
  /// Can flip the table if the screen is in portrait mode by setting
  /// `isPortrait` to true.
  void setCurrrentKanaTable(bool isPortrait){
    if(isHiragana){
      if(showYoon){
        currentKanaTable = hiraYoon;
      }
      else if(showDaku){
        currentKanaTable = hiraDaku;
      }
      else if(showSpecial){
        currentKanaTable = hiraSpecial;
      }
      else{
        currentKanaTable = hiragana;
      }
    }
    else {
      if(showYoon){
        currentKanaTable = kataYoon;
      }
      else if(showDaku){
        currentKanaTable = kataDaku;
      }
      else if(showSpecial){
        currentKanaTable = kataSpecial;
      }
      else{
        currentKanaTable = katakana;
      }
    }

    // check if kana table should be flipped, if so flip table
    if(isPortrait){

      // flip `currentKanaTable` at the main diagonal by swapping the elements
      List<List<String>> temp = List.generate(currentKanaTable[0].length, (index) => 
        List.generate(currentKanaTable.length, (index) => "")
      );
      for(int i = 0; i < currentKanaTable.length; i++){
        for(int j = 0; j < currentKanaTable[i].length; j++){
          temp[j][i] = currentKanaTable[i][j];
        }
      }
      
      currentKanaTable = temp;
    }
  }

  /// Toggles between hiragana and katakana
  void kanaDialPressed(){
    if(isHiragana){
      isHiragana = false;
    } else {
      isHiragana = true;
    }
  }

  /// Toggles between showing and not showing daku
  void dakuDialPressed() {
    if(showDaku){
      showDaku = false;
    } else {
      showDaku = true;
      showYoon = false;
      showSpecial = false;
    }
  }

  /// Toggles between showing and not showing yoon
  void yoonDialPressed() {
    if(showYoon){
      showYoon = false;
    } else {
      showDaku = false;
      showYoon = true;
      showSpecial = false;
    }
  }

  void showSpecialDialPressed() {
    if(showSpecial){
      showSpecial = false;
    } else {
      showDaku = false;
      showYoon = false;
      showSpecial = true;
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