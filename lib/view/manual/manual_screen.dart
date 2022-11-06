import 'dart:math';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/view/folding_widget.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:da_kanji_mobile/view/manual/manual_dictionary.dart';



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

  /// controller for the folding animation of the folding widgets
  late AnimationController foldingAnimationController;
  /// controller for moving the manual buttons to the center
  late AnimationController movingAnimationController;
  /// animation for moving the manual buttons to the center
  late Animation movingAnimation;
  /// list containing a ID for each button (used to order the buttons in stack)
  late List<int> buttonIds;
  /// the text that is shown on the ManualButtons
  List<String> buttonTexts = ["Drawing", "Dictionary", "Text"];
  /// the icons that are shown on the ManualButtons
  List<IconData> buttonIcons = [
    Icons.brush,
    Icons.book,
    Icons.abc
  ];
  
  /// the button that was pressed last
  int lastPressedManualbutton = 0;

  @override
  void initState() {
    
    buttonIds = List.generate(buttonIcons.length, (index) => index);

    for (var i = 0; i < buttonIcons.length; i++) {
      foldingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );
    }
    
    movingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100)
    );

    movingAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0
      ).animate( CurvedAnimation(
        parent: movingAnimationController,
        curve: const Interval(
          0, 
          1, 
          curve: Curves.easeInOutCubic
        )
      )
    );

    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> manualTexts = [
      ManualDictionary(),
      ManualDictionary(),
      ManualDictionary()
    ];

    

    return DaKanjiDrawer(
      currentScreen: Screens.manual,
      animationAtStart: !widget.openedByDrawer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          
          /// the unfolded size of a ManualButton
          double unfoldedSize = min(constraints.maxWidth, constraints.maxHeight) * 0.9;
          /// the folded size of a ManualButton
          double foldedSize = unfoldedSize / 3;
          /// how many buttons can be placed in one row
          int noButtonsPerRow = constraints.maxWidth ~/ foldedSize;
          /// the margin between the `ManualButton`s
          double margin = (constraints.maxWidth - (noButtonsPerRow*foldedSize)) 
            / (noButtonsPerRow+1);

          return AnimatedBuilder(
            animation: movingAnimationController,
            builder: (context, child) {
              return Container(
                color: Colors.black.withOpacity((1.0-movingAnimation.value)*0.5),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Stack(
                  children: buttonIds.map((int id) {
                    return Positioned(
                      top: (y) {
                        return 
                          // because the folding widget is 3*size of folded widget
                          // translate it by size/3 in folded state
                          (-unfoldedSize/3) * (movingAnimation.value) +
                          // when unfolding center the widget in the given constraints
                          (constraints.maxHeight/2 - unfoldedSize/2)
                            * (1-movingAnimation.value) +
                          // add a translation based on the current index
                          (margin*(1+y) + foldedSize*(y))
                            * (movingAnimation.value);
                      } (id != 0 ? id ~/ noButtonsPerRow : 0), 
                      left: (x) {
                        return
                          // because the folding widget is 3*size of folded widget
                          // translate it by size/3 in folded state
                          (-unfoldedSize/3) * (movingAnimation.value) +
                          // when unfolding center the widget in the given constraints
                          (constraints.maxWidth/2 - unfoldedSize/2)
                            * (1-movingAnimation.value) +
                          // add a translation based on the current index
                          (margin*(1+x) + foldedSize*(x))
                            * (movingAnimation.value);
                      } (id != 0 ? id % noButtonsPerRow : 0),
                    width: unfoldedSize,
                      height: unfoldedSize,
                      child: FoldingWidget(
                        foldedHeight:   foldedSize,
                        foldedWidth:    foldedSize,
                        unfoldedHeight: unfoldedSize,
                        unfoldedWidth:  unfoldedSize,
                        unfolded: false,
                        animationController: foldingAnimationController,
                        unfoldedWidget: GestureDetector(
                          onTap: () {
                            foldingAnimationController.forward().then((value) => 
                              movingAnimationController.forward()
                            );
                          },            
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            buttonIcons[id],
                                            size: 50,
                                          ),
                                          Text(
                                            buttonTexts[id],
                                            style: TextStyle(
                                              fontSize: 30
                                            ),
                                          )
                                        ],
                                      ),
                                      manualTexts[id]
                                    ],
                                  ),
                                )
                              ),
                            ),
                          )
                        ),
                        foldedWidget: SizedBox(
                          height: foldedSize,
                          width: foldedSize,
                          child: Card(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                (i) {
                                  lastPressedManualbutton = id;
                                  buttonIds = [];
                                  for (var i = 0; i < buttonIcons.length; i++) {
                                    if(i != id) {
                                      buttonIds.add(i);
                                    }
                                  }
                                  buttonIds.add(id);
                                } (id);
                                foldingAnimationController.reverse();
                                movingAnimationController.reverse();
                              },
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      buttonIcons[id],
                                      size: 100,
                                    ),
                                    SizedBox(height: 2,),
                                    Text(
                                      buttonTexts[id],
                                      style: TextStyle(
                                        fontSize: 16
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList()
                ),
              );
            }
          );
        }
      )
    );
  }
}