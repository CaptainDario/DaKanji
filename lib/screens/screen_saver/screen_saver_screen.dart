// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/widgets/screen_saver/screen_saver.dart';

class ScreenSaverScreen extends StatefulWidget {

  /// The dictionary entries to show
  final List<int> wordIDs;

  const ScreenSaverScreen(
    this.wordIDs,
    {
      super.key
    }
  );

  @override
  State<ScreenSaverScreen> createState() => _ScreenSaverScreenState();
}

class _ScreenSaverScreenState extends State<ScreenSaverScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSaver(
        widget.wordIDs
      )
    );
  }

}
