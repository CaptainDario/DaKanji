// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/application/manual/manual.dart';
import 'package:da_kanji_mobile/entities/manual/manual_data.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_button.dart';

// Project imports:


/// The screen to show the manual of DaKanji
class ManualScreen extends StatefulWidget {
  
  const ManualScreen(this.openedByDrawer, {super.key});

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen>
  with TickerProviderStateMixin{

  /// The size of the manual buttons
  double manualButtonSize = 100;
  /// All manual types
  ManualData manualData = ManualData();
  

  @override
  void initState() {
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.manual,
      drawerClosed: !widget.openedByDrawer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {

              // 
              if(constraints.maxHeight > constraints.maxWidth){
                manualButtonSize = min((constraints.maxWidth-24)/2, 200);
              }
              else{
                manualButtonSize = min((constraints.maxWidth-24)/4, 200);
              }

              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: List.generate(manualData.manualTypes.length, (index) => 
                    ManualButton(
                      size: manualButtonSize,
                      icon: manualData.manualIcons[index],
                      text: manualData.manualTitles[index],
                      onPressed: () => pushManual(context, manualData.manualTypes[index]),
                    )
                  ),
                ),
              );
            }
          ),
        ),
      )
    );
  }
}
