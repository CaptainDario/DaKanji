import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/stopwatch_painter.dart';


class RunningClockFace extends StatelessWidget {
  final int lapIndex;
  final double lapProgress;
  final Color activeColor;
  final Color trackColor;
  final double glowOpacity;
  final Duration currentElapsed;
  final bool showBreak;
  final Duration earnedBreak;
  final bool isTicking;
  final bool isResetting;

  const RunningClockFace({
    super.key,
    required this.lapIndex,
    required this.lapProgress,
    required this.activeColor,
    required this.trackColor,
    required this.glowOpacity,
    required this.currentElapsed,
    required this.showBreak,
    required this.earnedBreak,
    required this.isTicking,
    required this.isResetting,
  });

  String _formatDuration(Duration d) {
    // Ensure we format the absolute value (no negative signs inside the numbers)
    final Duration absD = d.abs();
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(absD.inMinutes.remainder(60));
    String seconds = twoDigits(absD.inSeconds.remainder(60));
    if (absD.inHours > 0) return "${twoDigits(absD.inHours)}:$minutes:$seconds";
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    // 1. Info Text Logic (Ready, Break, or Session Number)
    Widget infoWidget;
    
    if (!isTicking && !isResetting) {
      infoWidget = Text(
        LocaleKeys.TimeTrackingScreen_ready_caps.tr(),
        key: const ValueKey("ready"),
        style: TextStyle(
          color: activeColor.withValues(alpha: 0.8),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (showBreak) {
      // Logic: Handle Break Debt (Negative) vs Surplus (Positive)
      final bool isNegative = earnedBreak.isNegative;
      final String sign = isNegative ? "-" : "+";
      final String timeStr = _formatDuration(earnedBreak);

      infoWidget = Text(
        "${LocaleKeys.TimeTrackingScreen_break_caps.tr()}: $sign$timeStr",
        key: const ValueKey("break"),
        style: TextStyle(
          color: isNegative 
              ? const Color(0xFFEF5350) // Red warning color
              : Colors.white.withValues(alpha: 0.9),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      );
    } else {
      infoWidget = Text(
        "${LocaleKeys.TimeTrackingScreen_session_caps.tr()} ${lapIndex + 1}",
        key: const ValueKey("session"),
        style: TextStyle(
          color: activeColor.withValues(alpha: 0.8),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    // 2. Status Icon Logic
    // If  ticking, show "Pause" (indicating it's running).
    // If NOT ticking (Ready), show "Play" (indicating it's waiting to start).
    final IconData statusIcon = isTicking ? Icons.pause_circle_outline : Icons.play_circle_outline;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 230,
          height: 230,
          child: CustomPaint(
            painter: NeonStopwatchPainter(
              progress: lapProgress,
              lapIndex: lapIndex,
              activeColor: activeColor,
              trackColor: trackColor,
              knobRadius: 8.0,
              glowOpacity: glowOpacity,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                statusIcon, // Uses the dynamic icon defined above
                key: ValueKey(statusIcon), // Ensures animation triggers when icon changes
                color: Colors.grey[600],
                size: 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDuration(currentElapsed),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: infoWidget,
            ),
          ],
        ),
      ],
    );
  }
}