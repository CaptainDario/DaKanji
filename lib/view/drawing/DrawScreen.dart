import 'package:da_kanji_mobile/view/drawing/DrawScreenClearButton.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenDrawingCanvas.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenMultiCharSearch.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenPredictionButtons.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenUndoButton.dart';
import 'package:da_kanji_mobile/view/ScreenWelcomeOverlay.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/show_cases/DrawScreenShowcase.dart';
import 'package:da_kanji_mobile/provider/drawing/DrawScreenState.dart';
import 'package:da_kanji_mobile/provider/drawing/DrawScreenLayout.dart';
import 'package:da_kanji_mobile/provider/UserData.dart';
import 'package:da_kanji_mobile/view/DaKanjiDrawer.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenResponsiveLayout.dart';
import 'package:da_kanji_mobile/model/HandlePredictions.dart';



/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class DrawScreen extends StatefulWidget {

  /// init the tutorial of the draw screen
  final showcase = DrawScreenShowcase();
  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;

  DrawScreen(this.openedByDrawer, this.includeHeroes);

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> with TickerProviderStateMixin {
  /// the size of the canvas widget
  late double _canvasSize;
  /// The controller of the webview which is used to show a dict in landscape
  WebViewController? landscapeWebViewController;
  /// in which layout the DrawScreen is being built
  DrawScreenLayout drawScreenLayout = GetIt.I<DrawScreenState>().drawScreenLayout;
  /// should the welcome screen which introduces the tutorial be shown
  bool showWelcomeToTheDrawingscreen = true;


  @override
  void initState() {
    super.initState();

    GetIt.I<DrawScreenState>().drawingLookup.addListener(() {
      if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.LandscapeWithWebview ||
        GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.PortraitWithWebview)
        landscapeWebViewController?.loadUrl(
          openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
        );
    });

    // initialize the drawing interpreter if it has not been already
    if(!GetIt.I<DrawingInterpreter>().wasInitialized){
      GetIt.I<DrawingInterpreter>().init();
    }

  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I<DrawScreenState>().drawingLookup.removeListener(() {
      if(GetIt.I<DrawScreenState>().drawScreenLayout == DrawScreenLayout.LandscapeWithWebview)
        landscapeWebViewController?.loadUrl(
          openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
        );
    });
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

            // set layout and canvas size
            var t = GetDrawScreenLayout(constraints);
            GetIt.I<DrawScreenState>().drawScreenLayout = t.item1;
            GetIt.I<DrawScreenState>().canvasSize = t.item2;
            _canvasSize = t.item2;


            return Stack(
              children: [
                DrawScreenResponsiveLayout(
                  DrawScreenDrawingCanvas(_canvasSize, GetIt.I<DrawingInterpreter>()),
                  DrawScreenPredictionButtons(drawScreenIsLandscape(t.item1), _canvasSize, this.widget.includeHeroes), 
                  DrawScreenMultiCharSearch(_canvasSize, drawScreenIsLandscape(t.item1), widget.includeHeroes),
                  DrawScreenUndoButton(_canvasSize),
                  DrawScreenClearButton(_canvasSize),
                  _canvasSize,
                  GetIt.I<DrawScreenState>().drawScreenLayout,
                  () {
                    return drawScreenIncludesWebview(t.item1) ?
                      WebView(
                        initialUrl: openWithSelectedDictionary(""),
                        onWebViewCreated: (controller) => landscapeWebViewController = controller
                      ) : null;
                  } ()
                  
                ),
                if(showWelcomeToTheDrawingscreen && GetIt.I<UserData>().showShowcaseDrawing)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showWelcomeToTheDrawingscreen = false;
                        Future.delayed(Duration(milliseconds: 500));
                        FeatureDiscovery.discoverFeatures(
                          context,
                          const <String>{ // Feature ids for every feature that you want to showcase in order.
                            'draw_screen_01',
                          },
                        ); 
                      });
                    },
                  child: DrawScreenWelcomeOverlay(
                    LocaleKeys.DrawScreen_tutorial_begin_title.tr() + '\n',
                    LocaleKeys.DrawScreen_tutorial_begin_text.tr() + '\n',
                    LocaleKeys.DrawScreen_tutorial_begin_continue.tr(),
                  )
                )
              ]
            );
          }
        ),
      ),
    );
  }
}
