import 'package:da_kanji_mobile/core/user/time_tracking/timer_status.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/settings/model/settings.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_card.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_popup_dialog.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';



class TimeTrackingAppbarAction extends StatefulWidget {
  const TimeTrackingAppbarAction({super.key});

  @override
  State<TimeTrackingAppbarAction> createState() => _TimeTrackingAppbarActionState();
}

class _TimeTrackingAppbarActionState extends State<TimeTrackingAppbarAction> with SingleTickerProviderStateMixin {
  
  final GlobalKey _iconKey = GlobalKey();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), 
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: InkWell(
        key: _iconKey,
        customBorder: const CircleBorder(),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color ?? Colors.black,
            BlendMode.srcIn,
          ),
          child: StreamBuilder<TimerStatus>(
            stream: GetIt.I<UserDataDB>().timeTrackingDao.watchCurrentStatus(),
            builder: (context, snapshot) {

              if([TimerStatus.idle, null].contains(snapshot.data)){
                _controller.reset();
                _controller.stop();
              }
              else if (snapshot.data! == TimerStatus.running)
                _controller.repeat();

              if([TimerStatus.running, TimerStatus.idle].contains(snapshot.data))
                return Lottie.asset(
                  'assets/animations/stop_watch.json',
                  width:  32,
                  height: 32,
                  controller: _controller,
                );
              else if (TimerStatus.paused == snapshot.data)
                return Icon(
                  Icons.free_breakfast_outlined,
                  color: Theme.of(context).iconTheme.color ?? Colors.black,
                );
              else return SizedBox();
            },
          ),
        ),
        onTap: () {
          showTimeTrackingPopup(
            context: context,
            iconKey: _iconKey,
            child: TimeTrackingCard(
              accentColor: g_color_scheme_blue,
              secondaryAccentColor: g_color_scheme_green,
              negativeBreakColor: g_color_scheme_red,
              sessionLength: Duration(minutes: context.read<Settings>().timeTracking.sessionLength),
              studyBreakRatio: context.read<Settings>().timeTracking.breakLength / context.read<Settings>().timeTracking.sessionLength,
            ),
          );
        },
      ),
    );
  }
}