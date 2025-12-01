import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'calendar_day_cell.dart';
import 'streak_footer.dart';

class StudyCalendar extends StatefulWidget {
  final Map<String, (int, int)?>? vocabStudied;
  final Map<String, (int, int)?>? charactersStudied;
  final Map<String, (int, int)?>? timeStudied;

  final Color vocabColor;
  final Color charactersColor;
  final Color timeColor;
  final Color streakColor; 
  final Color streakGlowColor; 

  const StudyCalendar({
    super.key,
    this.vocabStudied,
    this.charactersStudied,
    this.timeStudied,
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
    final int daysToSaturday = 6 - (now.weekday % 7);
    _gridAnchorDate = now.add(Duration(days: daysToSaturday));

    _calculateTotalPages();

    _pageController = PageController(initialPage: 0);

    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), 
    );
    _fillController.forward();

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

  void _calculateTotalPages() {
    DateTime? earliest;
    
    void checkMap(Map<String, dynamic>? map) {
      if (map == null || map.isEmpty) return;
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
      _totalPages = (diff / 35).ceil();
      if (_totalPages < 1) _totalPages = 1;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime _calculateStreakStartDate() {
    DateTime checkDate = DateTime.now();
    if (!_isStreakCompliant(checkDate)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
      if (!_isStreakCompliant(checkDate)) {
        return DateTime.now().add(const Duration(days: 1)); 
      }
    }
    while (_isStreakCompliant(checkDate.subtract(const Duration(days: 1)))) {
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return DateTime(checkDate.year, checkDate.month, checkDate.day);
  }

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

  bool _isStreakCompliant(DateTime date) {
    final key = _formatter.format(date);

    bool? checkCategory(Map<String, (int, int)?>? map) {
      if (map == null) return null;
      final data = map[key];
      if (data == null) return null;
      if (data.$2 == 0) return null;
      return (data.$1 / data.$2) >= 0.5;
    }

    final v = checkCategory(widget.vocabStudied);
    final c = checkCategory(widget.charactersStudied);
    final t = checkCategory(widget.timeStudied);

    final results = [v, c, t].whereType<bool>().toList();
    if (results.isEmpty) return false;
    return results.every((result) => result == true);
  }

  bool _isDayVisualActive(DateTime date) {
    final key = _formatter.format(date);
    bool hasActivity(Map<String, (int, int)?>? map) {
      if (map == null) return false;
      final data = map[key];
      return data != null && data.$1 > 0;
    }
    return hasActivity(widget.vocabStudied) || 
           hasActivity(widget.charactersStudied) || 
           hasActivity(widget.timeStudied);
  }

  List<DateTime> _generateCalendarDaysForPage(int pageIndex) {
    final DateTime pageEndDate = _gridAnchorDate.subtract(Duration(days: pageIndex * 35));
    List<DateTime> days = [];
    for (int i = 34; i >= 0; i--) {
      days.add(pageEndDate.subtract(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

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
                              // Day Headers
                              if (index < 7) {
                                final dayLabels = ['日', '月', '火', '水', '木', '金', '土'];
                                return Center(
                                  child: Text(
                                    dayLabels[index],
                                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                );
                              }
                              
                              // Calendar Cells
                              final int dayIndex = index - 7;
                              if (dayIndex >= calendarDays.length) return const SizedBox();
                              
                              final DateTime date = calendarDays[dayIndex];
                              if (date.isAfter(now)) return Container(); 

                              final String dateKey = _formatter.format(date);
                              final bool isToday = _isSameDay(date, now);
                              final bool isActive = _isDayVisualActive(date); 
                              final bool isCompliant = _isStreakCompliant(date); 
                              
                              final bool isPartOfCurrentStreak = isCompliant && 
                                  date.isAfter(_streakStartDate.subtract(const Duration(days: 1)));

                              final bool isSunday = date.weekday == DateTime.sunday;
                              final bool isSaturday = date.weekday == DateTime.saturday;
                              
                              // Connectivity Logic
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

                                  final vocabData = widget.vocabStudied?[dateKey];
                                  final charData = widget.charactersStudied?[dateKey];
                                  final timeData = widget.timeStudied?[dateKey];

                                  return CalendarDayCell(
                                    date: date,
                                    isToday: isToday,
                                    isActive: isActive,
                                    isCompliant: isCompliant,
                                    isPartOfCurrentStreak: isPartOfCurrentStreak,
                                    margin: margin,
                                    borderRadius: borderRadius,
                                    baseStreakFillColor: _baseStreakFillColor,
                                    streakGlowColor: widget.streakGlowColor,
                                    circleSize: _circleSize,
                                    vocabData: vocabData,
                                    charData: charData,
                                    timeData: timeData,
                                    vocabColor: widget.vocabColor,
                                    charactersColor: widget.charactersColor,
                                    timeColor: widget.timeColor,
                                    fillController: _fillController,
                                    glowAnimation: _glowAnimation,
                                    index: index,
                                    totalCells: totalCells,
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
                
                // --- FOOTER SECTION ---
                StreakFooter(
                  streak: _currentStreak,
                  now: now,
                  pageController: _pageController,
                  glowController: _glowController,
                  glowAnimation: _glowAnimation,
                  streakColor: widget.streakColor,
                  timeColor: widget.timeColor,
                  charactersColor: widget.charactersColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}