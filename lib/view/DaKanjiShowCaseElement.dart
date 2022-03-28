import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';



class DaKanjiShowCaseElement extends StatelessWidget {
  const DaKanjiShowCaseElement(
    this.featureId,
    this.description,
    this.widgetToExplain,
    {Key? key}
  ) : super(key: key);

  /// The widget which this showcase should explain
  final Widget widgetToExplain;
  /// The id of the widget which should be explained
  final String featureId;
  /// 
  final Widget description;



  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      featureId: featureId,
      tapTarget: Icon(Icons.touch_app),
      description: description,
      backgroundColor: Color.fromARGB(0, 44, 44, 44),
      backgroundOpacity: 0.5,
      targetColor: Color.fromARGB(59, 255, 255, 255),
      child: widgetToExplain
    );
  }
}