import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_card.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_popup_dialog.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TimeTrackingAppbarAction extends StatefulWidget {
  const TimeTrackingAppbarAction({super.key});

  @override
  State<TimeTrackingAppbarAction> createState() => _TimeTrackingAppbarActionState();
}

class _TimeTrackingAppbarActionState extends State<TimeTrackingAppbarAction> {
  final GlobalKey _iconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return IconButton(
      key: _iconKey,
      icon: const Icon(DaKanjiIcons.timeTracking),
      onPressed: () {
        showTimeTrackingPopup(
          context: context,
          iconKey: _iconKey,
          child: TimeTrackingCard(
            accentColor: g_Dakanji_blue,
            secondaryAccentColor: g_Dakanji_green,
            negativeBreakColor: g_Dakanji_red,
            sessionLength: Duration(minutes: context.read<Settings>().timeTracking.sessionLength),
            studyBreakRatio: context.read<Settings>().timeTracking.breakLength / context.read<Settings>().timeTracking.sessionLength,
          ),
        );
      },
    );
  }
}