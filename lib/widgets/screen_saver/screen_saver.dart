import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:da_kanji_mobile/entities/isar/isars.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary_word_card.dart';
import 'package:database_builder/database_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:window_manager/window_manager.dart';



/// Shows a screen saver that iterates through different dictionary entries
class ScreenSaver extends StatefulWidget {
  
  /// The dictionary entries to show
  final List<TreeNode<WordListsData>> wordLists;

  const ScreenSaver(
    this.wordLists,
    {
      super.key
    }
  );

  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver> with TickerProviderStateMixin{


  /// all entries that are shown in this screen saver
  List<JMdict> entries = [];
  /// The entry that is currently being shown
  late JMdict currentEntry;
  /// time to the next entry
  int secondsToNextEntry = 5;
  /// Random instance for deciding the next card to show
  Random nextEntryRandom = Random();
  /// timer that fires every time one vocab card cycle is over
  late Timer nextEntryTimer;
  /// The AnimationController to animate the vocab cards
  late AnimationController vocabCardAnimationController;
  /// The actual animation that moves the cards
  late Animation vocabCardAnimation;


  @override
  void initState() {

    if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
      WindowManager.instance.setFullScreen(true);
    }

    nextEntryTimer = Timer.periodic(
      Duration(seconds: secondsToNextEntry),
      (Timer t) { setRandomEntry(); }
    );

    vocabCardAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: secondsToNextEntry),
    )..repeat();

    vocabCardAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 10
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0),
        weight: 80
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.0, end: -1.0),
        weight: 10
      ),
    ]).animate(vocabCardAnimationController);
    
    super.initState();

  }

  @override
  void dispose() {

    if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
      WindowManager.instance.setFullScreen(false);
    }

    vocabCardAnimationController.dispose();
    nextEntryTimer.cancel();
    super.dispose();
  }

  /// Get all entries from this word list so that they can be shown as a screen
  /// saver
  Future<bool> getWordListEntries () async {

    for (var wordList in widget.wordLists) {
      final entryIDs = await GetIt.I<WordListsSQLDatabase>()
        .getEntryIDsOfWordList(wordList.id);
      entries.addAll(
        GetIt.I<Isars>().dictionary.jmdict.getAllSync(entryIDs).whereNotNull()
      );
    }

    setRandomEntry();

    return true;

  }

  /// Randomly sets the current entry
  void setRandomEntry(){
    int next = nextEntryRandom.nextInt(entries.length);
    currentEntry = entries[next];
  }

  @override
  Widget build(BuildContext context) {

    // get the current screen dimensions
    Size s = MediaQuery.sizeOf(context);
    double w = s.width;
    double h = s.height;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: h,
        width:  w,
        color: Colors.transparent,
        child: FutureBuilder(
          future: getWordListEntries(),
          builder: (context, snapshot) {
        
            // if word lists are not read yet, show nothing
            if(!snapshot.hasData) return Container();
        
            return AnimatedBuilder(
              animation: vocabCardAnimation,
              builder: (context, snapshot) {

                double cardWidth = w * 0.6;
                double cardHeight = h * 0.5;
                double animV = vocabCardAnimation.value;
                double scaleV = 1-animV.abs();

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: (w/2-cardWidth/2) + animV*w,
                      width : cardWidth,
                      height: cardHeight,
                      child: Transform.scale(
                        scale: scaleV.abs(),
                        child: Center(
                          child: SingleChildScrollView(
                            child: DictionaryWordCard(
                              currentEntry,
                              showConjugationTable: false,
                              showImageSearch: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }
}