import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// A popup used for showing dictionary entries and translations. Given a
/// text.
class TextAnalysisPopup extends StatefulWidget {
  
  const TextAnalysisPopup(
    {
      required this.text,
      this.allowDeconjugation=true,
      this.onMovedViaHeader,
      this.onResizedViaCorner,
      Key? key
    }) : super(key: key);

  /// The text shown in this widget
  final String text;

  final bool allowDeconjugation;
  /// Callback that is executed when the popup was moved by dragging it at the 
  /// header
  final Function(PointerMoveEvent)? onMovedViaHeader;
  /// Callback that is executed when the popup is resized via its corner
  final Function(PointerMoveEvent)? onResizedViaCorner;
  

  @override
  State<TextAnalysisPopup> createState() => _TextAnalysisPopupState();
}

class _TextAnalysisPopupState extends State<TextAnalysisPopup> {
  
  /// A list containing the names for all tabs in the popup
  late List<String> tabNames;

  InAppWebViewController? webController;


  @override
  void initState() {
    super.initState();

    tabNames = [LocaleKeys.DictionaryScreen_title.tr()];
    if(g_webViewSupported)
      tabNames.add("Deepl");
  }

  @override
  void didUpdateWidget(covariant TextAnalysisPopup oldWidget) {
    setState(() {
      // load new URL
      if(webController != null)
        webController?.loadUrl(
          urlRequest: URLRequest(
            url: WebUri(Uri.parse("$g_deepLUrl${widget.text}").toString())
          )
        );
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2 - (g_webViewSupported ? 0 : 1),
      child: Stack(
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
                        mouseCursor: SystemMouseCursors.move,
                        labelColor: Theme.of(context).highlightColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).highlightColor,
                        onTap: (tabNo){
                          if(tabNames[tabNo] != "Deepl"){
                            webController = null;
                          }
                        },
                        tabs: List.generate(tabNames.length, (index) =>
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              tabNames[index],
                            ),
                          )
                        ) 
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Dictionary(
                            false, 
                            initialSearch: widget.text,
                            includeDrawButton: false,
                            isExpanded: true,
                            allowDeconjugation: widget.allowDeconjugation,
                          ),
                          if(g_webViewSupported)
                            Card(
                              child: InAppWebView(
                                //key: Key(widget.text),
                                gestureRecognizers: 
                                  Set()..add(
                                    Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                                  ),
                                initialUrlRequest: (
                                  URLRequest(
                                    url: WebUri("$g_deepLUrl${widget.text}")  
                                  )
                                ),
                                onWebViewCreated: (controller) {
                                  webController = controller;
                                },
                              ),
                            )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
      ),
    );
  }
}