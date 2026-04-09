// Flutter imports:
// Project imports:
import 'package:da_kanji_mobile/features/screen_saver/widgets/screen_saver.dart';
import 'package:flutter/material.dart';

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
