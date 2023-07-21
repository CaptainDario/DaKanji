import 'package:flutter/material.dart';



class KanjiTableScreen extends StatefulWidget {
  
  /// If the screen was navigated by the drawer
  final bool navigatedByDrawer;
  /// Should the tutorial be included
  final bool includeTutorial;

  const KanjiTableScreen(
    this.navigatedByDrawer,
    this.includeTutorial,
    {
      super.key
    }
  );

  @override
  State<KanjiTableScreen> createState() => _KanjiTableScreenState();
}

class _KanjiTableScreenState extends State<KanjiTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.green,
    );
  }
}