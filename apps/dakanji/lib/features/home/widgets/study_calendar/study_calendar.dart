import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

import 'calendar_day_cell.dart';
import 'streak_footer.dart';

/// Data model representing a single day's study progress
class DailyStudyStats {
  final (int, int)? vocab; // (current, goal)
  final (int, int)? chars;
  final (int, int)? time;

  const DailyStudyStats({this.vocab, this.chars, this.time});

  bool get isCompliant {
    // 1. Identify valid metrics (Not null AND Goal > 0)
    final validVocab = (vocab?.$2 ?? 0) > 0 ? vocab : null;
    final validChars = (chars?.$2 ?? 0) > 0 ? chars : null;
    final validTime = (time?.$2 ?? 0) > 0 ? time : null;

    // 2. If NO metrics are active/valid, the day cannot be a "streak success".
    if (validVocab == null && validChars == null && validTime == null) {
      return false;
    }

    // 3. Helper to check if a specific valid metric passed
    bool passed((int, int) tuple) {
      return (tuple.$1 / tuple.$2) >= 0.5;
    }

    // 4. All VALID metrics must pass.
    if (validVocab != null && !passed(validVocab)) return false;
    if (validChars != null && !passed(validChars)) return false;
    if (validTime != null && !passed(validTime)) return false;

    return true;
  }

  bool get hasActivity {
    // Check for any raw progress > 0
    return (vocab?.$1 ?? 0) > 0 || (chars?.$1 ?? 0) > 0 || (time?.$1 ?? 0) > 0;
  }
}

typedef FetchCategoryDataCallback = Future<Map<DateTime, (int, int)>> Function(
    DateTime start, DateTime end);

class StudyCalendar extends StatefulWidget {
  final FetchCategoryDataCallback? onFetchVocab;
  final FetchCategoryDataCallback? onFetchCharacters;
  final FetchCategoryDataCallback? onFetchTime;
  
  // NEW: Optional callback to fetch an externally calculated streak
  // (e.g. from TimeTrackingDao) instead of calculating it from page data.
  final Future<int> Function()? onComputeStreak;

  final Color vocabColor;
  final Color charactersColor;
  final Color timeColor;
  final Color streakColor;
  final Color streakGlowColor;

  const StudyCalendar({
    super.key,
    this.onFetchVocab,
    this.onFetchCharacters,
    this.onFetchTime,
    this.onComputeStreak,
    this.vocabColor = g_color_scheme_green,
    this.charactersColor = g_color_scheme_red,
    this.timeColor = g_color_scheme_blue,
    this.streakColor = g_color_scheme_green,
    this.streakGlowColor = g_color_scheme_red,
  });

  @override
  State<StudyCalendar> createState() => _StudyCalendarState();
}

