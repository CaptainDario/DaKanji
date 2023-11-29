// Flutter imports:
import 'dart:async';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_kanji_tab.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';

class KanjiMap extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  /// A search term that should be the initial search
  final String? initialSearch;
  /// Should the first result of the initial search be openend (if one exists)
  final bool openFirstResult;


  const KanjiMap(
    this.openedByDrawer,
    this.includeTutorial,
    {
      this.initialSearch,
      this.openFirstResult = false,
      super.key
    }
  );

  @override
  State<KanjiMap> createState() => _KanjiMapState();
}

class _KanjiMapState extends State<KanjiMap> {


  ///
  List<String> kanjis = ['口' , '食', '飲', '走'];
  ///
  List<Offset> kanjiPositions = const [Offset(0, 0), Offset(1, 0), Offset(0, 1), Offset(1, 1)];
  /// the currently selected kanji
  String? currentSelection;

  int millisecondsToShowSearch = 1000;

  late RestartableTimer showSearchTimer = RestartableTimer(
    Duration(milliseconds: millisecondsToShowSearch),
    () => setState(() {showSearch=true;})
  );

  bool showSearch = true;

  /// the height of the draggable sheet
  double sheetDraggerHeight = 32;
  /// the minimum value to which the sheet can be dragged
  double minSheetPosition = 0;
  /// if the sheet is draggegd `minSHeetRange` close to the minimum value
  /// it counts as the minimum value
  double minSheetRange = 5;
  /// the maximum value to which the sheet can be dragged
  double maxSheetPosition = 0;
  /// the current sheet position
  late double sheetPosition = minSheetPosition;
  /// the height of the appbar
  late double appBarHeight = AppBar().preferredSize.height;
  /// is the sheet currently being dragged
  bool isDragging = false;


  @override
  void initState() {
     
    super.initState();

    showTutorialCallback();
  }

  @override
  void didUpdateWidget(covariant KanjiMap oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void showTutorialCallback() {
    // after first frame
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {

      if(widget.includeTutorial){
        // init tutorial
        final OnboardingState? onboarding = Onboarding.of(context);
        if(onboarding != null && GetIt.I<UserData>().showTutorialKanjiMap) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().kanjiMapScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().kanjiMapScreenTutorial.indexes!
          );
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        
        maxSheetPosition = constraints.maxHeight-appBarHeight;
        
        return Stack(
          children: [
            // kanji map
            InteractiveViewer(
              minScale: 0.1,
              boundaryMargin: const EdgeInsets.all(100),
              onInteractionStart: (details) {
                showSearchTimer.cancel();
                setState(() {showSearch = false;});
              },
              onInteractionUpdate: (details) { 
                showSearchTimer.cancel();
                setState(() {showSearch = false;});
              },
              onInteractionEnd: (details) {
                showSearchTimer.reset();
              },
              child: Stack(
                children: [
                  for (int i = 0; i < kanjis.length; i++)
                    Positioned(
                      left: 100*kanjiPositions[i].dx,
                      top: 100*kanjiPositions[i].dy,
                      width: 48,
                      height: 48,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(500)),
                        ),
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(500)),
                          onTap: (){
                            setState(() {
                              currentSelection = kanjis[i];
                              sheetPosition = maxSheetPosition;
                            });
                          },
                          child: Center(
                            child: Text(kanjis[i])
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // search bar
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              width: constraints.maxWidth-16,
              bottom:
                (currentSelection == null ? 0 : sheetDraggerHeight) +
                (showSearch ? 0 : -100)
                + 16,
              height: 32,
              left: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextField(
                    )
                  )
                ],
              )
            ),

            // drag sheet
            AnimatedPositioned(
              duration: Duration(milliseconds: isDragging ? 0 : 300),
              curve: Curves.easeOut,
              height: sheetDraggerHeight,
              width: constraints.maxWidth,
              bottom: currentSelection == null ? -sheetDraggerHeight : sheetPosition,
              child: GestureDetector(
                onVerticalDragStart: (details) => isDragging = true,
                onVerticalDragDown: (details) => isDragging = true,
                onVerticalDragEnd: (details) => isDragging = false,
                onVerticalDragCancel: () => isDragging = false,
                onVerticalDragUpdate: (details) {
                  sheetPosition = (sheetPosition - details.delta.dy).clamp(
                    minSheetPosition, maxSheetPosition);
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(sheetPosition-minSheetRange < minSheetPosition
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                      onPressed: () {
                        setState(() {
                          sheetPosition = sheetPosition-minSheetRange < minSheetPosition
                            ? maxSheetPosition
                            : minSheetPosition;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            // kanji details
            AnimatedPositioned(
              duration: Duration(milliseconds: isDragging ? 0 : 300),
              curve: Curves.easeOut,
              bottom: -constraints.maxHeight+sheetPosition+1,
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: currentSelection == null
                ? const SizedBox()
                : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: DictionaryKanjiTab(
                    GetIt.I<Isars>().dictionary.jmdict
                      .where().kanjiIndexesElementEqualTo(currentSelection!).findAllSync().first
                  ),
                )
            )
          ],
        );
      }
    );
  }



}
