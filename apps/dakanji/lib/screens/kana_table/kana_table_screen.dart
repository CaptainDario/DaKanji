// Dart imports:
import 'dart:math';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fvp/mdk.dart' as mdk;
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/application/kana/kana.dart';
import 'package:da_kanji_mobile/entities/da_kanji_icons.dart';
import 'package:da_kanji_mobile/entities/kana/kana.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/kana_table/kana_grid.dart';
import 'package:da_kanji_mobile/widgets/kana_table/kana_info_card.dart';
import 'package:universal_io/io.dart';

class KanaTableScreen extends StatefulWidget {
  

  /// If the screen was navigated by the drawer
  final bool navigatedByDrawer;
  /// Should the tutorial be included
  final bool includeTutorial;
  
  const KanaTableScreen(
    this.navigatedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KanaTableScreen> createState() => _KanaTableScreenState();
}

class _KanaTableScreenState extends State<KanaTableScreen> with SingleTickerProviderStateMixin {

  /// Is the speed dial open
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  /// The functions to be called when the menu items are pressed
  late List<Function> menuFunctions;

  /// The table of kana selected from the user before applying responsivess-modifications
  List<List<String>> baseKanaTable = hiragana;
  /// The table of kana to be displayed
  List<List<String>> kanaTable = hiragana;
  /// Are currently hiragana being shown
  bool isHiragana = GetIt.I<Settings>().kanaTable.isHiragana;
  /// Are romaji being shown
  bool showRomaji = GetIt.I<Settings>().kanaTable.showRomaji;
  /// Are dakuten being shown
  bool showDaku = GetIt.I<Settings>().kanaTable.showDaku;
  /// Are yoon being shown
  bool showYoon = GetIt.I<Settings>().kanaTable.showYoon;
  /// Are special yoon being shown
  bool showSpecial = GetIt.I<Settings>().kanaTable.showSpecial;

  /// The currently selected kana
  String? currentKana;
  /// The x position of the tapped kana
  double currentKanaX = 0;
  /// The y position of the tappped kana
  double currentKanaY = 0;
  /// the height of the action button (56 [height] + 20 [margin])
  double actionButtonHeigt = 56 + 20;
  /// The animation controller for the kana info card
  late AnimationController _controller;
  /// The player for the kana sound
  final mdk.Player kanaSoundPlayer = mdk.Player();


  @override
  void initState() {

    // use audio track for audio only playback on android
    if(Platform.isAndroid) kanaSoundPlayer.audioBackends = ["AudioTrack"];

    menuFunctions = [
      dakuDialPressed,
      yoonDialPressed,
      kanaDialPressed,
      romajiDialPressed,
      showSpecialDialPressed,
    ];  

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250)
    );

