import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/dashed_ring_painter.dart';



class PausedClockFace extends StatelessWidget {
  final Duration currentElapsed;
  final Duration activePauseDuration;
  final Duration earnedBreak;
  final Color accentColor;
  final Color negativeBreakColor;
  final AnimationController dashAnimationController;

  const PausedClockFace({
    super.key,
    required this.currentElapsed,
    required this.activePauseDuration,
    required this.earnedBreak,
    required this.accentColor,
    required this.negativeBreakColor,
    required this.dashAnimationController,
  });

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    if (d.inHours > 0) return "${twoDigits(d.inHours)}:$minutes:$seconds";
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final Duration remainingBreak = earnedBreak - activePauseDuration;
    final bool hasBreakLeft = remainingBreak.inSeconds >= 0;
    
    // UI Variables
    final Color ringColor = hasBreakLeft ? accentColor : negativeBreakColor;
    final String breakText = hasBreakLeft
        ? _formatDuration(remainingBreak)
        : "-${_formatDuration(remainingBreak.abs())}";
    final Color breakTextColor = hasBreakLeft ? Colors.white : negativeBreakColor;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: dashAnimationController,
          builder: (context, child) {
            return SizedBox(
              width: 230,
              height: 230,
              child: CustomPaint(
                painter: AnimatedDashedStopwatchPainter(
                  color: ringColor,
                  progress: dashAnimationController.value,
                ),
              ),
            );
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow_rounded, color: Colors.grey[600], size: 32),
            const SizedBox(height: 4),
            Text(
              breakText,
              style: TextStyle(
                color: breakTextColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "SESSION: ${_formatDuration(currentElapsed)}",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w500,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ],
    );
  }
}