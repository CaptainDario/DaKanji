import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/view/dictionary/dictionary.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



/// A popup used for showing dictionary entries and translations. Given a
/// text.
class CustomTextPopup extends StatefulWidget {
  
  const CustomTextPopup(
    {
      required this.text,
      this.onMovedViaHeader,
      this.onResizedViaCorner,
      Key? key
    }) : super(key: key);

  /// The text shown in this widget
  final String text;
  /// Callback that is executed when the popup was moved by dragging it at the 
  /// header
  final Function(PointerMoveEvent)? onMovedViaHeader;
  /// Callback that is executed when the popup is resized via its corner
  final Function(PointerMoveEvent)? onResizedViaCorner;
  

  @override
  State<CustomTextPopup> createState() => _CustomTextPopupState();
}

class _CustomTextPopupState extends State<CustomTextPopup> {
  
  /// A list containing the names for all tabs in the popup
  late List<String> tabNames;


  @override
  void initState() {
    super.initState();

    tabNames = [LocaleKeys.DictionaryScreen_title.tr()];
    if(g_webViewSupported)
      tabNames.add("Deepl");
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
                        tabs: List.generate(tabNames.length, (index) =>
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(tabNames[index]),
                          )
                        ) 
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Dictionary(
                            key: Key(widget.text),
                            false, 
                            initialSearch: widget.text,
                            includeActionButton: false,
                            isExpanded: true,
                          ),
                          if(g_webViewSupported)
                            Card(
                              child: InAppWebView(
                                initialUrlRequest: (
                                  URLRequest(
                                    url: WebUri("$g_deepLUrl${widget.text}")  
                                  )
                                ),
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