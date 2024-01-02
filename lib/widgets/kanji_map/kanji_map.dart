// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:async/async.dart';
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_kanji_tab.dart';
import 'package:da_kanji_mobile/widgets/kanji_map/kanji_map_painter.dart';

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


  /// the kanji characters that should be shown in this map
  List<String> kanjis = const [];
  /// the cooridnates of `kanjis`
  List<List<double>> coors = const [];

  double leftLimit = double.infinity;

  double rightLimit = double.negativeInfinity;

  double bottomLimit = double.infinity;

  double topLimit = double.negativeInfinity;

  /// the currently selected kanji
  String? currentSelection;
  /// time till the search bar is shown again after it was hidden
  int millisecondsToShowSearch = 1000;
  /// timer that is used to show the search bar again after a certain time
  late RestartableTimer showSearchTimer = RestartableTimer(
    Duration(milliseconds: millisecondsToShowSearch),
    () => setState(() {showSearch=true;})
  );
  /// is the search currently being shown
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

    loadMapData().then((e) => setState((){}));

    showTutorialCallback();
  }

  @override
  void didUpdateWidget(covariant KanjiMap oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// Loads the kanji map data from the assets
  Future loadMapData() async {
    String kanjiJsonString = await rootBundle.loadString("assets/tflite_models/kanji_map/latent_labels.json");
    kanjis = List<String>.from(jsonDecode(kanjiJsonString));//.sublist(0, 1000);
  
    String coorJsonString = await rootBundle.loadString("assets/tflite_models/kanji_map/latent_coors_low.json");
    coors = List<List<double>>.from(jsonDecode(coorJsonString)
      .map((e) => List<double>.from(e))
      .toList());//.sublist(0, 1000);

    for (var i = 0; i < coors.length; i++) {
      for (var j = 0; j < coors[i].length; j++) {
        leftLimit   = min(leftLimit, coors[i][j]);
        rightLimit  = max(rightLimit, coors[i][j]);
        topLimit    = max(topLimit, coors[i][j]);
        bottomLimit = min(bottomLimit, coors[i][j]);
      }
    }
    print("Loaded");
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

    if(leftLimit == double.infinity) return const SizedBox();


    return LayoutBuilder(
      builder: (context, constraints) {
        
        maxSheetPosition = constraints.maxHeight-appBarHeight;
        
        return Stack(
          children: [
            // kanji map
            InteractiveViewer(
              minScale: 0.01,
              maxScale: 100000,
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
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.green,
                child: RepaintBoundary(
                  child: CustomPaint(
                    isComplex: true,
                    painter: KanjiMapPainter(
                      kanjis: kanjis,
                      coors: coors,
                      leftLimit: leftLimit,
                      topLimit: topLimit,
                      rightLimit: rightLimit,
                      bottomLimit: bottomLimit
                    ),
                  ),
                ),
              )
            ),

            // search bar
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              width: constraints.maxWidth-16,
              top: (showSearch ? 0 : -100) + 16,
              height: 32,
              left: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.search),
                  ),
                  const Expanded(
                    child: TextField(
                      
                    )
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.copy),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Icon(Icons.brush,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, -2),
                        child: const Text(
                          "部",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
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
