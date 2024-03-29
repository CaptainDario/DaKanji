// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// The loading spinner to show while loading data
class DaKanjiLoadingIndicator extends StatelessWidget {

  const DaKanjiLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitSpinningLines(
      color: g_Dakanji_green,
      lineWidth: 3,
      size: 30.0,
      itemCount: 10,
    );
  }
}
