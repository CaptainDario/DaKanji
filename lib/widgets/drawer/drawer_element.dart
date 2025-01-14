// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/navigation_arguments.dart';
import 'package:da_kanji_mobile/globals.dart';

/// One list tile for drawer
/// 
/// Layout:
///   padding | icon | padding | title | padding
class DrawerElement extends StatelessWidget {

  /// The leading icon of this tile
  final IconData leading;
  /// The alignment of the leading icon, default to center
  final Alignment leadingAlignment;
  /// The size of the icon in percentage of the available space
  final double leadingSize;
  /// The title of this tile
  final String title;
  /// The route to which will be navigated once the user taps on this tile
  final String? route;
  /// if this tile is selected or not
  final bool selected;
  /// The width of the drawer
  final double drawerWidth;
  /// index of this tile in the reorderable list view
  final int index;
  /// The AnimationController to control the drawer
  final AnimationController drawerController;
  /// Function which will be invoked when the user taps on this tile
  /// If null tapping will result in navigating to `this.route`
  /// Otherwise will execute the function
  final Function? onTap;


  DrawerElement(
    {
      required this.leading,
      this.leadingAlignment = Alignment.center,
      this.leadingSize = 0.5,
      required this.title,
      required this.route,
      required this.selected,
      required this.drawerWidth,
      required this.index,
      required this.drawerController,
      this.onTap,
    }
  ) : super(key: Key("$index"));

  

  @override
  Widget build(BuildContext context) {

    double tileHeight = (MediaQuery.of(context).size.height * 0.1).clamp(0, 40);

    return ReorderableDelayedDragStartListener(
      index: index,
      child: Material(
        child: InkWell(
          onTap: () {
            if(onTap == null && route != null){
              if(ModalRoute.of(context)!.settings.name != route){
                Navigator.pushNamedAndRemoveUntil(
                  context, route!,
                  (Route<dynamic> route) => false,
                  arguments: NavigationArguments(true)
                );
              }
              else{
                drawerController.reverse();
              }
            }
            else{
              onTap!(context);
            }
          },
          child: SizedBox(
            width: drawerWidth,
            height: tileHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: drawerWidth*0.1,),
                Center(
                  child: Align(
                    alignment: leadingAlignment,
                    child: SizedBox(
                      width: drawerWidth*0.1,
                      child: Icon(
                        leading,
                        color: selected ? Theme.of(context).highlightColor : null,
                        size: tileHeight*leadingSize,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: drawerWidth*0.05,),
                SizedBox(
                  width: drawerWidth*0.6,
                  height: tileHeight*0.5,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: selected ? Theme.of(context).highlightColor : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: drawerWidth*0.05,)
              ]
            ),
          ),
        ),
      ),
    );
  }
}
