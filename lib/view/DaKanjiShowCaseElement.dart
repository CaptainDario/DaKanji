import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';



class DaKanjiShowCaseElement extends StatelessWidget {
  const DaKanjiShowCaseElement(
    this.featureId,
    this.description,
    this.contentLocation,
    this.widgetToExplain,
    {Key? key}
  ) : super(key: key);

  /// The widget which this showcase should explain
  final Widget widgetToExplain;
  /// The id of the widget which should be explained
  /// If the list contains more than one element multiple show cases will be shown
  final List<String> featureId;
  /// the description of the showcased element
  /// /// If the list contains more than one element multiple show cases will be shown
  final List<Widget> description;
  /// If the list contains more than one element multiple show cases will be shown
  /// The location of the description
  final List<ContentLocation> contentLocation;



  @override
  Widget build(BuildContext context) {

    assert(featureId.length == description.length &&
      featureId.length == contentLocation.length);

    Widget explainedWidget = widgetToExplain;

    for (int i = 0; i < featureId.length; i++){
      explainedWidget = DescribedFeatureOverlay(
      backgroundColor: Color.fromARGB(0, 44, 44, 44),
      backgroundOpacity: 0.5,
      targetColor: Color.fromARGB(59, 255, 255, 255),

      featureId: featureId[i],
      tapTarget: Icon(Icons.touch_app),
      description: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: description[i]
      ),

      contentLocation: contentLocation[i],

      child: explainedWidget
    );
    }

    return explainedWidget;
  }
}