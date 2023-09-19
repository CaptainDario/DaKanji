// Flutter imports:
import 'package:da_kanji_mobile/widgets/manual/manual_deep_links.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_feedback.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_button.dart';
import 'package:da_kanji_mobile/widgets/manual/manual_dictionary.dart';

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

  /// the text that is shown on the ManualButtons
  List<String> buttonTexts = [
    //"Drawing",
    "Dictionary", 
    //"Text",
    //"Anki"
    "Feedback",
    "Deep Links"
  ];
  /// the icons that are shown on the ManualButtons
  List<IconData> buttonIcons = [
    //Icons.brush,
    Icons.book,
    //Icons.text_snippet,
    
    //DaKanjiIcons.anki,
    Icons.feedback,
    Icons.link
  ];
  /// The size of the manual buttons
  double manualButtonSize = 200;
  

  @override
  void initState() {
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> manualTexts = [
      ManualDictionary(),
      //ManualTextScreen(),
      //ManualAnki(),
      ManualDeepLinks(),
      ManualFeedback()
    ];

    

    return DaKanjiDrawer(
      currentScreen: Screens.manual,
      drawerClosed: !widget.openedByDrawer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            runSpacing: 8,
            spacing: 8,
            children: List.generate(buttonIcons.length, (index) => 
              ManualButton(
                size: manualButtonSize,
                icon: buttonIcons[index],
                text: buttonTexts[index],
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(buttonTexts[index])
                          ),
                        ),
                        body: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              manualTexts[index]
                            ],
                          ),
                        ),
                      );
                    }
                  ));
                },
              )
            ),
          ),
        ),
      )
    );
  }
}
