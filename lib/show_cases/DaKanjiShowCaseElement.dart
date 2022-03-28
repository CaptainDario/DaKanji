import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';



class DaKanjiShowCaseElement extends StatelessWidget {
  const DaKanjiShowCaseElement(
    this.featureId,
    this.description,
    this.contentLocation,
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
  /// If the list contains more than one element multiple show cases will be shown
  /// The location of the description
  final List<ContentLocation> contentLocation;
  /// the function to run when the user clicked 
  final List<Future<bool> Function()?>? onComplete;
  /// When the SKIP button is pressed
  final Function()? onSkipPressed;
  /// The widget which this showcase should explain
  final Widget widgetToExplain;



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
        description: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: description[i]
            ),
            GestureDetector(
              onTap: onSkipPressed,
              child: Text(
                "\n\n${LocaleKeys.DrawScreen_tutorial_skip.tr()}\n",
                textScaleFactor: 0.75,
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),

        contentLocation: contentLocation[i],

        onBackgroundTap: () => Future(() => false),
        onDismiss: () => Future(() => false),
        onComplete: onComplete?[i],

        child: explainedWidget
      );
    }

    return explainedWidget;
  }
}