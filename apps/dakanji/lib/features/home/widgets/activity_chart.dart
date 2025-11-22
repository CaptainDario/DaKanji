import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'breathing_neon_wrapper.dart';

/// A dashboard widget that visualizes study activity over a monthly grid.
///
/// Features:
/// * Displays activity for Vocabulary, Characters, and Time.
/// * Calculates and visualizes the current study streak.
/// * Animates progress rings and visual rewards based on streak length.
///
/// **Visual Progression System:**
/// The streak container at the bottom right evolves based on the [streak] count:
/// * **0 Days:** All elements are Grey.
/// * **1-5 Days:** Text color fades from Grey to White.
/// * **5-10 Days:** Text font weight transitions from Normal to Bold.
/// * **10-20 Days:** Flame icon fades in (Opacity 0.0 -> 1.0). **Note:** Before 10 days, the icon is removed from the widget tree to prevent whitespace.
/// * **20-30 Days:** Container border/fill fades from Grey to Green ([streakColor]).
/// * **30-45 Days:** Container border/fill fades from Green to Blue ([timeColor]).
/// * **45-60 Days:** Container border/fill fades from Blue to Red ([charactersColor]).
/// * **60-90 Days:** Icon color fades from White to Red ([charactersColor]).
/// * **90-180 Days:** Icon emits a "breathing" glow (Red/Yellow mix). Opacity increases 0.0 -> 1.0.
/// * **360+ Days:** The static icon is replaced by a Lottie flame animation.
class StudyCalendar extends StatefulWidget {
  final Map<String, (int, int)> vocabStudied;
  final Map<String, (int, int)> charactersStudied;
  final Map<String, (int, int)> timeStudied;

  final Color vocabColor;
  final Color charactersColor;
  final Color timeColor;
  final Color streakColor; 
  final Color streakGlowColor; 

  const StudyCalendar({
    super.key,
    required this.vocabStudied,
    required this.charactersStudied,
    required this.timeStudied,
    this.vocabColor = g_Dakanji_green,
    this.charactersColor = g_Dakanji_red,
    this.timeColor = g_Dakanji_blue,
    this.streakColor = g_Dakanji_green,
    this.streakGlowColor = g_Dakanji_red, 
  });

  @override
  State<StudyCalendar> createState() => _StudyCalendarState();
}

class _StudyCalendarState extends State<StudyCalendar> with TickerProviderStateMixin {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  late final Color _baseStreakFillColor;
  final double _circleSize = 38.0; 
  final double _calendarHeight = 280;

  late final AnimationController _fillController;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;
  late final PageController _pageController;

  late DateTime _streakStartDate;
  
  late int _totalPages;
  late DateTime _gridAnchorDate;

