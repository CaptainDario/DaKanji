import 'package:flutter/material.dart';
import 'breathing_neon_wrapper.dart';
import '../study_details_editor/study_detail_modal.dart'; 

class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isActive;
  final bool isCompliant;
  final bool isPartOfCurrentStreak;
  final EdgeInsets margin;
  final BorderRadiusGeometry borderRadius;
  final Color baseStreakFillColor;
  final Color streakGlowColor;
  final double circleSize;
  
  // Data
  final (int, int)? vocabData;
  final (int, int)? charData;
  final (int, int)? timeData;

  // Colors
  final Color vocabColor;
  final Color charactersColor;
  final Color timeColor;

  // Animations
  final AnimationController fillController;
  final Animation<double> glowAnimation;
  final int index; 
  final int totalCells;

  const CalendarDayCell({
    super.key,
    required this.date,
    required this.isToday,
    required this.isActive,
    required this.isCompliant,
    required this.isPartOfCurrentStreak,
    required this.margin,
    required this.borderRadius,
    required this.baseStreakFillColor,
    required this.streakGlowColor,
    required this.circleSize,
    required this.vocabData,
    required this.charData,
    required this.timeData,
    required this.vocabColor,
    required this.charactersColor,
    required this.timeColor,
    required this.fillController,
    required this.glowAnimation,
    required this.index,
    required this.totalCells,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isCompliant)
          _BackgroundPill(
            glowAnimation: glowAnimation,
            isPartOfCurrentStreak: isPartOfCurrentStreak,
            streakGlowColor: streakGlowColor,
            circleSize: circleSize,
            margin: margin,
            baseStreakFillColor: baseStreakFillColor,
            borderRadius: borderRadius,
          ),
        
        // Touch Target
        Container(
          width: circleSize,
          height: circleSize,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => StudyDetailModal(
                      date: date,
                      vocabData: vocabData,
                      charData: charData,
                      timeData: timeData,
                      vocabColor: vocabColor,
                      charactersColor: charactersColor,
                      timeColor: timeColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        if (isActive)
          IgnorePointer(
            child: _ActivityRings(
              fillController: fillController,
              totalCells: totalCells,
              index: index,
              isCompliant: isCompliant,
              isPartOfCurrentStreak: isPartOfCurrentStreak,
              glowAnimation: glowAnimation,
              timeColor: timeColor,
              vocabColor: vocabColor,
              charactersColor: charactersColor,
              circleSize: circleSize,
              timeData: timeData,
              vocabData: vocabData,
              charData: charData,
            ),
          ),
        
        IgnorePointer(
          child: SizedBox(
            width: circleSize * 0.45, 
            height: circleSize * 0.45,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _DateLabel(
                  date: date,
                  isToday: isToday,
                  isActive: isActive,
                  isCompliant: isCompliant,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BackgroundPill extends StatelessWidget {
  final Animation<double> glowAnimation;
  final bool isPartOfCurrentStreak;
  final Color streakGlowColor;
  final double circleSize;
  final EdgeInsets margin;
  final Color baseStreakFillColor;
  final BorderRadiusGeometry borderRadius;

  const _BackgroundPill({
    required this.glowAnimation,
    required this.isPartOfCurrentStreak,
    required this.streakGlowColor,
    required this.circleSize,
    required this.margin,
    required this.baseStreakFillColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowAnimation,
      builder: (context, child) {
        List<BoxShadow>? shadows;
        if (isPartOfCurrentStreak) {
          final double opacity = glowAnimation.value * 0.5;
          shadows = [
            BoxShadow(
              color: streakGlowColor.withValues(alpha: opacity),
              blurRadius: 8,
              spreadRadius: 1,
            )
          ];
        }
        return Container(
          height: circleSize,
          margin: margin,
          decoration: BoxDecoration(
            color: baseStreakFillColor,
            borderRadius: borderRadius,
            boxShadow: shadows,
          ),
        );
      },
    );
  }
}

class _ActivityRings extends StatelessWidget {
  final AnimationController fillController;
  final int totalCells;
  final int index;
  final bool isCompliant;
  final bool isPartOfCurrentStreak;
  final Animation<double> glowAnimation;
  final Color timeColor;
  final Color vocabColor;
  final Color charactersColor;
  final double circleSize;
  final (int, int)? timeData;
  final (int, int)? vocabData;
  final (int, int)? charData;

  const _ActivityRings({
    required this.fillController,
    required this.totalCells,
    required this.index,
    required this.isCompliant,
    required this.isPartOfCurrentStreak,
    required this.glowAnimation,
    required this.timeColor,
    required this.vocabColor,
    required this.charactersColor,
    required this.circleSize,
    required this.timeData,
    required this.vocabData,
    required this.charData,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fillController,
      builder: (context, child) {
        final double totalItems = totalCells.toDouble();
        final double start = (index / totalItems) * 0.5; 
        final double end = start + 0.5;
        final curve = CurvedAnimation(
          parent: fillController,
          curve: Interval(start, end, curve: Curves.easeOut),
        );

        return Stack(
          alignment: Alignment.center,
          children: [
            if (timeData != null && timeData!.$1 > 0)
              BreathingNeonWrapper(
                isActive: isCompliant && isPartOfCurrentStreak,
                glowAnimation: glowAnimation,
                glowColor: timeColor,
                child: SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: CircularProgressIndicator(
                    value: _getPercent(timeData) * curve.value,
                    color: timeColor,
                    strokeWidth: 2.0,
                    backgroundColor: Colors.transparent,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
            if (vocabData != null && vocabData!.$1 > 0)
              SizedBox(
                width: circleSize * 0.75,
                height: circleSize * 0.75,
                child: CircularProgressIndicator(
                  value: _getPercent(vocabData) * curve.value,
                  color: vocabColor,
                  strokeWidth: 2.0,
                  backgroundColor: Colors.transparent,
                  strokeCap: StrokeCap.round,
                ),
              ),
            if (charData != null && charData!.$1 > 0)
              SizedBox(
                width: circleSize * 0.5, 
                height: circleSize * 0.5,
                child: CircularProgressIndicator(
                  value: _getPercent(charData) * curve.value,
                  color: charactersColor,
                  strokeWidth: 2.0,
                  backgroundColor: Colors.transparent,
                  strokeCap: StrokeCap.round,
                ),
              ),
          ],
        );
      },
    );
  }

  double _getPercent((int, int)? data) {
    if (data == null || data.$2 == 0) return 0.0;
    return (data.$1 / data.$2).clamp(0.0, 1.0);
  }
}

class _DateLabel extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isActive;
  final bool isCompliant;

  const _DateLabel({
    required this.date,
    required this.isToday,
    required this.isActive,
    required this.isCompliant,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isToday 
        ? Colors.lightBlueAccent 
        : (isActive ? Colors.white : Colors.grey[400]!);
    
    final FontWeight weight = isCompliant ? FontWeight.bold : FontWeight.normal;

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
}