import 'package:da_kanji_mobile/data/screens.dart';
import 'package:da_kanji_mobile/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clipboard_watcher/clipboard_watcher.dart';



class ClipboardScreen extends StatefulWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  const ClipboardScreen(
    this.openedByDrawer,
    {
      super.key
    }
  );

  @override
  State<ClipboardScreen> createState() => _ClipboardScreenState();
}

class _ClipboardScreenState extends State<ClipboardScreen> with ClipboardListener {

  ClipboardData currentClipboard = ClipboardData(text: "");

  @override
  void initState() {
    clipboardWatcher.addListener(this);
    // start watch
    clipboardWatcher.start();
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  @override
  void onClipboardChanged() async {
    currentClipboard = await Clipboard.getData(Clipboard.kTextPlain) ?? ClipboardData(text: "");
    print(currentClipboard.text ?? "");
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DaKanjiDrawer(
        currentScreen: Screens.clipboard,
        animationAtStart: !widget.openedByDrawer,
        child: Container(
          child: Text(
            currentClipboard.text ?? "",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}