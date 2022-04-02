import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/show_cases/DaKanjiShowCaseElement.dart';
import 'package:da_kanji_mobile/model/UserData.dart';



class DrawScreenShowCaseElement extends StatelessWidget {
  const DrawScreenShowCaseElement(
    this.featureId,
    this.description,
    this.contentLocation,
    this.widgetToExplain,
    {
      this.onComplete,
      Key? key
    }
  ) : super(key: key);

  /// The id of the widget which should be explained
  /// If the list contains more than one element multiple show cases will be shown
  final List<String> featureId;
  /// the description of the showcased element
  /// /// If the list contains more than one element multiple show cases will be shown
  final List<Widget> description;
  /// If the list contains more than one element multiple show cases will be shown
  /// The location of the description
  final List<ContentLocation> contentLocation;
  /// the function to run when the user clicked 
  final List<Future<bool> Function()?>? onComplete;
  /// The widget which this showcase should explain
  final Widget widgetToExplain;

  @override
  Widget build(BuildContext context) {
    return DaKanjiShowCaseElement(
      featureId,
      description,
      contentLocation,
      widgetToExplain,
      onComplete: onComplete,
      onSkipPressed: () {
        GetIt.I<UserData>().showShowcaseDrawing = false;
        GetIt.I<UserData>().save();
        FeatureDiscovery.dismissAll(context);
      },
    );
  }
}