    super.initState();

    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        
        if (onboarding != null && widget.includeTutorial && 
          GetIt.I<UserData>().showTutorialKanaTable) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().kanaTableScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().kanaTableScreenTutorial.indexes!
          );
          onboarding.controller.addListener(() => tutorialToggleSpeedDial(onboarding));
        }
      }
    });
  }

  void tutorialToggleSpeedDial(OnboardingState onboarding) {
    if(onboarding.controller.currentIndex == GetIt.I<Tutorials>().kanaTableScreenTutorial.indexes![1]){
      isDialOpen.value = true;
    }
    if(onboarding.controller.currentIndex == GetIt.I<Tutorials>().kanaTableScreenTutorial.indexes!.last){
      isDialOpen.value = false;
      onboarding.controller.removeListener(() => tutorialToggleSpeedDial(onboarding));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    kanaSoundPlayer.dispose();
    updateSettings();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.kanaTable,
      drawerClosed: !widget.navigatedByDrawer,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          focusColor: g_Dakanji_green,
          onPressed: () => isDialOpen.value = !isDialOpen.value,
          child: Focus(
            focusNode: widget.includeTutorial
              ? GetIt.I<Tutorials>().kanaTableScreenTutorial.focusNodes![2]
              : null,
            child: SpeedDial(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              icon: DaKanjiIcons.settings,
              openCloseDial: isDialOpen,
              activeIcon: Icons.close,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: g_Dakanji_green,
              activeBackgroundColor: g_Dakanji_red,
              spacing: 10,
              onClose: () => updateSettings(),
              children: [
                for (int i = 0; i < 5; i++)
                  SpeedDialChild(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Focus(
                      focusNode: widget.includeTutorial
                        ? GetIt.I<Tutorials>().kanaTableScreenTutorial.focusNodes![3+i]
                        : null,
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              // show kana with dakuten
                              if(i == 0)
                                const FittedBox(
                                  child: Text(
                                    "だ",
                                    style: TextStyle(fontSize: 1000, color: Colors.white),
                                  )
                                ),
                              // show kana with small kana
                              if(i == 1)
                                const FittedBox(
                                  child: Text(
                                    "きゅ",
                                    style: TextStyle(fontSize: 1000, letterSpacing: -200, color: Colors.white),
                                  )
                                ),
                              // hiragana / katakana toggle
                              if(i == 2)
                                FittedBox(
                                  child: Text(
                                    isHiragana ? "ア" : "あ",
                                    style: const TextStyle(fontSize: 1000, color: Colors.white),
                                  )
                                ),
                              // romaji
                              if(i == 3)
                              ...[
                                  const Positioned(
                                    height: 30,
                                    width: 30,
                                    top: -4,
                                    child: FittedBox(
                                      child: Text(
                                        "あ",
                                        style: TextStyle(fontSize: 1000, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: -4,
                                    height: 18,
                                    width: 18,
                                    child: FittedBox(
                                      child: Text(
                                        "a",
                                        style: TextStyle(fontSize: 1000, color: Colors.white)
                                      ),
                                    ),
                                  )
                                ],
                              // rare kana
                              if(i == 4)
                                const FittedBox(
                                  child: Text(
                                    "ファ",
                                    style: TextStyle(fontSize: 1000, letterSpacing: -200, color: Colors.white),
                                  )
                                ),
                              
                              if(showDaku  && i == 0 || showYoon    && i == 1 ||
                                showRomaji && i == 3 || showSpecial && i == 4 )
                                Transform.rotate(
                                  angle: 45,
                                  child: Container(
                                    width: 3, height: 40, color: Colors.white,
                                  )
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: g_Dakanji_green,
                    onTap: () {
                      setState(() => menuFunctions[i]());
                    },
                  )
              ],
            ),
          )
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isPortrait = constraints.maxWidth < constraints.maxHeight;
            setCurrrentKanaTable(isPortrait);
            setResponsiveKanaTable(constraints);
        
            double popupWidth = constraints.maxWidth*0.8 > 600 ? 600 : constraints.maxWidth*0.8;
            double popupHeight = constraints.maxHeight*0.66 > 600 ? 600 : constraints.maxHeight*0.66;
        
            /// The number of columns in the grid
            int gridColumnCount = kanaTable[0].length;
            /// the number of rows in the grid
            /// +3 for the empty rows at the bottom
            int gridRowCount = kanaTable.length;
            /// the width of a cell in the grid
            double cellWidth = MediaQuery.of(context).size.width / gridColumnCount;
            /// the height of a cell in the grid
            double cellHeight = MediaQuery.of(context).size.height / gridRowCount;
        
            return Stack(
              children: [
                // main kana grid
                Positioned.fill(
                  bottom: actionButtonHeigt,
                  child: KanaGrid(
                    kanaTable,
                    isPortrait,
                    height: constraints.maxHeight-actionButtonHeigt,
                    width: constraints.maxWidth,
                    showRomaji: showRomaji,
                    onTap: (String kana) async {
                      if(GetIt.I<Settings>().kanaTable.playAudio){
                        kanaSoundPlayer.setAsset(
                          "assets/audios/kana/individuals/${convertToRomaji(kana)}.wav");
                        kanaSoundPlayer.state = mdk.PlaybackState.playing;
                      }
                      setState(() {
                        currentKana = kana;
                        currentKanaX = constraints.maxWidth /
                          gridColumnCount * getKanaX(kana) + cellWidth/2;
                        currentKanaY = (constraints.maxHeight-actionButtonHeigt) /
                          gridRowCount * getKanaY(kana) + cellHeight/2;
                        _controller.forward(from: 0).then((value) => setState((){}));
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
                              Future.delayed(const Duration(milliseconds: 50), () {
                                setState(() {
                                  currentKana = null;
                                });
                              }
                            );
                          });
                        });
                      },
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Container(
                            color: Colors.black.withValues(
                              alpha: lerpDouble(0, 0.5, _controller.value) ?? 0
                            )
                          );
                        }
                      ),
                    ),
                  ),
                // popup
                if(currentKana != null)
                  AnimatedBuilder(
                    animation: _controller,
                    child: KanaInfoCard(
                      currentKana!,
                      showAnimatedKana: _controller.isCompleted,
                      playKanaAnimationWhenOpened: _controller.isCompleted &&
                        GetIt.I<Settings>().kanaTable.playKanaAnimationWhenOpened,
                      onPlayPressed: () async {
                        if(currentKana == null) return;

                        kanaSoundPlayer.setAsset(
                          "assets/audios/kana/individuals/${convertToRomaji(currentKana!)}.wav");
                        kanaSoundPlayer.state = mdk.PlaybackState.playing;
                      },
                    ),
                    builder: (context, child) {
                      return Positioned(
                        left: lerpDouble(
                          currentKanaX-popupWidth/2,
                          (constraints.maxWidth/2 - popupWidth/2),
                          _controller.value
                        ),
                        top: lerpDouble(
                          currentKanaY-popupHeight/2,
                          (constraints.maxHeight/2 - popupHeight/2),
                          _controller.value
                        ),
                        width: popupWidth,
                        height: popupHeight,
                        child: Transform.scale(
                          scaleX: _controller.value,
                          scaleY: _controller.value,
                          child: Opacity(
                            opacity: _controller.value,
                            child: child!
                          ),
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


  /// based on the screen size, returns the current kana table
  void setResponsiveKanaTable(BoxConstraints constraints){
    // responsiveness only with base kana mode
    if(![hiragana[0][0], katakana[0][0]].contains(baseKanaTable[0][0])){
      kanaTable = baseKanaTable;
      return;
    }
    // copy table to prevent modiyfing original table
    kanaTable = baseKanaTable.map((e) => List<String>.from(e)).toList();

    // portrait
    if(constraints.maxWidth < constraints.maxHeight){
      _setPortraiKanaTable(constraints);
    }
    // landscape
    else {
      _setLandscapeKanaTable(constraints); 
    }
  }

  /// sets the kana table matching the available screen size if the app is
  /// running portrait
  void _setPortraiKanaTable(BoxConstraints constraints){
    // dakuten
    if(constraints.maxHeight > 1000){
      List<List<String>> dakuten = isHiragana
        ? hiraDakuten + hiraHandakuten
        : kataDakuten + kataHandakuten;
      kanaTable.addAll(dakuten.map((e) => List<String>.from(e)));
    }
    // combinations (normal)
    if(constraints.maxWidth > 800){
      List<List<String>> yoon = isHiragana ? hiraYoon : kataYoon;
      if(constraints.maxHeight > 1000) {
        yoon += isHiragana
          ? hiraYoonDakuten + hiraYoonHandakuten
          : kataYoonDakuten + kataYoonHandakuten;
      }

      for (int i = 0; i < yoon.length; i++) {
        kanaTable[i].addAll(yoon[i].where((e) => e != ""));
      }
    }
    // combinations (special)
    if(constraints.maxWidth > 1100){/*
      List<List<String>> special = isHiragana ? hiraSpecial : kataSpecial;
      for (int i = 0; i < special.length; i++) {
        kanaTable[i].addAll(special[i].where((e) => e != ""));
      }*/
    }
  }

  /// sets the kana table matching the available screen size if the app is
  /// running landscape
  void _setLandscapeKanaTable(BoxConstraints constraints){
    // dakuten
    if(constraints.maxWidth > 1000){
      List<List<String>> dakuten = isHiragana
        ? hiraDakuten + hiraHandakuten
        : kataDakuten + kataHandakuten;

      for (int i = 0; i < dakuten[0].length; i++) {
        kanaTable[i].addAll(dakuten.map((e) => e[i]));
      }
    }
    // combinations (normal)
    if(constraints.maxHeight > 600){
      List<List<String>> yoon = isHiragana ? hiraYoon : kataYoon;

      if(constraints.maxWidth > 1000){
        yoon += isHiragana
          ? (hiraYoonDakuten + hiraYoonHandakuten) 
          : (kataYoonDakuten + kataYoonHandakuten);
        yoon = yoon.map((rows) => rows.where((k) => k!="").toList()).toList();
      }

      kanaTable.addAll(flipTable(yoon));
    }
    // combinations (special)
    if(constraints.maxHeight > 800){
      List<List<String>> kana = isHiragana ? hiraSpecial : kataSpecial;
      kanaTable.addAll(flipTable(kana));
    }
  }

  /// Returns the x position of the kana in the kana table
  double getKanaX(String kana){
    for(int i = 0; i < kanaTable.length; i++){
      for(int j = 0; j < kanaTable[i].length; j++){
        if(kanaTable[i][j] == kana){
          return j.toDouble();
        }
      }
    }
    return 0;
  }
  
  /// Returns the y position of the kana in the kana table
  double getKanaY(String kana){
    for(int i = 0; i < kanaTable.length; i++){
      for(int j = 0; j < kanaTable[i].length; j++){
        if(kanaTable[i][j] == kana){
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
        baseKanaTable = hiraYoon;
      }
      else if(showDaku){
        baseKanaTable = hiraDaku;
      }
      else if(showSpecial){
        baseKanaTable = hiraSpecial;
      }
      else{
        baseKanaTable = hiragana;
      }
    }
    else {
      if(showYoon){
        baseKanaTable = kataYoon;
      }
      else if(showDaku){
        baseKanaTable = kataDaku;
      }
      else if(showSpecial){
        baseKanaTable = kataSpecial;
      }
      else{
        baseKanaTable = katakana;
      }
    }

    // check if kana table should be flipped, if so flip table
    if(!isPortrait){
      baseKanaTable = flipTable(baseKanaTable);
    }
  }

  // flip `table` at the main diagonal by swapping the elements
  List<List<String>> flipTable(List<List<String>> table){
    List<List<String>> temp = List.generate(table.map((e) => e.length).reduce(max), (index) => 
        List.generate(table.length, (index) => "")
      );
      for(int i = 0; i < table.length; i++){
        for(int j = 0; j < table[i].length; j++){
          temp[j][i] = table[i][j];
        }
      }

    return temp;
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

  /// Toggles between showing and not showing special characters
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

  /// Update the values in the settings with the values currently set by the
  /// user
  void updateSettings(){
    GetIt.I<Settings>().kanaTable.isHiragana = isHiragana;
    GetIt.I<Settings>().kanaTable.showRomaji = showRomaji;
    GetIt.I<Settings>().kanaTable.showDaku = showDaku;
    GetIt.I<Settings>().kanaTable.showYoon = showYoon;
    GetIt.I<Settings>().kanaTable.showSpecial = showSpecial;
    GetIt.I<Settings>().save();
  }
}
