// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:da_kanji_mobile/application/drawing/handle_predictions.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_layout.dart';
import 'package:da_kanji_mobile/entities/drawing/draw_screen_state.dart';
import 'package:da_kanji_mobile/entities/drawing/drawing_interpreter.dart';
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/entities/show_cases/tutorials.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_clear_button.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_drawing_canvas.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_multi_char_search.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_prediction_buttons.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_responsive_layout.dart';
import 'package:da_kanji_mobile/widgets/drawing/draw_screen_undo_button.dart';

/// The "draw"-screen.
/// 
/// Lets the user draw a kanji and than shows the most likely predictions.
/// Those can than be copied / opened in dictionaries by buttons.
class DrawScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;
  /// A prefix that is prepended to every search query
  final String searchPrefix;
  /// A postfix that is appended to every search query
  final String searchPostfix;
  /// should the hero widgets for animating to the webview be included
  final bool includeHeroes;
  /// should the focus nodes for the tutorial be included
  final bool includeTutorial;

  const DrawScreen(
    this.openedByDrawer,
    this.searchPrefix,
    this.searchPostfix,
    this.includeHeroes, 
    this.includeTutorial, 
    {super.key}
  );

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> with TickerProviderStateMixin {
  /// the size of the canvas widget
  double? _canvasSize;
  /// in which layout the DrawScreen is being built
  DrawScreenLayout drawScreenLayout = GetIt.I<DrawScreenState>().drawScreenLayout;
  /// should the welcome screen which introduces the tutorial be shown
  bool showWelcomeToTheDrawingscreen = GetIt.I<UserData>().showTutorialDrawing;
  /// Future that completes and returns true when the drawing interpreter 
  /// has been initialized
  late Future<bool> initInterpter;
  /// Controller for the webview to show online dictionaries
  InAppWebViewController? inAppWebViewController;


  @override
  void initState() {
    super.initState();

    GetIt.I<DrawScreenState>().kanjiBuffer.clearKanjiBuffer();

    GetIt.I<DrawScreenState>().drawingLookup.charPrefix  = widget.searchPrefix;
    GetIt.I<DrawScreenState>().drawingLookup.charPostfix = widget.searchPostfix;

    GetIt.I<DrawScreenState>().drawingLookup.addListener(reloadWebViewUrl);

    // initialize the drawing interpreter if it has not been already
    if(!GetIt.I.isRegistered<DrawingInterpreter>()){
      GetIt.I.registerSingleton<DrawingInterpreter>(DrawingInterpreter(name: "DrawScreen"));
      initInterpter = GetIt.I<DrawingInterpreter>().init().then((value) {setState((){}); return true;});
    }
    else{
      initInterpter = Future.sync(() => true);
    }

    // init tutorial
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if(widget.includeTutorial){
        final OnboardingState? onboarding = Onboarding.of(context);
        if (onboarding != null && 
          GetIt.I<UserData>().showTutorialDrawing) {
          onboarding.showWithSteps(
            GetIt.I<Tutorials>().drawScreenTutorial.indexes![0],
            GetIt.I<Tutorials>().drawScreenTutorial.indexes!
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // free interpreter when disposing
    if(GetIt.I.isRegistered<DrawingInterpreter>()){
      GetIt.I.unregister<DrawingInterpreter>(
        disposingFunction: (p0) {
          p0.free();
        },
      );
    }
    
    // clear the canvas when leaving the screen
    GetIt.I<DrawScreenState>().strokes.deleteAllStrokes();

    GetIt.I<DrawScreenState>().drawingLookup.removeListener(reloadWebViewUrl);

  }

  @override
  Widget build(BuildContext context) {

    return DaKanjiDrawer(
      currentScreen: Screens.drawing,
      drawerClosed: !widget.openedByDrawer,
      child: ChangeNotifierProvider.value(
        value: GetIt.I<DrawScreenState>().strokes,
        child: FutureBuilder(
          future: initInterpter,
          builder: (context, snapshot) {

            // Assure that the drawing interpreter has been initialized
            if(!snapshot.hasData && snapshot.data == true) {
              return Container();
            }

            return LayoutBuilder(
              builder: (context, constraints){
                  
                // set layout and canvas size
                var t = getDrawScreenLayout(constraints);
                if(drawScreenIncludesWebview(t.item1)){
                  //inAppWebViewController = WebViewController()
                  //  ..loadRequest(Uri.parse(openWithSelectedDictionary(
                  //    GetIt.I<DrawScreenState>().drawingLookup.chars
                  //  )));
                }
                GetIt.I<DrawScreenState>().drawScreenLayout = t.item1;
                GetIt.I<DrawScreenState>().canvasSize = t.item2;
                _canvasSize = t.item2;
                  
                return DrawScreenResponsiveLayout(
                  DrawScreenDrawingCanvas(
                    _canvasSize!,
                    GetIt.I<DrawingInterpreter>(),
                    widget.includeTutorial
                  ),
                  DrawScreenPredictionButtons(
                    drawScreenIsLandscape(t.item1),
                    _canvasSize!,
                    widget.includeHeroes,
                    widget.includeTutorial
                  ), 
                  DrawScreenMultiCharSearch(
                    _canvasSize!,
                    drawScreenIsLandscape(t.item1),
                    widget.includeHeroes,
                    widget.includeTutorial
                  ),
                  DrawScreenUndoButton(_canvasSize!, widget.includeTutorial),
                  DrawScreenClearButton(_canvasSize!, widget.includeTutorial),
                  _canvasSize!,
                  GetIt.I<DrawScreenState>().drawScreenLayout,
                  drawScreenIncludesWebview(t.item1) && inAppWebViewController != null
                    ? InAppWebView()
                    : null
                );
              }
            );
          }
        ),
      ),
    );
  }

  void reloadWebViewUrl(){
    if(drawScreenIncludesWebview(GetIt.I<DrawScreenState>().drawScreenLayout)) {
      inAppWebViewController!.loadUrl(
        urlRequest: URLRequest(url: WebUri.uri(Uri.parse(openWithSelectedDictionary(
          GetIt.I<DrawScreenState>().drawingLookup.chars
        )))));
    }
  }
}
