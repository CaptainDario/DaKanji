import 'dart:math';

import 'package:da_kanji_mobile/show_cases/draw_screen_tutorial.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/view/folding_widget.dart';
import 'package:da_kanji_mobile/view/drawer/drawer.dart';
import 'package:da_kanji_mobile/model/screens.dart';
import 'package:get_it/get_it.dart';



/// The screen to show the manual of DaKanji
class ManualScreen extends StatefulWidget {
  
  const ManualScreen(this.openedByDrawer, {super.key});

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen>
  with SingleTickerProviderStateMixin{

  late AnimationController foldingAnimationController;
  
  @override
  void initState() {
    foldingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );

    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.manual,
      animationAtStart: !widget.openedByDrawer,
      child: LayoutBuilder(
        builder: (context, constraints) {

          double itemHeight = min(constraints.maxWidth / 3, 200);

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                //height: constraints.maxHeight,
                //width: constraints.maxWidth,
                child: FoldingWidget(
                  foldedHeight: itemHeight,
                  foldedWidth:  itemHeight,
                  unfoldedHeight: constraints.maxHeight,
                  unfoldedWidth: constraints.maxWidth,
                  unfolded: false,
                  animationController: foldingAnimationController,
                  unfoldedWidget: GestureDetector(
                    onTap: () {
                      foldingAnimationController.forward();
                      setState(() {
                        
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              //spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(5, 5)
                            )
                          ]
                        ),
                        child: Card(
                          child: Column(
                            children: List.generate(
                              DrawScreenTutorial().drawScreenTutorialTitles.length, 
                              (index) => 
                                Text(
                                  DrawScreenTutorial().drawScreenTutorialBodies[index]
                                )
                            )
                          ),
                        ),
                      ),
                    )
                  ),
                  foldedWidget: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        foldingAnimationController.reverse();
                      },
                      child: const Center(
                        child: Text("Drawing")
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      )
    );
  }
}