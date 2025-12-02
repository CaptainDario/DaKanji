import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/home/model/stud_session_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class SessionTimelineRow extends StatelessWidget {
  final StudySessionUiModel session;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SessionTimelineRow({
    super.key,
    required this.session,
    required this.onDelete,
    required this.onEdit,
  });

  bool get _isRunning {
    // If the last unit has no end time, it is currently active
    return session.units.isNotEmpty && session.units.last.endTime == null;
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _isRunning;
    final currentTime = DateTime.now();

    // Calculate real-time values for running sessions
    final realEndTime = isRunning ? currentTime : session.endTime;
    
    // Add the elapsed time since load to the duration
    final realTotalDuration = isRunning 
        ? session.totalWorkDuration + currentTime.difference(session.endTime)
        : session.totalWorkDuration;

    return InkWell(
      onTap: onEdit,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TimeColumn(
              startTime: session.startTime,
              endTime: realEndTime,
              isRunning: isRunning,
            ),
            SizedBox(
              width: 24,
              child: TimelineConnector(
                units: session.units,
                totalDuration: realTotalDuration,
                color: session.color,
                isRunning: isRunning,
              ),
            ),
            Expanded(
              child: _SessionInfoColumn(
                session: session,
                realDuration: realTotalDuration,
              ),
            ),
            _DeleteAction(onDelete: onDelete),
          ],
        ),
      ),
    );
  }
}

class TimelineConnector extends StatelessWidget {
  final List<TimeTrackingUnitTableData> units;
  final Duration totalDuration;
  final Color color;
  final bool isRunning;

  const TimelineConnector({
    super.key,
    required this.units,
    required this.totalDuration,
    required this.color,
    this.isRunning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 22),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: CustomPaint(
            painter: _TimelineLinePainter(
              units: units,
              totalDuration: totalDuration,
              color: color,
              isRunning: isRunning,
            ),
            child: Container(),
          ),
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[600],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class _TimelineLinePainter extends CustomPainter {
  final List<TimeTrackingUnitTableData> units;
  final Duration totalDuration;
  final Color color;
  final bool isRunning;

  _TimelineLinePainter({
    required this.units,
    required this.totalDuration,
    required this.color,
    required this.isRunning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (units.isEmpty) return;

    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double totalHeight = size.height;
    final int totalSeconds = totalDuration.inSeconds > 0 
        ? totalDuration.inSeconds 
        : 1;
        
    final sessionStartTime = units.first.startTime;

    for (var unit in units) {
      final unitStart = unit.startTime;
      final isLastUnit = unit == units.last;
      
      // Use current time for the end of the last unit if running
      final unitEnd = (isLastUnit && isRunning) 
          ? DateTime.now() 
          : (unit.endTime ?? DateTime.now());

      final startRatio =
          unitStart.difference(sessionStartTime).inSeconds / totalSeconds;
      final endRatio =
          unitEnd.difference(sessionStartTime).inSeconds / totalSeconds;

      final startY = (startRatio * totalHeight).clamp(0.0, totalHeight);
      final endY = (endRatio * totalHeight).clamp(0.0, totalHeight);

      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineLinePainter oldDelegate) {
    return oldDelegate.units != units ||
        oldDelegate.totalDuration != totalDuration ||
        oldDelegate.isRunning != isRunning;
  }
}

class _TimeColumn extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final bool isRunning;

  const _TimeColumn({
    required this.startTime,
    required this.endTime,
    this.isRunning = false,
  });

  @override
  Widget build(BuildContext context) {
    final isNextDay = endTime.day != startTime.day;

    return SizedBox(
      width: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 0, right: 8, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                DateFormat('HH:mm').format(startTime),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: isRunning
                  ? const Text(
                      "Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(endTime),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        if (isNextDay)
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              "+1",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
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
}

class _SessionInfoColumn extends StatelessWidget {
  final StudySessionUiModel session;
  final Duration realDuration;

  const _SessionInfoColumn({
    required this.session,
    required this.realDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(
                session.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (session.tag != null) _TagBadge(tag: session.tag!),
            ],
          ),
          const SizedBox(height: 4),
          _SessionDurationInfo(
            workMinutes: realDuration.inMinutes,
            breakMinutes: session.totalBreakDuration.inMinutes,
          ),
        ],
      ),
    );
  }
}

class _TagBadge extends StatelessWidget {
  final String tag;

  const _TagBadge({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 12,
        ),
      ),
    );
  }
}

class _SessionDurationInfo extends StatelessWidget {
  final int workMinutes;
  final int breakMinutes;

  const _SessionDurationInfo({
    required this.workMinutes,
    required this.breakMinutes,
  });

  @override
  Widget build(BuildContext context) {
    final workStr = "$workMinutes min";
    final breakStr = breakMinutes > 0 ? "$breakMinutes min" : null;

    return Row(
      children: [
        Icon(Icons.timer_outlined, size: 14, color: Colors.grey[400]),
        const SizedBox(width: 4),
        Text(
          workStr,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        if (breakStr != null) ...[
          const SizedBox(width: 12),
          Icon(Icons.coffee, size: 14, color: Colors.brown[300]),
          const SizedBox(width: 4),
          Text(
            breakStr,
            style: TextStyle(
              color: Colors.brown[300],
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}

class _DeleteAction extends StatelessWidget {
  final VoidCallback onDelete;

  const _DeleteAction({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.grey[600]),
          onPressed: onDelete,
        ),
      ),
    );
  }
} 