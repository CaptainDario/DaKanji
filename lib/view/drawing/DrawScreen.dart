import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/Screens.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawingInterpreter.dart';
import 'package:da_kanji_mobile/show_cases/ScreenWelcomeOverlay.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenState.dart';
import 'package:da_kanji_mobile/model/DrawScreen/DrawScreenLayout.dart';
import 'package:da_kanji_mobile/model/UserData.dart';
import 'package:da_kanji_mobile/view/drawer/Drawer.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenResponsiveLayout.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenClearButton.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenDrawingCanvas.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenMultiCharSearch.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenPredictionButtons.dart';
import 'package:da_kanji_mobile/view/drawing/DrawScreenUndoButton.dart';
import 'package:da_kanji_mobile/helper/HandlePredictions.dart';



/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class DrawScreen extends StatefulWidget {

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
  bool showWelcomeToTheDrawingscreen = GetIt.I<UserData>().showShowcaseDrawing;


  @override
  void initState() {
    super.initState();

    GetIt.I<DrawScreenState>().drawingLookup.addListener(() {
      if(drawScreenIncludesWebview(GetIt.I<DrawScreenState>().drawScreenLayout))
        landscapeWebViewController?.loadUrl(
          openWithSelectedDictionary(GetIt.I<DrawScreenState>().drawingLookup.chars)
        );
    });

    // initialize the drawing interpreter if it has not been already
    if(!GetIt.I<DrawingInterpreter>().wasInitialized){
      GetIt.I<DrawingInterpreter>().init();
    }
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      final OnboardingState? onboarding = Onboarding.of(context);
      if (onboarding != null) {
        onboarding.show();
      }
    });
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
                if(GetIt.I<UserData>().showShowcaseDrawing)

                Visibility(
                  visible: GetIt.I<UserData>().showShowcaseDrawing,
                  child: Container(
                    width: double.infinity, 
                    height: double.infinity,
                    color: MediaQuery.of(context).platformBrightness == Brightness.dark ?
                      Color.fromARGB(199, 32, 32, 32) : 
                      Color.fromARGB(220, 0, 0, 0),
                  )
                ),
              
                if(showWelcomeToTheDrawingscreen && GetIt.I<UserData>().showShowcaseDrawing)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showWelcomeToTheDrawingscreen = false;
                          Future.delayed(Duration(milliseconds: 500));
                          
                        });
                      },
                    child: ScreenWelcomeOverlay(
                      LocaleKeys.DrawScreen_tutorial_begin_title.tr() + '\n',
                      LocaleKeys.DrawScreen_tutorial_begin_text.tr() + '\n',
                      LocaleKeys.DrawScreen_tutorial_begin_continue.tr(),
                    )
                  ),
              ]
            );
          }
        ),
      ),
    );
  }
}
