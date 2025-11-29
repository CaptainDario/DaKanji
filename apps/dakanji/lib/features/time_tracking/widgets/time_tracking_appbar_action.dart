import 'package:da_kanji_mobile/core/icons/da_kanji_icons.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_card.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_popup_dialog.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



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
          child: const TimeTrackingCard(
            accentColor: g_Dakanji_blue
          ),
        );
      },
    );
  }
}