import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:database_builder/database_builder.dart';

import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/domain/dictionary/floating_word.dart';




/// Widget that shows downwards floating words that can be tapped and scrolled
class FloatingWordStack extends StatefulWidget {

  /// The widget that should be rendered below the floating words
  final Widget? bottom;
  /// A list of JLPT levels to include
  final List<String> levels;
  /// Should the falling words be hidden
  final bool hide;
  /// how long to wait till the first word spawns
  final int secondsTillFirstWord;
  /// Callback that is executed when the user taps on a floating word
  final Function(FloatingWord entry)? onTap;

  const FloatingWordStack(
    {
      this.bottom,
      required this.levels,
      this.hide = false,
      this.secondsTillFirstWord = 5,
      this.onTap,
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

 
  
  @override
  void initState() {

    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FloatingWordStack oldWidget) {
    
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() async {

    for (FloatingWord entry in floatingWords) {
      entry.animationController.dispose();
    }
    floatingWords.clear();
    setState(() {});
    
    if(widget.levels.isEmpty || widget.hide) return;

    // delete current entries and wait to spawn new ones
    Future.delayed(Duration(seconds: widget.secondsTillFirstWord))
    .then((value) {
      dictEntries = getDictEntries();
      setState(() {});

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
            seconds: (((entryToBttomSeconds/(noEntriesY*2))
              * ((noEntriesY*2)-y+1))
              + (2*entryToBttomSeconds*(1-parallax))
            ).floor()
          ),
          vsync: this,
        );
        Animation anim = CurvedAnimation(
          parent: controller, 
          curve: Curves.easeInOut
        );
        final entry = FloatingWord(dictEntries[dictEntryOffset++], position, parallax, controller, anim);
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
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout())
    .size;

  }

  @override
  void dispose() {
    for (var i = 0; i < floatingWords.length; i++) {
      floatingWords[i].animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // if no level selection is made or the widget should be hidden return `widget.bottom`
    if(widget.levels.isEmpty || widget.hide){
      if(widget.bottom != null)
        return widget.bottom!;
      else
        return SizedBox();
    }

    return LayoutBuilder(
      builder: (context, constraints) {

        widgetSize = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onPanUpdate: (update) {
            for (var entry in floatingWords) {
              if(widgetSize == null) return;

              if(update.delta.dy > 0)
                entry.animationController.value += 0.005 * entry.parallax;
              else {
                entry.animationController.value -= 0.005 * entry.parallax;
              }

              entry.animationController.forward();
            }
          },
          child: Stack(
            children: [
              if(widget.bottom != null) widget.bottom!,

              // add empty container so that the gesturedetector works on the whole stack
              Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                )
              ),
              
              for (FloatingWord entry in floatingWords)
                AnimatedBuilder(
                  animation: entry.animation,
                  builder: (context, child) {
        
                    return Positioned(
                      left: entry.position.dx,
                      // interpolate the current position between the start position
                      // and the height of the available space
                      // *1.02 is important so there is no visible overlap as the cleanup
                      // is not run every frame
                      top: entry.position.dy +
                        ((widgetSize?.height ?? 0)-(entry.position.dy*1.02)) *
                          (entry.animationController.value),
                      child: GestureDetector(
                        onTap: () {
                          widget.onTap?.call(entry);
                        },
                        child: Text(
                          entry.entryVerticalString,
                          style: TextStyle(
                            fontSize: entryTextStyleFontSize * min(1, entry.parallax*1.25),
                            height: entryTextStyleHeight,
                            fontFamily: g_japaneseFontFamily,
                            color: (Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white
                            ).withOpacity(entry.parallax)
                          ),
                        ),
                      )
                    );
                  }
                )
            ],
          ),
        );
      }
    );
  }
}