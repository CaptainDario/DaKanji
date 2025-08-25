// Dart imports:
import 'dart:async';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:database_builder/database_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dictionary/falling_word_stack_controller.dart';
import 'package:da_kanji_mobile/entities/dictionary/floating_word.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/settings/settings.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:provider/provider.dart';

/// Widget that shows downwards floating words that can be tapped and scrolled
class FloatingWordStack extends StatefulWidget {

  /// The widget that should be rendered below the floating words
  final Widget? child;
  /// A list of JLPT levels to include
  final List<String> levels;
  /// Should the falling words be hidden
  final bool hide;
  /// how long to wait till the first word spawns
  final int secondsTillFirstWord;
  /// Callback that is executed when the user taps on a floating word
  final Function(FloatingWord entry)? onTap;
  /// The controller to invoke methods of this widget
  final Function(FloatingWordStackController controller)? onInitialized;

  const FloatingWordStack(
    {
      this.child,
      required this.levels,
      this.hide = false,
      this.secondsTillFirstWord = 5,
      this.onTap,
      this.onInitialized,
      super.key
    }
  );

  @override
  State<FloatingWordStack> createState() => _FloatingWordStackState();
}

class _FloatingWordStackState extends State<FloatingWordStack> with TickerProviderStateMixin {


  /// the size of the widget (available after first build)
  Size? widgetSize;
  /// A list of all dict entries that are floating
  List<JMdict> dictEntries = [];
  /// offset to select the next entry from `dictEntries`
  int _dictEntryOffset = 0;
  set dictEntryOffset (int newOffset){
    if(newOffset > dictEntries.length-1){
      _dictEntryOffset = 0;
      return;
    }
    
    _dictEntryOffset = newOffset;
  }
  int get dictEntryOffset {
    return _dictEntryOffset;
  }
  /// the font size of the floating words
  double entryTextStyleFontSize = 18;
  /// the text height of the floating words
  double entryTextStyleHeight = 1.05;
  /// The MINIMUM seconds for an entry to travel to the bottom, total travel
  /// time is also based on the parallax
  int entryToBttomSeconds = 20; 
  /// List of all floating words
  List<FloatingWord> floatingWords = [];
  /// List of entries that finished their animations and thus should be removed
  List<FloatingWord> removeAtNextBuild = [];
  /// The timer to start spawning the fallingowrds
  Timer? spawnEntriesTimer;
  /// controller to invoke functions of this widget
  late FloatingWordStackController floatingWordStackController;

