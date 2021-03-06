import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:da_kanji_mobile/model/SettingsArguments.dart';
import 'package:da_kanji_mobile/globals.dart';



/// One list tile for drawer
/// 
/// Layout:
///   padding | icon | padding | title | padding
class DrawerElement extends StatelessWidget {
  DrawerElement(
    {
      required this.leading,
      required this.title,
      required this.route,
      required this.selected,
      required this.drawerWidth,
      required this.drawerController,
      this.onTap,
      Key? key
    }
  ) : super(key: key);

  /// The leading icon of this tile
  final IconData leading;
  /// The title of this tile
  final String title;
  /// The route to which will be navigated once the user taps on this tile
  final String route;
  /// if this tile is selected or not
  final bool selected;
  /// The width of the drawer
  final double drawerWidth;
  /// The AnimationController to control the drawer
  final AnimationController drawerController;
  /// Function which will be invoked when the user taps on this tile
  final Function? onTap;

  

  @override
  Widget build(BuildContext context) {

    double tileHeight = (MediaQuery.of(context).size.height * 0.1).clamp(0, 40);

    return Material(
      child: InkWell(
        onTap: () {
          if(ModalRoute.of(context)!.settings.name != this.route){
            Navigator.pushNamedAndRemoveUntil(
              context, this.route,
              (Route<dynamic> route) => false,
              arguments: SettingsArguments(true)
            );
          }
          else{
            this.drawerController.reverse();
          }
        },
        child: Container(
          width: drawerWidth,
          height: tileHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: drawerWidth*0.1,),
              Center(
                child: Icon(
                  leading,
                  color: selected ? Theme.of(context).highlightColor : null,
                  size: tileHeight*0.5,
                ),
              ),
              SizedBox(width: drawerWidth*0.05,),
              Container(
                width: drawerWidth*0.6,
                height: tileHeight*0.5,
                child: AutoSizeText(
                  title,
                  group: drawerAutoSizeGroup,
                  minFontSize: GlobalMinFontSize,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? Theme.of(context).highlightColor : null,
                  ),
                ),
              ),
              SizedBox(width: drawerWidth*0.05,)
            ]
          ),
        ),
      ),
    );
  }
}