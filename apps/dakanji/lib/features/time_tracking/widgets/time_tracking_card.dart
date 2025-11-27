import 'package:da_kanji_mobile/features/time_tracking/widgets/stopwatch_painter.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_card_border_glow_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';

class TimeTrackingCard extends StatefulWidget {
  final Color accentColor;
  final Color secondaryAccentColor;
  final Duration sessionLength;
  final Duration resetDuration;
  final double studyBreakRatio;

  const TimeTrackingCard({
    super.key,
    required this.accentColor,
    this.secondaryAccentColor = const Color(0xFFFF9800), // Amber/Orange
    this.sessionLength = const Duration(seconds: 5),
    this.resetDuration = const Duration(milliseconds: 2500),
    this.studyBreakRatio = 0.2,
  });

  @override
  State<TimeTrackingCard> createState() => _TimeTrackingCardState();
}

class _TimeTrackingCardState extends State<TimeTrackingCard>
    with TickerProviderStateMixin {
  late final Ticker _ticker;
  late final AnimationController _resetController;
  late final AnimationController _glowController;
  DateTime? _startTime;

  Duration _visualDurationAtStop = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => setState(() {}));
    
    _resetController = AnimationController(
      vsync: this,
      duration: widget.resetDuration,
    );
    
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _resetController.addListener(() {
      setState(() {});
    });
    
    _resetController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _startTime = null;
          _visualDurationAtStop = Duration.zero;
          _resetController.reset();
        });
      }
    });

    _checkRunningTimer();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _resetController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _checkRunningTimer() async {
    final DateTime? runningSince =
        await GetIt.I<UserDataDB>().timeTrackingDao.getRunningTimer();
    if (runningSince != null && mounted) {
      setState(() {
        _startTime = runningSince;
        _glowController.value = 1.0; 
      });
      if (!_ticker.isActive) _ticker.start();
    }
  }

  void _toggleTimer() async {
    if (_startTime != null) {
      // --- STOP ---
      await GetIt.I<UserDataDB>().timeTrackingDao.finishSession();
      _ticker.stop();
      _glowController.reverse();

      final Duration realElapsed = DateTime.now().difference(_startTime!);
      final int sessionSeconds = widget.sessionLength.inSeconds;
      final int currentLapIndex = (sessionSeconds > 0) ? (realElapsed.inSeconds ~/ sessionSeconds) : 0;
      
      if (currentLapIndex > 2) {
        final double currentLapProgress = (realElapsed.inMilliseconds % (sessionSeconds * 1000)) / (sessionSeconds * 1000);
        final int compressedMicros = ((2 + currentLapProgress) * sessionSeconds * 1000000).toInt();
        _visualDurationAtStop = Duration(microseconds: compressedMicros);
      } else {
        _visualDurationAtStop = realElapsed;
      }

      _resetController.forward(from: 0.0);

    }
    else {
      // --- START ---
      // TODO add category + tags selection UI
      await GetIt.I<UserDataDB>().timeTrackingDao.startNewSession("","");
      final now = DateTime.now();
      
      setState(() {
        _startTime = now;
        _resetController.reset(); 
      });
      
      _glowController.forward();
      _ticker.start();
    }
  }

  ({int lapIndex, double lapProgress, Duration elapsed}) _calculateState(Duration currentElapsed) {
    final int sessionSeconds = widget.sessionLength.inSeconds;
    final int totalMilliseconds = currentElapsed.inMilliseconds;
    final int sessionMilliseconds = sessionSeconds * 1000;

    final int lapIndex =
        sessionSeconds > 0 ? (currentElapsed.inSeconds ~/ sessionSeconds) : 0;

    final double lapProgress = sessionMilliseconds > 0
        ? (totalMilliseconds % sessionMilliseconds) / sessionMilliseconds
        : 0.0;
    
    return (lapIndex: lapIndex, lapProgress: lapProgress, elapsed: currentElapsed);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    if (d.inHours > 0) return "${twoDigits(d.inHours)}:$minutes:$seconds";
    return "$minutes:$seconds";
  }