  @override
  void initState() {
    super.initState();
    _baseStreakFillColor = widget.streakColor.withValues(alpha: 0.15);
    _streakStartDate = _calculateStreakStartDate();

    final now = DateTime.now();
    // Aligns grid to end on Saturday for a standard calendar view
    final int daysToSaturday = 6 - (now.weekday % 7);
    _gridAnchorDate = now.add(Duration(days: daysToSaturday));

    _calculateTotalPages();

    _pageController = PageController(initialPage: 0);

    // Controls the initial fill animation of the progress rings
    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), 
    );
    _fillController.forward();

    // Controls the breathing glow effect for streaks
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(StudyCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Recalculates streak and pages if data inputs change
    if (widget.vocabStudied != oldWidget.vocabStudied || 
        widget.charactersStudied != oldWidget.charactersStudied ||
        widget.timeStudied != oldWidget.timeStudied) {
      setState(() {
        _streakStartDate = _calculateStreakStartDate();
        _calculateTotalPages();
      });
    }
  }

  @override
  void dispose() {
    _fillController.dispose();
    _glowController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // --- LOGIC HELPERS ---

  /// Determines the total number of pages needed based on the earliest recorded study date.
  void _calculateTotalPages() {
    DateTime? earliest;
    
    void checkMap(Map<String, dynamic> map) {
      if (map.isEmpty) return;
      final sortedKeys = map.keys.toList()..sort();
      final firstDate = _formatter.parse(sortedKeys.first);
      if (earliest == null || firstDate.isBefore(earliest!)) {
        earliest = firstDate;
      }
    }

    checkMap(widget.vocabStudied);
    checkMap(widget.charactersStudied);
    checkMap(widget.timeStudied);

    if (earliest == null) {
      _totalPages = 1; 
    } else {
      final diff = _gridAnchorDate.difference(earliest!).inDays;
      _totalPages = (diff / 35).ceil(); // 35 days per page (5 weeks)
      if (_totalPages < 1) _totalPages = 1;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Traverses backward from today to find the start date of the current unbroken streak.
  DateTime _calculateStreakStartDate() {
    DateTime checkDate = DateTime.now();
    // Checks if today is broken; if so, checks yesterday to allow a 1-day grace/break logic 
    // depending on exact streak rules (here assuming simple continuity).
    if (!_isStreakCompliant(checkDate)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
      if (!_isStreakCompliant(checkDate)) {
        return DateTime.now().add(const Duration(days: 1)); // No active streak
      }
    }
    while (_isStreakCompliant(checkDate.subtract(const Duration(days: 1)))) {
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return DateTime(checkDate.year, checkDate.month, checkDate.day);
  }

  /// Calculates the numeric length of the current streak.
  int get _currentStreak {
    int streak = 0;
    DateTime checkDate = DateTime.now();
    if (!_isStreakCompliant(checkDate)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    while (_isStreakCompliant(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Validates if a specific date meets the criteria to maintain a streak.
  /// Current Rule: >50% completion in Vocab, Characters, AND Time.
  bool _isStreakCompliant(DateTime date) {
    final key = _formatter.format(date);
    final v = widget.vocabStudied[key];
    final c = widget.charactersStudied[key];
    final t = widget.timeStudied[key];

    double getPct((int, int)? data) {
      if (data == null || data.$2 == 0) return 0.0;
      return data.$1 / data.$2;
    }
    return getPct(v) >= 0.5 && getPct(c) >= 0.5 && getPct(t) >= 0.5;
  }

  /// Checks if any study activity occurred on this date (used for showing rings).
  bool _isDayVisualActive(DateTime date) {
    final key = _formatter.format(date);
    final v = widget.vocabStudied[key];
    final c = widget.charactersStudied[key];
    final t = widget.timeStudied[key];
    return (v != null && v.$1 > 0) || (c != null && c.$1 > 0) || (t != null && t.$1 > 0);
  }

  /// Generates the list of 35 days (5 weeks) for a specific grid page.
  List<DateTime> _generateCalendarDaysForPage(int pageIndex) {
    final DateTime pageEndDate = _gridAnchorDate.subtract(Duration(days: pageIndex * 35));
    List<DateTime> days = [];
    for (int i = 34; i >= 0; i--) {
      days.add(pageEndDate.subtract(Duration(days: i)));
    }
    return days;
  }

  // --- UI HELPERS ---

  void _showDetailsSnackBar(BuildContext context, DateTime date, (int, int)? vocab, (int, int)? chars, (int, int)? time) {
    final dateStr = DateFormat('yyyy年MM月dd日 (E)', 'ja_JP').format(date);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2C333C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dateStr, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            if (time == null && vocab == null && chars == null)
              const Text("No study data.", style: TextStyle(color: Colors.grey)),
            if (time != null && time.$1 > 0) 
              _buildStatRow("Time", time, widget.timeColor),
            if (chars != null && chars.$1 > 0) 
              _buildStatRow("Chars", chars, widget.charactersColor),
            if (vocab != null && vocab.$1 > 0) 
              _buildStatRow("Vocab", vocab, widget.vocabColor),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, (int, int) data, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text("$label: ", style: TextStyle(color: Colors.grey[300], fontSize: 13)),
          Text("${data.$1} / ${data.$2}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildDateText(DateTime date, bool isToday, bool isActive, bool isCompliant) {
    final Color textColor = isToday 
        ? Colors.lightBlueAccent 
        : (isActive ? Colors.white : Colors.grey[400]!);
    
    final FontWeight weight = isCompliant ? FontWeight.bold : FontWeight.normal;

    // Renders the first day of the month with the Kanji "月" and superscript month number
    if (date.day == 1) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            "月",
            style: TextStyle(
              color: textColor,
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              height: 1.0, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Text(
              date.month.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: 8, 
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
        ],
      );
    }

    return Text(
      date.day.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontWeight: weight,
        fontSize: 12, 
        height: 1.0, 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int streak = _currentStreak;
    final now = DateTime.now();
    
    // --- STREAK PROGRESSION LOGIC ---
    
    // Initialize default styles for Streak = 0
    Color textColor = Colors.grey;
    FontWeight textWeight = FontWeight.normal;
    Color containerColor = Colors.grey;
    Color iconColor = Colors.white; 
    double iconOpacity = 0.0; // Hidden by default
    double glowOpacity = 0.0;
    bool showLottie = false;

    // Helper to normalize a value between a start and end range to 0.0 - 1.0
    double getT(double start, double end) => ((streak - start) / (end - start)).clamp(0.0, 1.0);

    // Apply progression rules based on streak length
    if (streak >= 1) {
      // 1-5: Fade Text Grey -> White
      textColor = Color.lerp(Colors.grey, Colors.white, getT(1, 5))!;
    }

    if (streak >= 5) {
      // 5-10: Fade Font Weight Normal -> Bold
      textWeight = FontWeight.lerp(FontWeight.normal, FontWeight.bold, getT(5, 10))!;
    }

    if (streak >= 10) {
      // 10-20: Fade Icon In
      iconOpacity = getT(10, 20);
    }

    if (streak >= 20) {
      // 20-30: Fade Container Grey -> StreakColor (Green)
      containerColor = Color.lerp(Colors.grey, widget.streakColor, getT(20, 30))!;
    }

    if (streak >= 30) {
      // 30-45: Fade Container Green -> TimeColor (Blue)
      containerColor = Color.lerp(widget.streakColor, widget.timeColor, getT(30, 45))!;
    }

    if (streak >= 45) {
      // 45-60: Fade Container Blue -> CharColor (Red)
      containerColor = Color.lerp(widget.timeColor, widget.charactersColor, getT(45, 60))!;
    }

    if (streak >= 60) {
      // 60-90: Fade Icon White -> CharColor (Red)
      iconColor = Color.lerp(Colors.white, widget.charactersColor, getT(60, 90))!;
    }

    if (streak >= 90) {
      // 90-180: Increase Glow Opacity
      glowOpacity = getT(90, 180);
    }

    if (streak >= 360) {
      // 360+: Switch to Lottie Animation
      showLottie = true;
    }

    Color finalContainerFill = containerColor.withValues(alpha: 0.15);
    Color finalContainerBorder = containerColor.withValues(alpha: 0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: const Color(0xFF1E2329),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- GRID SECTION ---
                SizedBox(
                  height: _calendarHeight, 
                  child: PageView.builder(
                    controller: _pageController,
                    reverse: true,
                    itemCount: _totalPages, 
                    itemBuilder: (context, pageIndex) {
                      final calendarDays = _generateCalendarDaysForPage(pageIndex);
                      final int totalCells = 7 + calendarDays.length;
                      
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final double itemHeight = constraints.maxHeight / 6;

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisExtent: itemHeight,
                              crossAxisSpacing: 0, 
                              mainAxisSpacing: 0,
                            ),
                            itemCount: totalCells,
                            itemBuilder: (context, index) {
                              // Render Day Headers (Sun-Sat)
                              if (index < 7) {
                                final dayLabels = ['日', '月', '火', '水', '木', '金', '土'];
                                return Center(
                                  child: Text(
                                    dayLabels[index],
                                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                );
                              }
                              
                              // Render Calendar Cells
                              final int dayIndex = index - 7;
                              if (dayIndex >= calendarDays.length) return const SizedBox();
                              
                              final DateTime date = calendarDays[dayIndex];
                              // Hide future dates
                              if (date.isAfter(now)) return Container(); 

                              final String dateKey = _formatter.format(date);
                              final bool isToday = _isSameDay(date, now);
                              final bool isActive = _isDayVisualActive(date); 
                              final bool isCompliant = _isStreakCompliant(date); 
                              
                              // Determine if this cell is part of the current active streak (for glow effect)
                              final bool isPartOfCurrentStreak = isCompliant && 
                                  date.isAfter(_streakStartDate.subtract(const Duration(days: 1)));

                              final bool isSunday = date.weekday == DateTime.sunday;
                              final bool isSaturday = date.weekday == DateTime.saturday;
                              
                              // Calculate pill connectivity
                              bool connectLeft = false;
                              bool connectRight = false;

                              if (isCompliant) {
                                if (!isSunday && dayIndex > 0) {
                                  if (_isStreakCompliant(calendarDays[dayIndex - 1])) connectLeft = true;
                                }
                                if (!isSaturday && dayIndex < calendarDays.length - 1) {
                                  if (dayIndex + 1 < calendarDays.length) {
                                    DateTime next = calendarDays[dayIndex + 1];
                                    if (!next.isAfter(now) && _isStreakCompliant(next)) connectRight = true;
                                  }
                                }
                              }

                              return LayoutBuilder(
                                builder: (context, cellConstraints) {
                                  final double cellWidth = cellConstraints.maxWidth;
                                  final double centerMargin = (cellWidth - _circleSize) / 2;

                                  EdgeInsets margin;
                                  BorderRadiusGeometry borderRadius;

                                  // Determine shape based on connectivity
                                  if (isCompliant) {
                                    if (connectLeft && connectRight) {
                                      margin = EdgeInsets.zero;
                                      borderRadius = BorderRadius.zero;
                                    } else if (connectRight) {
                                      margin = EdgeInsets.only(left: centerMargin);
                                      borderRadius = const BorderRadius.horizontal(left: Radius.circular(50));
                                    } else if (connectLeft) {
                                      margin = EdgeInsets.only(right: centerMargin);
                                      borderRadius = const BorderRadius.horizontal(right: Radius.circular(50));
                                    } else {
                                      margin = EdgeInsets.symmetric(horizontal: centerMargin);
                                      borderRadius = BorderRadius.circular(50);
                                    }
                                  } else {
                                    margin = EdgeInsets.symmetric(horizontal: centerMargin);
                                    borderRadius = BorderRadius.circular(50);
                                  }

                                  final vocabData = widget.vocabStudied[dateKey];
                                  final charData = widget.charactersStudied[dateKey];
                                  final timeData = widget.timeStudied[dateKey];

                                  double getPercent((int, int)? data) {
                                    if (data == null || data.$2 == 0) return 0.0;
                                    return (data.$1 / data.$2).clamp(0.0, 1.0);
                                  }

                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // 1. Background Pill/Circle
                                      if (isCompliant)
                                        AnimatedBuilder(
                                          animation: _glowAnimation,
                                          builder: (context, child) {
                                            List<BoxShadow>? shadows;
                                            if (isPartOfCurrentStreak) {
                                              final double opacity = _glowAnimation.value * 0.5;
                                              shadows = [
                                                BoxShadow(
                                                  color: widget.streakGlowColor.withValues(alpha: opacity),
                                                  blurRadius: 8,
                                                  spreadRadius: 1,
                                                )
                                              ];
                                            }
                                            return Container(
                                              height: _circleSize,
                                              margin: margin,
                                              decoration: BoxDecoration(
                                                color: _baseStreakFillColor,
                                                borderRadius: borderRadius,
                                                boxShadow: shadows,
                                              ),
                                            );
                                          },
                                        ),
                                      
                                      // 2. Touch Target
                                      Container(
                                        width: _circleSize,
                                        height: _circleSize,
                                        decoration: const BoxDecoration(shape: BoxShape.circle),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            customBorder: const CircleBorder(),
                                            onTap: () => _showDetailsSnackBar(context, date, vocabData, charData, timeData),
                                          ),
                                        ),
                                      ),
                                      
                                      // 3. Activity Rings
                                      if (isActive)
                                        IgnorePointer(
                                          child: AnimatedBuilder(
                                            animation: _fillController,
                                            builder: (context, child) {
                                              final double totalItems = totalCells.toDouble();
                                              final double start = (index / totalItems) * 0.5; 
                                              final double end = start + 0.5;
                                              final curve = CurvedAnimation(
                                                parent: _fillController,
                                                curve: Interval(start, end, curve: Curves.easeOut),
                                              );

                                              return Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  if (timeData != null && timeData.$1 > 0)
                                                    BreathingNeonWrapper(
                                                      isActive: isCompliant && isPartOfCurrentStreak,
                                                      glowAnimation: _glowAnimation,
                                                      glowColor: widget.timeColor,
                                                      customGlowChild: SizedBox(
                                                        width: _circleSize,
                                                        height: _circleSize,
                                                        child: CircularProgressIndicator(
                                                          value: getPercent(timeData) * curve.value,
                                                          strokeWidth: 2.0,
                                                          color: widget.timeColor,
                                                          backgroundColor: Colors.transparent,
                                                          strokeCap: StrokeCap.round,
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        width: _circleSize,
                                                        height: _circleSize,
                                                        child: CircularProgressIndicator(
                                                          value: getPercent(timeData) * curve.value,
                                                          color: widget.timeColor,
                                                          strokeWidth: 2.0,
                                                          backgroundColor: Colors.transparent,
                                                          strokeCap: StrokeCap.round,
                                                        ),
                                                      ),
                                                    ),
                                                  if (charData != null && charData.$1 > 0)
                                                    SizedBox(
                                                      width: _circleSize * 0.75, 
                                                      height: _circleSize * 0.75,
                                                      child: CircularProgressIndicator(
                                                        value: getPercent(charData) * curve.value,
                                                        color: widget.charactersColor,
                                                        strokeWidth: 2.0,
                                                        backgroundColor: Colors.transparent,
                                                        strokeCap: StrokeCap.round,
                                                      ),
                                                    ),
                                                  if (vocabData != null && vocabData.$1 > 0)
                                                    SizedBox(
                                                      width: _circleSize * 0.5,
                                                      height: _circleSize * 0.5,
                                                      child: CircularProgressIndicator(
                                                        value: getPercent(vocabData) * curve.value,
                                                        color: widget.vocabColor,
                                                        strokeWidth: 2.0,
                                                        backgroundColor: Colors.transparent,
                                                        strokeCap: StrokeCap.round,
                                                      ),
                                                    ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      
                                      // 4. Date Text
                                      IgnorePointer(
                                        child: SizedBox(
                                          width: _circleSize * 0.45, 
                                          height: _circleSize * 0.45,
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: _buildDateText(date, isToday, isActive, isCompliant),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                
                // --- FOOTER SECTION (Current Date & Streak Reward) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Jump to Today
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(0, 
                            duration: const Duration(milliseconds: 500), 
                            curve: Curves.easeOutExpo
                          );
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Text(
                            DateFormat('yyyy年MM月dd日 (E)', 'ja_JP').format(now),
                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    
                    // Streak Reward Container
                    AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, child) {
                        // Dynamically create the fire glow color (Orange/Red Mix)
                        Color activeGlowColor = Colors.transparent;
                        if (glowOpacity > 0) {
                           activeGlowColor = Color.lerp(Colors.orangeAccent, Colors.redAccent, 0.5)!;
                           activeGlowColor = activeGlowColor.withValues(alpha: glowOpacity);
                        }

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: finalContainerFill,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: finalContainerBorder),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Critical: Shrinks row to fit content exactly
                            children: [
                              // ICON LOGIC:
                              // strictly excluded from widget tree if streak < 10 to avoid whitespace
                              if (streak > 10) ...[
                                if (showLottie)
                                  // 360+ Days: Animated Lottie Flame with Breathe Effect
                                  BreathingNeonWrapper(
                                    isActive: true, 
                                    glowAnimation: _glowAnimation,
                                    glowColor: activeGlowColor,
                                    customGlowChild: ColorFiltered(
                                      colorFilter: ColorFilter.mode(activeGlowColor, BlendMode.srcIn),
                                      child: Lottie.asset(
                                        'assets/animations/fire.json',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                                      child: Lottie.asset(
                                        'assets/animations/fire.json',
                                        width: 20, 
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                else
                                  // 10-360 Days: Standard Icon with Opacity/Glow
                                  Opacity(
                                    opacity: iconOpacity,
                                    child: BreathingNeonWrapper(
                                      isActive: glowOpacity > 0,
                                      glowAnimation: _glowAnimation,
                                      glowColor: activeGlowColor,
                                      customGlowChild: Icon(
                                        Icons.local_fire_department,
                                        color: activeGlowColor,
                                        size: 16
                                      ),
                                      child: Icon(
                                        Icons.local_fire_department, 
                                        color: iconColor, 
                                        size: 16
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 4), // Spacing is only added if icon exists
                              ],
                              Text(
                                "$streak Day Streak",
                                style: TextStyle(
                                  color: textColor, 
                                  fontWeight: textWeight, 
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}