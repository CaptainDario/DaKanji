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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TimeColumn(
              startTime: session.startTime,
              endTime: session.endTime,
            ),
            SizedBox(
              width: 24,
              child: TimelineConnector(
                units: session.units,
                totalDuration: session.endTime.difference(session.startTime),
                color: session.color,
              ),
            ),
            Expanded(
              child: _SessionInfoColumn(session: session),
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

  const TimelineConnector({
    super.key,
    required this.units,
    required this.totalDuration,
    required this.color,
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

  _TimelineLinePainter({
    required this.units,
    required this.totalDuration,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (units.isEmpty || totalDuration.inSeconds == 0) return;

    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double totalHeight = size.height;
    final int totalSeconds = totalDuration.inSeconds;
    final sessionStartTime = units.first.startTime;

    for (var unit in units) {
      final unitStart = unit.startTime;
      final unitEnd = unit.endTime ?? DateTime.now();

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
        oldDelegate.totalDuration != totalDuration;
  }
}

class _TimeColumn extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;

  const _TimeColumn({
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                DateFormat('HH:mm').format(endTime),
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
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

  const _SessionInfoColumn({required this.session});

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
            workMinutes: session.totalWorkDuration.inMinutes,
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
          tooltip: "セッションを削除",
        ),
      ),
    );
  }
}