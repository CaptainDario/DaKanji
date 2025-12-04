import 'package:da_kanji_mobile/features/home/controller/long_running_timer_watcher.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/paused_clock_face.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/running_clock_face.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/time_tracking_card_border_glow_painter.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/timer_control_bar.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';

class TimeTrackingCard extends StatefulWidget {
  final Color accentColor;
  final Color secondaryAccentColor;
  final Color negativeBreakColor;
  final Duration sessionLength;
  final Duration resetDuration;
  final double studyBreakRatio;

  const TimeTrackingCard({
    super.key,
    required this.accentColor,
    this.secondaryAccentColor = const Color(0xFFFF9800),
    this.negativeBreakColor = const Color(0xFFEF5350),
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
  late final AnimationController _dashAnimationController;

  /// The theoretical start time of the session.
  /// When restoring from the DB, this is calculated backwards from the total work duration.
  DateTime? _startTime;

  bool _isPaused = false;

  /// Adjusts the calculation of "current elapsed" time to account for pauses
  /// that occur while the app is open.
  Duration _pauseOffset = Duration.zero;

  /// The timestamp when the CURRENT active pause began.
  DateTime? _pauseStartTime;

  /// Used for the "shrinking" animation effect when stopping the timer.
  Duration _visualDurationAtStop = Duration.zero;
  Duration _realDurationAtStop = Duration.zero;

  /// Stores the sum of all *completed* pause intervals (historical gaps).
  /// This ensures the break timer remains accurate even after multiple resume/pause cycles.
  Duration _accumulatedPauseDuration = Duration.zero;

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

    _dashAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _resetController.addListener(() {
      setState(() {});
    });

    _resetController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _startTime = null;
          _pauseOffset = Duration.zero;
          _accumulatedPauseDuration = Duration.zero;
          _isPaused = false;
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
    _dashAnimationController.dispose();
    super.dispose();
  }

  /// Reconstructs the timer state from the database.
  /// This handles both running and paused sessions by calculating the correct
  /// start times relative to historical data to prevent time jumps or negative values.
  Future<void> _checkRunningTimer() async {
    final data =
        await GetIt.I<UserDataDB>().timeTrackingDao.getSessionRestoreData();

    if (data.hasActiveSession && mounted) {
      setState(() {
        _pauseOffset = Duration.zero;

        // Retrieve the total duration of all previous gaps/breaks
        _accumulatedPauseDuration = data.totalPauseDuration;

        if (data.isPaused) {
          // --- Restore Paused State ---
          _isPaused = true;

          // Use the actual historical timestamp for when the pause started.
          // Fallback to Now prevents null errors, though DB should provide the time.
          _pauseStartTime = data.pauseStartTime ?? DateTime.now();

          // Construct the session start time relative to when the pause *began*.
          // This ensures that (PauseStart - StartTime) equals the Total Work Done.
          // Using DateTime.now() here would cause negative elapsed times for old sessions.
          _startTime = _pauseStartTime!.subtract(data.totalWorkDuration);

          // Update visuals for paused state
          _glowController.value = 0.0;
          _dashAnimationController.repeat();
        } else {
          // --- Restore Running State ---
          _isPaused = false;

          // Since the timer is running, the work duration continues up to right now.
          _startTime = DateTime.now().subtract(data.totalWorkDuration);

          // Update visuals for running state
          _glowController.value = 1.0;
        }

        // We must start the ticker even if paused, otherwise the break timer
        // (which runs in real-time) will not update on screen.
        if (!_ticker.isActive) _ticker.start();
      });
    }
  }

  void _startTimer() async {
    // ask for permission to send notifications
    await TimeTrackingNotificationService().requestPermissions();
    
    await GetIt.I<UserDataDB>().timeTrackingDao.startNewSession(
      await GetIt.I<UserDataDB>().timeTrackingDao.getSelectedCategory(),
      await GetIt.I<UserDataDB>().timeTrackingDao.getSelectedTag(),
    );
    final now = DateTime.now();

    setState(() {
      _startTime = now;
      _pauseOffset = Duration.zero;
      _accumulatedPauseDuration = Duration.zero;
      _isPaused = false;
      _resetController.reset();
    });

    _glowController.forward();
    _ticker.start();
  }

void _stopTimer() async {
    if (_startTime == null) return;

    // 1. Capture the data we need IMMEDIATELY (Synchronously)
    Duration realElapsed;
    if (_isPaused && _pauseStartTime != null) {
      realElapsed = _pauseStartTime!.difference(_startTime!) - _pauseOffset;
    } else {
      realElapsed = DateTime.now().difference(_startTime!) - _pauseOffset;
    }
    
    // Store the real duration for the text countdown
    _realDurationAtStop = realElapsed;

    // 2. Stop the local tickers/animations IMMEDIATELY
    _ticker.stop();
    _glowController.reverse();
    _dashAnimationController.stop();

    // 3. Calculate the visual compression (Ring Animation)
    final int sessionSeconds = widget.sessionLength.inSeconds;
    final int currentLapIndex =
        (sessionSeconds > 0) ? (realElapsed.inSeconds ~/ sessionSeconds) : 0;

    if (currentLapIndex > 2) {
      final double currentLapProgress =
          (realElapsed.inMilliseconds % (sessionSeconds * 1000)) /
              (sessionSeconds * 1000);
      final int compressedMicros =
          ((2 + currentLapProgress) * sessionSeconds * 1000000).toInt();
      _visualDurationAtStop = Duration(microseconds: compressedMicros);
    } else {
      _visualDurationAtStop = realElapsed;
    }

    // 4. Start the Reset Animation
    _resetController.forward(from: 0.0);

    // 5. Update State
    setState(() {
      _isPaused = false;
      _pauseStartTime = null;
      _accumulatedPauseDuration = Duration.zero;
    });

    // 6. NOW handle the DB (Async Side Effect)
    // await this last so it doesn't block the UI responsiveness.
    await GetIt.I<UserDataDB>().timeTrackingDao.finishSession();
  }

  void _pauseTimer() async {
    // Persist the pause state to the database (close current unit)
    await GetIt.I<UserDataDB>().timeTrackingDao.pauseTimer();

    _glowController.reverse();
    _dashAnimationController.repeat();

    setState(() {
      _isPaused = true;
      _pauseStartTime = DateTime.now();
    });
  }

  void _resumeTimer() async {
    // Persist the resume state to the database (start new unit)
    await GetIt.I<UserDataDB>().timeTrackingDao.resumeTimer();

    if (_pauseStartTime != null) {
      final pauseDuration = DateTime.now().difference(_pauseStartTime!);

      // Capture the duration of the pause that just ended and add it to the history.
      // This is critical for keeping the "Break" timer correct upon subsequent pauses.
      _accumulatedPauseDuration += pauseDuration;

      _pauseOffset += pauseDuration;
      _pauseStartTime = null;
    }

    if (!_ticker.isActive) _ticker.start();
    _glowController.forward();
    _dashAnimationController.stop();

    setState(() {
      _isPaused = false;
    });
  }

  ({int lapIndex, double lapProgress, Duration elapsed}) _calculateState(
      Duration currentElapsed) {
    final int sessionSeconds = widget.sessionLength.inSeconds;
    final int totalMilliseconds = currentElapsed.inMilliseconds;
    final int sessionMilliseconds = sessionSeconds * 1000;

    final int lapIndex =
        sessionSeconds > 0 ? (currentElapsed.inSeconds ~/ sessionSeconds) : 0;

    final double lapProgress = sessionMilliseconds > 0
        ? (totalMilliseconds % sessionMilliseconds) / sessionMilliseconds
        : 0.0;

    return (
      lapIndex: lapIndex,
      lapProgress: lapProgress,
      elapsed: currentElapsed
    );
  }

@override
  Widget build(BuildContext context) {
    const Color cardBackground = Color(0xFF1E1E1E);

    int lapIndex;
    double lapProgress;
    Duration currentElapsed; // Used for TEXT and BREAK MATH
    Duration visualElapsed;  // Used for RING ANIMATION (New)
    Duration currentPauseDuration = Duration.zero;
    double glowOpacity;

    // Logic for transition animations and elapsed time calculation
    if (_resetController.isAnimating) {
      // Handle the "End Session" compression animation
      if (_resetController.value > 0.85) {
        glowOpacity =
            (1.0 - ((_resetController.value - 0.85) / 0.15)).clamp(0.0, 1.0);
      } else {
        glowOpacity = 1.0;
      }
      final double t = Curves.easeInOutCubic.transform(_resetController.value);

      // 1. CALCULATE TEXT DURATION (Count down from REAL time)
      final int startRealMicros = _realDurationAtStop.inMicroseconds;
      final int currentRealMicros = (startRealMicros * (1 - t)).toInt();
      currentElapsed = Duration(microseconds: currentRealMicros);

      // 2. CALCULATE VISUAL DURATION (Unwind from COMPRESSED time)
      final int startVisualMicros = _visualDurationAtStop.inMicroseconds;
      final int currentVisualMicros = (startVisualMicros * (1 - t)).toInt();
      visualElapsed = Duration(microseconds: currentVisualMicros);

    } else if (_startTime != null && !_isPaused) {
      // Normal Running State
      glowOpacity = _glowController.value;
      final now = DateTime.now();
      currentElapsed = now.difference(_startTime!) - _pauseOffset;
      visualElapsed = currentElapsed; // Visual matches Real
    } else if (_isPaused && _pauseStartTime != null) {
      // Paused State
      glowOpacity = 0.0;
      final now = DateTime.now();
      currentElapsed = _pauseStartTime!.difference(_startTime!) - _pauseOffset;
      currentPauseDuration = now.difference(_pauseStartTime!);
      visualElapsed = currentElapsed; // Visual matches Real
    } else {
      // Idle State
      glowOpacity = 0.0;
      currentElapsed = Duration.zero;
      visualElapsed = Duration.zero; // Visual matches Real
    }

    final state = _calculateState(visualElapsed); 
    lapIndex = state.lapIndex;
    lapProgress = state.lapProgress;

    // This ensures break earned numbers also animate down from high values properly
    final Duration grossEarnedBreak = Duration(milliseconds:
      (currentElapsed.inMilliseconds * widget.studyBreakRatio).toInt());

    // 2. Calculate NET Remaining Break for Running State
    // RunningClockFace displays "+XX:XX", so we must subtract used breaks here.
    final Duration netRemainingBreak = grossEarnedBreak - _accumulatedPauseDuration;

    // Clamp to zero to ensure we don't show negative values in the Running state
    final Duration displayBreakForRunning = netRemainingBreak;

    final Color activeColor =
        (lapIndex == 0) ? widget.accentColor : widget.secondaryAccentColor;

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
    final bool isTicking =
        isRunning && !_isPaused && !_resetController.isAnimating;

    // 3. Calculate Total Used for Paused State
    // PausedClockFace does its own subtraction (Earned - Used), so we pass totals.
    final Duration totalBreakUsed =
        _accumulatedPauseDuration + currentPauseDuration;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 320,
        height: 450,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Layer 1: The Main Card
            Positioned(
              top: 0,
              width: 320,
              height: 360,
              child: Stack(
                children: [
                  // Background Glow
                  AnimatedOpacity(
                    opacity: isTicking ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
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
                  // Card Content
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardBackground,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              //splashColor: g_Dakanji_green,
                              highlightColor: g_Dakanji_green.withValues(alpha: 0.1),
                              customBorder: const CircleBorder(),
                              onTap: _resetController.isAnimating
                                  ? null
                                  : (isRunning
                                      ? (_isPaused ? _resumeTimer : _pauseTimer)
                                      : _startTimer),
                              //behavior: HitTestBehavior.opaque,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Center Glow Circle
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
                                            color: activeColor
                                                .withValues(alpha: 0.15),
                                            blurRadius: 40,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Clock Face Switcher
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: _isPaused
                                        ? PausedClockFace(
                                            key: const ValueKey("paused"),
                                            currentElapsed: currentElapsed,
                                            // Paused Face needs Gross & Total Used for internal math
                                            activePauseDuration: totalBreakUsed,
                                            earnedBreak: grossEarnedBreak,
                                            accentColor: widget.accentColor,
                                            negativeBreakColor:
                                                widget.negativeBreakColor,
                                            dashAnimationController:
                                                _dashAnimationController,
                                          )
                                        : RunningClockFace(
                                            key: const ValueKey("running"),
                                            lapIndex: lapIndex,
                                            lapProgress: lapProgress,
                                            activeColor: activeColor,
                                            trackColor: trackColor,
                                            glowOpacity: glowOpacity,
                                            currentElapsed: currentElapsed,
                                            showBreak: showBreak,
                                            // Running Face needs pre-calculated Net Remaining Break
                                            earnedBreak: displayBreakForRunning,
                                            isTicking: isTicking,
                                            isResetting:
                                                _resetController.isAnimating,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Bottom Controls
                        SizedBox(
                          height: 60,
                          child: TimerControlBar(
                            isRunning: isRunning,
                            isPaused: _isPaused,
                            accentColor: widget.accentColor,
                            secondaryAccentColor: widget.secondaryAccentColor,
                            onStart: _startTimer,
                            onPause: _pauseTimer,
                            onResume: _resumeTimer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Layer 2: End Session Button
            Positioned(
              bottom: 10,
              child: AnimatedOpacity(
                opacity: isRunning ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: IgnorePointer(
                  ignoring: !isRunning,
                  child: TextButton(
                    onPressed: _stopTimer,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2C2C2C),
                      foregroundColor: Colors.white.withValues(alpha: 0.7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      LocaleKeys.TimeTrackingScreen_end_session.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}