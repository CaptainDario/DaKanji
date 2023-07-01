import 'dart:async';
import 'dart:math';
import 'package:da_kanji_mobile/domain/isar/isars.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/domain/dictionary/floating_word.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';



/// Widget that shows downwards floating words that can be tapped and scrolled
class FloatingWordStack extends StatefulWidget {

  /// The widget that should be rendered below the floating words
  final Widget? bottom;
  /// Callback that is executed when the user taps on a floating word
  final Function(FloatingWord entry)? onTap;

  const FloatingWordStack(
    {
      this.bottom,
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
  /// the font size of the floating words
  double entryTextStyleFontSize = 18;
  /// the text height of the floating words
  double entryTextStyleHeight = 1.05;
  /// The MINIMUM seconds for an entry to travel to the bottom, total travel
  /// time is also based on the parallax
  int entryToBttomSeconds = 10;
  /// how long to wait till the first word spawns
  int secondsTillFirstWord = 0;
  /// List of all floating words
  List<FloatingWord> entries = [];
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

  void init(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      entries.clear();

      initEntries();

      setState(() {});
    });
  }

  List<JMdict> getDictEntry(int offset, {int amount = 1}){

    List<JMdict> entries = GetIt.I<Isars>().dictionary.jmdict
      .filter()
        .jlptLevelElementContains("3")
        .offset(offset)
        .limit(amount)
        .findAllSync();

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

    List<JMdict> dictEntries = getDictEntry(0, amount: noEntriesY*noEntriesY);

    for (var y = 0; y < noEntriesY; y++) {
      for (var x = 0; x < noEntriesX; x++) {
      
        final e = dictEntries[y*noEntriesX+x];
        String word = (e.kanjis.isNotEmpty
          ? e.kanjis.first
          : e.readings.first);
        if (word.runes.length > 1)
          word = word.toString().split("").join("\n");

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
        final entry = FloatingWord(word, position, parallax, controller, anim);
        controller.addStatusListener((status) {
          // when the animation has finished
          if(status == AnimationStatus.completed){
            entry.position = Offset(
              (x*widthSlice)+(rand.nextDouble() * (widthSlice-(x==noEntriesX-1?t.width:0))),
              (y*heightSlice+((rand.nextDouble()*0.5-1)*heightSlice))-widgetSize!.height
            );
            //entry.parallax = (rand.nextDouble()*0.5)+0.5;
            entry.animationController.value = 0;
            entry.animationController.forward();
            setState(() {});
          }
        });
        controller.forward();
        entries.add(entry);

      }
    }
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
    for (var i = 0; i < entries.length; i++) {
      entries[i].animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {

        widgetSize = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onPanUpdate: (update) {
            for (var entry in entries) {
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
              
              for (int i = 0; i < entries.length; i++)
                AnimatedBuilder(
                  animation: entries[i].animation,
                  builder: (context, child) {
        
                    return Positioned(
                      left: entries[i].position.dx,
                      // interpolate the current position between the start position
                      // and the height of the available space
                      // *1.02 is important so there is no visible overlap as the cleanup
                      // is not run every frame
                      top: entries[i].position.dy +
                        ((widgetSize?.height ?? 0)-(entries[i].position.dy*1.02)) *
                          (entries[i].animationController.value),
                      child: GestureDetector(
                        onTap: () {
                          widget.onTap?.call(entries[i]);
                          print(entries[i].entry);
                        },
                        child: Text(
                          entries[i].entry,
                          style: TextStyle(
                            fontSize: entryTextStyleFontSize * min(1, entries[i].parallax*1.25),
                            height: entryTextStyleHeight,
                            fontFamily: g_japaneseFontFamily,
                            color: (Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white
                            ).withOpacity(entries[i].parallax)
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