import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:da_kanji_mobile/globals.dart';



/// The loading spinner to show while loading data
class DaKanjiProgressIndicator extends StatelessWidget {
  const DaKanjiProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: g_Dakanji_green,
      lineWidth: 3,
      size: 30.0,
      itemCount: 10,
    );
  }
}