class _StudyCalendarState extends State<StudyCalendar>
    with TickerProviderStateMixin {
  late final Color _baseStreakFillColor;
  final double _circleSize = 38.0;
  final double _calendarHeight = 280;

  late final AnimationController _fillController;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;
  late final PageController _pageController;

  late DateTime _gridAnchorDate;

  // Cache stores merged data for pages
  final Map<int, Map<DateTime, DailyStudyStats>> _pageCache = {};
  
  // Store the externally fetched streak
  int _externalStreak = 0;

  @override
  void initState() {
    super.initState();
    _baseStreakFillColor = widget.streakColor.withValues(alpha: 0.15);

    // Align grid to the coming Saturday (End of week)
    final now = DateTime.now();
    final int daysToSaturday = 6 - (now.weekday % 7);
    _gridAnchorDate = DateTime(now.year, now.month, now.day)
        .add(Duration(days: daysToSaturday));

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
    
    _fetchExternalStreak();
  }
  
  @override
  void didUpdateWidget(StudyCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onComputeStreak != oldWidget.onComputeStreak) {
      _fetchExternalStreak();
    }
  }
  
  Future<void> _fetchExternalStreak() async {
    if (widget.onComputeStreak != null) {
      final val = await widget.onComputeStreak!();
      if (mounted) {
        setState(() {
          _externalStreak = val;
        });
      }
    }
  }

  @override
  void dispose() {
    _fillController.dispose();
    _glowController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<Map<DateTime, DailyStudyStats>> _loadPageData(int pageIndex) async {
    if (_pageCache.containsKey(pageIndex)) {
      return _pageCache[pageIndex]!;
    }

    final endDate = _gridAnchorDate.subtract(Duration(days: pageIndex * 35));
    final startDate = endDate.subtract(const Duration(days: 34));

    // 1. Fetch enabled categories
    final results = await Future.wait([
      widget.onFetchVocab != null
          ? widget.onFetchVocab!(startDate, endDate)
          : Future.value(<DateTime, (int, int)>{}),
      widget.onFetchCharacters != null
          ? widget.onFetchCharacters!(startDate, endDate)
          : Future.value(<DateTime, (int, int)>{}),
      widget.onFetchTime != null
          ? widget.onFetchTime!(startDate, endDate)
          : Future.value(<DateTime, (int, int)>{}),
    ]);

    final vocabMap = results[0];
    final charMap = results[1];
    final timeMap = results[2];

    // 2. Merge into Stats Objects
    final Map<DateTime, DailyStudyStats> merged = {};

    for (int i = 0; i <= 35; i++) {
      final date = startDate.add(Duration(days: i));

      // Must use UTC to match the keys returned by the DAO
      final key = DateTime.utc(date.year, date.month, date.day);

      merged[key] = DailyStudyStats(
        vocab: vocabMap[key],
        chars: charMap[key],
        time: timeMap[key],
      );
    }

    _pageCache[pageIndex] = merged;
    return merged;
  }

  DailyStudyStats? _getStatsForDate(DateTime date) {
    final diff = _gridAnchorDate.difference(date).inDays;
    if (diff < 0) return null; // Future date

    final pageIndex = (diff / 35).floor();

    if (!_pageCache.containsKey(pageIndex)) return null;

    final key = DateTime.utc(date.year, date.month, date.day);
    return _pageCache[pageIndex]?[key];
  }

  int get _currentStreak {
    // PREFER external calculation (DAO) if provided
    if (widget.onComputeStreak != null) {
      return _externalStreak;
    }
    
    // Fallback: Calculate from currently loaded page data (susceptible to "hidden wall" bug)
    int streak = 0;
    DateTime checkDate = DateTime.now();

    // Check Today
    final todayStats = _getStatsForDate(checkDate);

    // If today is NOT compliant (e.g. not started yet), check if streak ended yesterday
    if (todayStats == null || !todayStats.isCompliant) {
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    // Count backwards
    while (true) {
      final stats = _getStatsForDate(checkDate);
      if (stats == null || !stats.isCompliant) {
        break;
      }
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          //color: const Color(0xFF1E2329),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _calendarHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    reverse: true,
                    itemBuilder: (context, pageIndex) {
                      return FutureBuilder<Map<DateTime, DailyStudyStats>>(
                        future: _loadPageData(pageIndex),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const _LoadingGrid();
                          }

                          final pageData = snapshot.data!;
                          final calendarDays =
                              _generateCalendarDaysForPage(pageIndex);
                          final currentStreak = _currentStreak;

                          return _CalendarPage(
                            calendarDays: calendarDays,
                            pageData: pageData,
                            now: now,
                            currentStreak: currentStreak,
                            circleSize: _circleSize,
                            baseStreakFillColor: _baseStreakFillColor,
                            streakGlowColor: widget.streakGlowColor,
                            vocabColor: widget.vocabColor,
                            charactersColor: widget.charactersColor,
                            timeColor: widget.timeColor,
                            fillController: _fillController,
                            glowAnimation: _glowAnimation,
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
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

  List<DateTime> _generateCalendarDaysForPage(int pageIndex) {
    final DateTime pageEndDate =
        _gridAnchorDate.subtract(Duration(days: pageIndex * 35));
    List<DateTime> days = [];
    for (int i = 34; i >= 0; i--) {
      days.add(pageEndDate.subtract(Duration(days: i)));
    }
    return days;
  }
}

class _CalendarPage extends StatelessWidget {
  final List<DateTime> calendarDays;
  final Map<DateTime, DailyStudyStats> pageData;
  final DateTime now;
  final int currentStreak;
  final double circleSize;
  final Color baseStreakFillColor;
  final Color streakGlowColor;
  final Color vocabColor;
  final Color charactersColor;
  final Color timeColor;
  final AnimationController fillController;
  final Animation<double> glowAnimation;

  const _CalendarPage({
    required this.calendarDays,
    required this.pageData,
    required this.now,
    required this.currentStreak,
    required this.circleSize,
    required this.baseStreakFillColor,
    required this.streakGlowColor,
    required this.vocabColor,
    required this.charactersColor,
    required this.timeColor,
    required this.fillController,
    required this.glowAnimation,
  });

  @override
  Widget build(BuildContext context) {
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
              return _DayHeader(index: index);
            }

            // Calendar Cells
            final int dayIndex = index - 7;
            if (dayIndex >= calendarDays.length) return const SizedBox();

            final DateTime date = calendarDays[dayIndex];
            if (date.isAfter(now)) return const SizedBox();

            final dateKey = DateTime.utc(date.year, date.month, date.day);
            final stats = pageData[dateKey];

            final bool isToday = _isSameDay(date, now);
            final bool isActive = stats?.hasActivity ?? false;
            final bool isCompliant = stats?.isCompliant ?? false;

            final bool isPartOfCurrentStreak = isCompliant &&
                (currentStreak > 0) &&
                date.isAfter(now.subtract(Duration(days: currentStreak + 1)));

            // Determine Streak Connectivity
            final (bool connectLeft, bool connectRight) =
                _determineConnectivity(dayIndex, isCompliant, date);

            // Filter data: Pass NULL if goal is 0 to hide ring
            final vocabTuple = (stats?.vocab?.$2 ?? 0) > 0 ? stats?.vocab : null;
            final charsTuple = (stats?.chars?.$2 ?? 0) > 0 ? stats?.chars : null;
            final timeTuple = (stats?.time?.$2 ?? 0) > 0 ? stats?.time : null;

            return LayoutBuilder(
              builder: (context, cellConstraints) {
                final double cellWidth = cellConstraints.maxWidth;
                final double centerMargin = (cellWidth - circleSize) / 2;

                final (EdgeInsets margin, BorderRadiusGeometry borderRadius) =
                    _calculateCellLayout(
                  connectLeft: connectLeft,
                  connectRight: connectRight,
                  centerMargin: centerMargin,
                  isCompliant: isCompliant,
                );

                return CalendarDayCell(
                  date: date,
                  isToday: isToday,
                  isActive: isActive,
                  isCompliant: isCompliant,
                  isPartOfCurrentStreak: isPartOfCurrentStreak,
                  margin: margin,
                  borderRadius: borderRadius,
                  baseStreakFillColor: baseStreakFillColor,
                  streakGlowColor: streakGlowColor,
                  circleSize: circleSize,
                  vocabData: vocabTuple,
                  charData: charsTuple,
                  timeData: timeTuple,
                  vocabColor: vocabColor,
                  charactersColor: charactersColor,
                  timeColor: timeColor,
                  fillController: fillController,
                  glowAnimation: glowAnimation,
                  index: index,
                  totalCells: totalCells,
                );
              },
            );
          },
        );
      },
    );
  }

  (bool, bool) _determineConnectivity(
    int dayIndex,
    bool isCurrentCompliant,
    DateTime date,
  ) {
    if (!isCurrentCompliant) return (false, false);

    bool connectLeft = false;
    bool connectRight = false;

    final bool isSunday = date.weekday == DateTime.sunday;
    final bool isSaturday = date.weekday == DateTime.saturday;

    // Check Left (Previous Day)
    if (!isSunday && dayIndex > 0) {
      final prevDate = calendarDays[dayIndex - 1];
      final prevKey = DateTime.utc(prevDate.year, prevDate.month, prevDate.day);
      if (pageData[prevKey]?.isCompliant == true) {
        connectLeft = true;
      }
    }

    // Check Right (Next Day)
    if (!isSaturday && dayIndex < calendarDays.length - 1) {
      final nextDate = calendarDays[dayIndex + 1];
      if (!nextDate.isAfter(now)) {
        final nextKey =
            DateTime.utc(nextDate.year, nextDate.month, nextDate.day);
        if (pageData[nextKey]?.isCompliant == true) {
          connectRight = true;
        }
      }
    }

    return (connectLeft, connectRight);
  }

  (EdgeInsets, BorderRadiusGeometry) _calculateCellLayout({
    required bool connectLeft,
    required bool connectRight,
    required double centerMargin,
    required bool isCompliant,
  }) {
    if (!isCompliant) {
      return (
        EdgeInsets.symmetric(horizontal: centerMargin),
        BorderRadius.circular(50)
      );
    }

    if (connectLeft && connectRight) {
      return (EdgeInsets.zero, BorderRadius.zero);
    } else if (connectRight) {
      return (
        EdgeInsets.only(left: centerMargin),
        const BorderRadius.horizontal(left: Radius.circular(50))
      );
    } else if (connectLeft) {
      return (
        EdgeInsets.only(right: centerMargin),
        const BorderRadius.horizontal(right: Radius.circular(50))
      );
    } else {
      return (
        EdgeInsets.symmetric(horizontal: centerMargin),
        BorderRadius.circular(50)
      );
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: 7 + 35,
      itemBuilder: (context, index) {
        if (index < 7) return _DayHeader(index: index);
        return Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
          ),
        );
      },
    );
  }
}

class _DayHeader extends StatelessWidget {
  final int index;
  const _DayHeader({required this.index});

  @override
  Widget build(BuildContext context) {
    const dayLabels = ['日', '月', '火', '水', '木', '金', '土'];
    return Center(
      child: Text(
        dayLabels[index],
        style: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}