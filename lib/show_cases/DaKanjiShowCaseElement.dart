import 'package:flutter/material.dart';




class DaKanjiShowCaseElement extends StatelessWidget {
  const DaKanjiShowCaseElement(
    this.featureId,
    this.description,
    this.widgetToExplain,
    {
      this.onComplete,
      this.onSkipPressed,
      Key? key
    }
  ) : super(key: key);

  /// The id of the widget which should be explained
  /// If the list contains more than one element multiple show cases will be shown
  final List<String> featureId;
  /// the description of the showcased element
  /// /// If the list contains more than one element multiple show cases will be shown
  final List<Widget> description;
  /// the function to run when the user clicked 
  final List<Future<bool> Function()?>? onComplete;
  /// When the SKIP button is pressed
  final Function()? onSkipPressed;
  /// The widget which this showcase should explain
  final Widget widgetToExplain;



  @override
  Widget build(BuildContext context) {


    Widget explainedWidget = widgetToExplain;

    for (int i = 0; i < featureId.length; i++){}

    return widgetToExplain;
  }
}