@override
  Widget build(BuildContext context) {
    const Color cardBackground = Color(0xFF1E1E1E);

    int lapIndex;
    double lapProgress;
    Duration currentElapsed;
    double glowOpacity;

    // --- ANIMATION STATE ---
    if (_resetController.isAnimating) {
      if (_resetController.value > 0.85) {
        glowOpacity = (1.0 - ((_resetController.value - 0.85) / 0.15)).clamp(0.0, 1.0);
      } else {
        glowOpacity = 1.0;
      }
    } else if (_startTime != null) {
      glowOpacity = _glowController.value;
    } else {
      glowOpacity = 0.0;
    }

    if (_resetController.isAnimating) {
      final double t = Curves.easeInOutCubic.transform(_resetController.value);
      final int startMicros = _visualDurationAtStop.inMicroseconds;
      final int currentMicros = (startMicros * (1 - t)).toInt();
      currentElapsed = Duration(microseconds: currentMicros);
    } else if (_startTime != null) {
      currentElapsed = DateTime.now().difference(_startTime!);
    } else {
      currentElapsed = Duration.zero;
    }

    final state = _calculateState(currentElapsed);
    lapIndex = state.lapIndex;
    lapProgress = state.lapProgress;

    final Duration earnedBreak = Duration(
        milliseconds: (currentElapsed.inMilliseconds * widget.studyBreakRatio).toInt());

    // --- COLORS ---
    final Color activeColor = (lapIndex == 0) ? widget.accentColor : widget.secondaryAccentColor;
    
    Color trackColor;
    if (lapIndex == 0) {
      trackColor = widget.accentColor.withValues(alpha: 0.1);
    } else if (lapIndex == 1) {
      trackColor = widget.accentColor;
    } else {
      trackColor = widget.secondaryAccentColor.withValues(alpha: 0.1);
    }

    final bool showBreak = (currentElapsed.inSeconds % 8) >= 4;
    final bool isRunning = (_startTime != null);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 320,
        height: 360,
        child: Stack(
          children: [
            // --- 1. Border Glow ---
            Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: CardBorderGlowPainter(
                    progress: lapProgress,
                    lapIndex: lapIndex,
                    activeColor: activeColor,
                    trackColor: trackColor,
                  ),
                ),
              ),
            ),

            // --- 2. Card Content ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  // --- CLICKABLE TIMER ---
                  Expanded(
                    child: GestureDetector(
                      // TAP TO START / STOP
                      onTap: _resetController.isAnimating ? null : _toggleTimer,
                      behavior: HitTestBehavior.opaque, 
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ambient Glow
                          Opacity(
                            opacity: glowOpacity,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 230,
                              height: 230,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: activeColor.withValues(alpha: 0.15),
                                    blurRadius: 40,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      
                          // Arc + Knob
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
                      
                          // Text & Icon
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Play/Pause Icon inside the timer
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  isRunning ? Icons.pause_circle_outline : Icons.play_arrow_rounded,
                                  key: ValueKey(isRunning),
                                  color: Colors.grey[600], 
                                  size: 28
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
                              // Dots
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  bool isActive = index <= lapIndex;
                                  Color dotColor = activeColor;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isActive ? dotColor : dotColor.withValues(alpha: 0.2),
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 8),
                      
                              // Info Text
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: _buildInfoText(
                                    showBreak: showBreak,
                                    lapIndex: lapIndex,
                                    earnedBreak: earnedBreak,
                                    activeColor: activeColor,
                                    isRunning: (isRunning || _resetController.isAnimating)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- BOTTOM CONTROLS ---
                  // Track Button REMOVED. Pause Button APPEARS when running.
                  SizedBox(
                    height: 60, // Fixed height to prevent layout jumps
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCircularButton(icon: Icons.category_outlined, onTap: () {}),

                        // Center Button Area
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                          child: isRunning
                              ? ElevatedButton.icon(
                                  key: const ValueKey("pause"),
                                  onPressed: _toggleTimer,
                                  icon: const Icon(Icons.pause, size: 20),
                                  label: const Text("Pause"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2C2C2C),
                                    foregroundColor: widget.secondaryAccentColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                                    shape: const StadiumBorder(),
                                    side: BorderSide(
                                      color: widget.secondaryAccentColor.withValues(alpha: 0.3),
                                      width: 1
                                    )
                                  ),
                                )
                              : const SizedBox.shrink(), // Empty when not running
                        ),

                        _buildCircularButton(icon: Icons.tag_outlined, onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText({
    required bool showBreak, 
    required int lapIndex, 
    required Duration earnedBreak, 
    required Color activeColor,
    required bool isRunning,
  }) {
    if (!isRunning) {
      return Text(
        "READY",
        key: const ValueKey("ready"),
        style: TextStyle(
          color: activeColor.withValues(alpha: 0.8),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    if (showBreak && earnedBreak.inSeconds > 0) {
      return Text(
        "BREAK: +${_formatDuration(earnedBreak)}",
        key: const ValueKey("break"),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      );
    } else {
      return Text(
        "SESSION ${lapIndex + 1}",
        key: const ValueKey("session"),
        style: TextStyle(
          color: activeColor.withValues(alpha: 0.8),
          fontSize: 12,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  Widget _buildCircularButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon),
        color: Colors.grey,
        tooltip: "Option",
      ),
    );
  }
}
