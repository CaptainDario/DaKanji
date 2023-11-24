// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/dictionary/dictionary.dart';
import 'package:da_kanji_mobile/widgets/dojg/dojg.dart';

/// A popup used for showing dictionary entries and translations. Given a
/// text.
class TextAnalysisPopup extends StatefulWidget {
  
  /// The text shown in this widget
  final String text;
  /// Should the text be deconjugateble
  final bool allowDeconjugation;
  /// Callback that is executed when the popup was moved by dragging it at the 
  /// header
  final Function(PointerMoveEvent)? onMovedViaHeader;
  /// Callback that is executed when the popup is resized via its corner
  final Function(PointerMoveEvent)? onResizedViaCorner;
  /// Callback that is executed when the popup is initialized
  /// Provides:
  /// * the [TabController] to control the tabs of the popup
  /// as parameters
  final Function(TabController tabController)? onInitialized;

  const TextAnalysisPopup(
    {
      required this.text,
      this.allowDeconjugation=true,
      this.onMovedViaHeader,
      this.onResizedViaCorner,
      this.onInitialized,
      Key? key
    }) : super(key: key);
  

  @override
  State<TextAnalysisPopup> createState() => _TextAnalysisPopupState();
}

class _TextAnalysisPopupState extends State<TextAnalysisPopup> with SingleTickerProviderStateMixin {
  
  /// A list containing the names for all tabs in the popup
  late List<String> tabNames;
  /// controller for the webview
  WebViewController? webViewController;
  /// controller for the tabbar
  late TabController popupTabController;
  /// The last word that has been lookeup in the webview with deepl
  String lastWebViewLookup = "";


  @override
  void initState() {
    super.initState();

    tabNames = [LocaleKeys.DictionaryScreen_title.tr()];
    if(GetIt.I<UserData>().dojgImported || GetIt.I<UserData>().dojgWithMediaImported){
      tabNames.add(LocaleKeys.DojgScreen_title.tr());
    }
    if(g_webViewSupported){
      tabNames.add("Deepl");
      webViewController = WebViewController()
        ..setUserAgent(g_mobileUserAgentArg)
        ..setJavaScriptMode(JavaScriptMode.unrestricted);
    }

    popupTabController = TabController(length: tabNames.length, vsync: this);
    popupTabController.addListener(() {
      updateWebview();
    });
    widget.onInitialized?.call(popupTabController);
  }

  @override
  void didUpdateWidget(covariant TextAnalysisPopup oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      updateWebview();
    });
    super.didUpdateWidget(oldWidget);
  }

  void updateWebview() async {
    if(webViewController != null && lastWebViewLookup != widget.text) {
      await webViewController!.loadRequest(
        Uri.parse("$g_deepLUrl${widget.text}") 
      );
      lastWebViewLookup = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              )
            ]
          ),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  
                  // header
                  Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerMove: (event) {
                      if(widget.onMovedViaHeader != null) {
                        widget.onMovedViaHeader!(event);
                      }
                    },
                    child: TabBar(
                      controller: popupTabController,
                      mouseCursor: SystemMouseCursors.move,
                      labelColor: Theme.of(context).highlightColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).highlightColor,
                      tabs: List.generate(tabNames.length, (index) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tabNames[index],
                          ),
                        )
                      ) 
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: popupTabController,
                      children: [
                        Dictionary(
                          false, 
                          initialSearch: widget.text,
                          includeFallingWords: false,
                          includeDrawButton: false,
                          isExpanded: true,
                          allowDeconjugation: widget.allowDeconjugation,
                        ),
                        if(GetIt.I<UserData>().dojgImported || GetIt.I<UserData>().dojgWithMediaImported)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                            child: DoJG(
                              false,
                              false,
                              initialSearch: widget.text,
                              includeVolumeTags: false,
                              key: Key(widget.text),
                            ),
                          ),
                        if(g_webViewSupported)
                          Card(
                            child: WebViewWidget(
                              controller: webViewController!,
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                              }
                            )
                          )
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if(widget.onResizedViaCorner != null)
          Positioned(
            right: 2,
            bottom: 2,
            height: 25,
            width: 25,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeDownRight,
              child: Listener(
                onPointerMove: (event) {
                  if(widget.onResizedViaCorner != null) {
                    widget.onResizedViaCorner!(event);
                  }
                },
                child: SvgPicture.asset(
                  "assets/icons/corner_resize.svg",
                  color: Colors.grey,
                ),
              ),
            ),
          )
      ],
    );
  }
}