  /// [AnimationController] to hide the falling words
  late AnimationController hideAnimationController = AnimationController(
    value: 1, upperBound: 1, lowerBound: 0,
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  /// [Animation] to hide the falling words
  late Animation hideAnimation;
 
  
  @override
  void initState() {

    floatingWordStackController = FloatingWordStackController(
      init, hideAnimationController);

    hideAnimation = CurvedAnimation(
      parent: hideAnimationController, curve: Curves.easeIn);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
      widget.onInitialized?.call(floatingWordStackController);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FloatingWordStack oldWidget) {
    
    if(MediaQuery.sizeOf(context) != widgetSize) {
      hideAnimationController.reverse().then((value) => init(),);
    }
    super.didUpdateWidget(oldWidget);

  }

  void init() async {

    debugPrint("Initialized floating words");

    hideAnimationController.value = 1.0;
    widgetSize = MediaQuery.sizeOf(context);

    for (FloatingWord entry in floatingWords) {
      entry.animationController.dispose();
    }
    floatingWords.clear();
    setState(() {});
    
    if(widget.levels.isEmpty || widget.hide) return;

    // delete current entries and wait to spawn new ones
    if(spawnEntriesTimer != null) spawnEntriesTimer!.cancel();
    spawnEntriesTimer = Timer(Duration(seconds: widget.secondsTillFirstWord), () {
      dictEntries = getDictEntries();
      setState(() {});

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if(!mounted) return;
        initEntries();
        setState(() {});
      });
    });
  }

  /// Get entries matching the settings
  List<JMdict> getDictEntries(){

    List<JMdict> entries = GetIt.I<Isars>().dictionary.jmdict
      .filter()
        .anyOf(widget.levels, (q, element) => q.jlptLevelElementContains(element))
      .findAllSync()
      ..shuffle();

    return entries;

  }

  void initEntries(){
    Random rand = Random();

    Size t = calculateTextSize(
      "口口口口口".split("").join("\n"),
      textStyle: TextStyle(height: entryTextStyleHeight, fontSize: entryTextStyleFontSize)
    );

    int noEntriesX = (widgetSize!.width/100).round();
    int noEntriesY = (widgetSize!.height/t.height).round();
    double widthSlice  = widgetSize!.width/noEntriesX;
    double heightSlice = widgetSize!.height/noEntriesY;

    for (var y = 0; y < noEntriesY; y++) {
      for (var x = 0; x < noEntriesX; x++) {
      
        Offset position = Offset(
          (x*widthSlice)+(rand.nextDouble() * (widthSlice-(x==noEntriesX-1?t.width:0))),
          (y*heightSlice+((rand.nextDouble()*0.5-1)*heightSlice))-widgetSize!.height
        );
        double parallax = (rand.nextDouble()*0.5)+0.5;
        AnimationController controller = AnimationController(
          duration: Duration(
            milliseconds: (((((entryToBttomSeconds/(noEntriesY*2))
              * ((noEntriesY*2)-y+1))
              + (2*entryToBttomSeconds*(1-parallax))
            ) * 2000) * (2-context.read<Settings>().dictionary.fallingWordsSpeed))
            .floor()
          ),
          vsync: this,
        );
        Animation anim = CurvedAnimation(
          parent: controller, 
          curve: Curves.easeInOut
        );
        final entry = FloatingWord(dictEntries[dictEntryOffset++], position,
                                    parallax, controller, anim);
        controller.addStatusListener((status) {
          // when the animation has finished
          if(status == AnimationStatus.completed){
            entry.position = Offset(
              (x*widthSlice)+(rand.nextDouble() * (widthSlice-(x==noEntriesX-1?t.width:0))),
              (y*heightSlice+((rand.nextDouble()*0.5-1)*heightSlice))-widgetSize!.height
            );
            entry.entry = dictEntries[dictEntryOffset++];
            //entry.parallax = (rand.nextDouble()*0.5)+0.5;
            entry.animationController.value = 0;
            entry.animationController.forward();

            setState(() {});
          }
        });
        controller.forward();
        floatingWords.add(entry);

      }
    }
    floatingWords.sort((a, b) => a.parallax.compareTo(b.parallax));
  }

  /// Calculates the size of the given `text` with `textStyle` if given
  Size calculateTextSize(String text, {TextStyle? textStyle}){

    return (TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textScaler: MediaQuery.of(context).textScaler,
        textDirection: TextDirection.ltr)
      ..layout())
    .size;

  }

  @override
  void dispose() {
    spawnEntriesTimer?.cancel();

    for (var i = 0; i < floatingWords.length; i++) {
      floatingWords[i].animationController.dispose();
    }
        
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanUpdate: (update) {
        for (var entry in floatingWords) {
          if(widgetSize == null) return;

          entry.animationController.value += (update.delta.dy/1000) * entry.parallax;

          entry.animationController.forward();
        }
      },
      child: Stack(
        children: [
          
          widget.child != null ? widget.child! : const SizedBox(),
          
          // no level selection is made or the widget should be hidden ?
          ...(widget.levels.isNotEmpty && !widget.hide)
            ? [
              for (FloatingWord entry in floatingWords)
                ...[
                  AnimatedBuilder(
                    animation: entry.animation,
                    builder: (context, child) {

                      // if the stack is hidden do not build widgets
                      if(hideAnimationController.value < 0.01) return const SizedBox();
          
                      return Positioned(
                        left: entry.position.dx,
                        // interpolate the current position between the start position
                        // and the height of the available space
                        // *1.02 is important so there is no visible overlap as the cleanup
                        // is not run every frame
                        top: entry.position.dy +
                          ((widgetSize?.height ?? 0)-(entry.position.dy*1.02)) *
                            (entry.animationController.value),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              widget.onTap?.call(entry);
                            },
                            child: AnimatedBuilder(
                              animation: hideAnimationController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: hideAnimationController.value,
                                  child: child!);
                              },
                              child: Text(
                                entry.entryVerticalString,
                                style: TextStyle(
                                  fontSize: entryTextStyleFontSize * min(1, entry.parallax*1.25),
                                  height: entryTextStyleHeight,
                                  fontFamily: g_japaneseFontFamily,
                                  color: (!GetIt.I<Settings>().advanced.iAmInTheMatrix
                                    ? Theme.of(context).brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white
                                    : const Color.fromARGB(255, 3, 160, 98)
                                  ).withValues(alpha: entry.parallax)
                                ),
                              ),
                            ),
                          ),
                        )
                      );
                    }
                  )
                ]
              ]
            : [const SizedBox()]
        ],
      ),
    );
  }
}
