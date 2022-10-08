import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class CustomTextPopup extends StatefulWidget {
  CustomTextPopup(
    {
      required this.selectedText,
      this.onMovedViaHeader,
      this.onResizedViaCorner,
      Key? key
    }) : super(key: key);


  String selectedText;

  Function(PointerMoveEvent)? onMovedViaHeader;

  Function(PointerMoveEvent)? onResizedViaCorner;

  @override
  State<CustomTextPopup> createState() => _CustomTextPopupState();
}

class _CustomTextPopupState extends State<CustomTextPopup> {

  bool moveButtonPressed = false;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            child: Card(
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
                      child: const TabBar(
                        tabs: [
                          Text("Dictionary"),
                          Text("Translation"),
                        ],
                        
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView(
                            controller: ScrollController(),
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Imagine a Dict entries of\n\n${widget.selectedText}\n\nhere"
                                  )
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Imagine a Dict entries of\n\n${widget.selectedText}\n\nhere"
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            child: Card(
                              child: Text("Imagine a translation of\n\n${widget.selectedText}\n\nhere"),
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
                child: Container(
                  child: SvgPicture.asset(
                    "assets/fonts/icons/corner_resize.svg",
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}