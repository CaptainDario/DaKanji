import 'package:da_kanji_mobile/data/screens.dart';
import 'package:flutter/material.dart';



/// Class to bundle the data of onedrawer entry
class DrawerEntry {

  /// The icon of this drawer tile
  IconData icon;
  /// The title of this tile
  String title;
  /// The route to which this tile should navigate
  /// If this is `null` no navigation will be executed
  String? route;
  /// The [Screens] entry to which this tile will navigate
  Screens? screen;
  /// the icon size of this tile
  double? iconSize;
  /// The alignment of the icon of this tile
  Alignment? iconAlignment;
  /// Should this tile be included in the drawer
  /// info: mainly used for disabling certain routes for releases
  bool include;
  /// Callback that should be executed when this entry has been tapped
  Function? onTap;



  DrawerEntry(
    this.icon,
    this.title,
    this.route,
    this.screen,
    this.iconSize,
    this.iconAlignment,
    this.include,
    this.onTap
  );


}