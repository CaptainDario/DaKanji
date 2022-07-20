
import 'package:da_kanji_mobile/view/text/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:kagome_dart/kagome_dart.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';



/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class TextScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;
  
  final TextEditingController inputController = TextEditingController();

  TextScreen(this.openedByDrawer, this.includeHeroes, this.includeTutorial);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with TickerProviderStateMixin {


  Tuple2<List<String>, List<List<String>>> analyzed = Tuple2([], []);

  final double padding = 8.0;

  bool fullScreen = false;

  bool showFurigana = false;


  @override
  void initState() {
    super.initState();

    initTokenizer();

    // initialize the drawing interpreter if it has not been already
    //if(!GetIt.I<DrawingInterpreter>().wasInitialized){
    //  GetIt.I<DrawingInterpreter>().init();
    //}

    /*WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null && 
        GetIt.I<UserData>().showShowcaseDrawing && widget.includeTutorial) {

        onboarding.showWithSteps(
          GetIt.I<Tutorials>().drawScreenTutorial.drawScreenTutorialIndexes[0],
          GetIt.I<Tutorials>().drawScreenTutorial.drawScreenTutorialIndexes
        );
      }
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    

    return DaKanjiDrawer(
      currentScreen: Screens.drawing,
      animationAtStart: !widget.openedByDrawer,
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawScreenState>().strokes,
        child: LayoutBuilder(
          builder: (context, constraints){
              
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Stack(
                  children: [
                    // Text input
                    Card(
                      child: Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight/2-2*padding,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextField(
                                decoration: new InputDecoration(
                                  hintText: "Input text here..."
                                ),
                                controller: widget.inputController,
                                maxLines: null,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                onChanged: ((value) {
                                  setState(() {
                                    analyzed = runAnalyzer(value, AnalyzeModes.normal);
                                  });
                                }),
                              ),
                              SizedBox(height: padding*4,),
                              Visibility(
                                visible: widget.inputController.text.length == 0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextButton.icon(
                                        label: Text("Paste"),
                                        icon: Icon(Icons.paste),
                                        onPressed: () async {
                                          ClipboardData? d = await Clipboard.getData("text/plain");

                                          if(d != null) 
                                              widget.inputController.text = d.text!;
                                          else
                                            widget.inputController.text = "";

                                          setState(() {
                                            
                                          });
                                        }
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                    // processed
                    Positioned(
                      bottom: 0,
                      child: Card(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: constraints.maxWidth-3*padding,
                          height: !fullScreen ? 
                            constraints.maxHeight/2-2*padding : 
                            constraints.maxHeight - 3*padding,
                          child: Padding(
                            padding: EdgeInsets.all(padding),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: AnimatedContainer(
                                    width: constraints.maxWidth,
                                    height: !fullScreen ? 
                                      constraints.maxHeight/2-2*padding - 
                                      (50 + 2*padding) :
                                      constraints.maxHeight - 2*padding,
                                    duration: Duration(milliseconds: 500),
                                    child: TextWidget(
                                      texts: analyzed.item1,
                                      rubys: analyzed.item2.map(
                                        (e) => (e.length == 9 ? e[7] : "")
                                      ).toList(),
                                      
                                      showFurigana: showFurigana,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  height: 1,
                                  width: constraints.maxWidth,
                                  bottom: 25 + 24,
                                  child: Divider(),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => setState(() {
                                          showFurigana = !showFurigana;
                                        }), 
                                        icon: SvgPicture.asset(
                                          showFurigana ?
                                          "assets/images/ui/furigana_on.svg" : 
                                          "assets/images/ui/furigana_off.svg",
                                          color: Colors.white,
                                          height: 20,
                                        )
                                      ),
                                      IconButton(
                                        iconSize: 25,
                                        padding: EdgeInsets.zero,
                                        onPressed: () => setState(() {
                                          fullScreen = !fullScreen;
                                        }), 
                                        icon: Icon(!fullScreen ? 
                                          Icons.fullscreen : 
                                          Icons.fullscreen_exit
                                        )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}