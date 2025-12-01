import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/home/model/stud_session_model.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/session_editor_sheet.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/study_stats_widgets.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/timeline_widgets.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

class StudyDetailModal extends StatefulWidget {
  final DateTime date;
  final (int, int)? vocabData;
  final (int, int)? charData;
  final (int, int)? timeData;
  final Color vocabColor;
  final Color charactersColor;
  final Color timeColor;

  const StudyDetailModal({
    super.key,
    required this.date,
    required this.vocabData,
    required this.charData,
    required this.timeData,
    required this.vocabColor,
    required this.charactersColor,
    required this.timeColor,
  });

  @override
  State<StudyDetailModal> createState() => _StudyDetailModalState();
}

class _StudyDetailModalState extends State<StudyDetailModal> {
  bool _isLoading = true;
  List<StudySessionUiModel> _sessions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dao = GetIt.I<UserDataDB>().timeTrackingDao;
    final rawData = await dao.getSessionsForDate(widget.date);

    final mappedSessions = rawData.map((e) {
      final units = e.units;
      if (units.isEmpty) return null;

      final startTime = units.first.startTime;
      final endTime = units.last.endTime ?? DateTime.now();

      Duration totalWork = Duration.zero;
      Duration totalBreak = Duration.zero;

      for (int i = 0; i < units.length; i++) {
        final unit = units[i];
        final unitEnd = unit.endTime ?? DateTime.now();
        totalWork += unitEnd.difference(unit.startTime);

        if (i < units.length - 1) {
          final nextUnit = units[i + 1];
          totalBreak += nextUnit.startTime.difference(unitEnd);
        }
      }

      Color sessionColor = Colors.grey;
      if (e.session.category == 'Vocab') {
        sessionColor = widget.vocabColor;
      } else if (e.session.category == 'Kanji') {
        sessionColor = widget.charactersColor;
      } else {
        sessionColor = widget.timeColor;
      }

      return StudySessionUiModel(
        id: e.session.id,
        startTime: startTime,
        endTime: endTime,
        totalWorkDuration: totalWork,
        totalBreakDuration: totalBreak,
        category: e.session.category ?? "General",
        tag: e.session.tag,
        color: sessionColor,
        units: units,
      );
    }).whereType<StudySessionUiModel>().toList();

    if (mounted) {
      setState(() {
        _sessions = mappedSessions;
        _isLoading = false;
      });
    }
  }

  void _deleteSession(int index) {
    final deletedItem = _sessions[index];

    setState(() {
      _sessions.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2C323A),
        content: const Text(
          "セッションを削除しました",
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "元に戻す",
          textColor: Colors.blueAccent,
          onPressed: () {
            setState(() {
              _sessions.insert(index, deletedItem);
            });
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    ).closed.then((reason) async {
      if (reason != SnackBarClosedReason.action) {
        final dao = GetIt.I<UserDataDB>().timeTrackingDao;
        print("DB: Deleted session ${deletedItem.id}");
      }
    });
  }

  Future<void> _openSessionSheet([StudySessionUiModel? session]) async {
    final isEditing = session != null;

    final defaultStart = DateTime.now().subtract(const Duration(minutes: 30));
    final defaultEnd = DateTime.now();

    final otherSessions = _sessions.where((s) => s.id != session?.id);

    final occupiedRanges = otherSessions.map((s) {
      return DateTimeRange(start: s.startTime, end: s.endTime);
    }).toList();

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF2C323A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SessionEditorSheet(
        initialStart: isEditing ? session.startTime : defaultStart,
        initialEnd: isEditing ? session.endTime : defaultEnd,
        initialCategory: isEditing ? session.category : "Vocab",
        initialTag: isEditing ? session.tag : null,
        initialBreakMinutes:
            isEditing ? session.totalBreakDuration.inMinutes : 0,
        vocabColor: widget.vocabColor,
        kanjiColor: widget.charactersColor,
        isEditing: isEditing,
        occupiedRanges: occupiedRanges,
      ),
    );

    if (result == null) return;

    await _saveSessionToDb(
      id: session?.id,
      start: result['start'],
      end: result['end'],
      category: result['category'],
      tag: result['tag'],
      breakMinutes: result['breakMinutes'],
    );
  }

  Future<void> _saveSessionToDb({
    int? id,
    required DateTime start,
    required DateTime end,
    required String category,
    String? tag,
    required int breakMinutes,
  }) async {
    setState(() => _isLoading = true);
    final dao = GetIt.I<UserDataDB>().timeTrackingDao;

    if (id != null) {
      await dao.updateSession(
        sessionId: id,
        newStartTime: start,
        newEndTime: end,
        newBreakMinutes: breakMinutes,
        category: category,
        tag: tag,
      );
      print("DB: Updated session $id");
    } else {
      print("DB: Insert new session");
    }

    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy年MM月dd日 (E)', 'ja_JP').format(widget.date);

    return Scaffold(
      backgroundColor: const Color(0xFF1E2329),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSessionSheet(null),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF1E2329),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              dateStr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: _StatsSummarySection(
              timeData: widget.timeData,
              charData: widget.charData,
              vocabData: widget.vocabData,
              timeColor: widget.timeColor,
              charactersColor: widget.charactersColor,
              vocabColor: widget.vocabColor,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(color: Colors.white10, height: 1),
          ),
          const SliverToBoxAdapter(
            child: _TimelineHeader(),
          ),
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_sessions.isEmpty)
            const SliverToBoxAdapter(
              child: _EmptySessionState(),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SessionTimelineRow(
                    session: _sessions[index],
                    onDelete: () => _deleteSession(index),
                    onEdit: () => _openSessionSheet(_sessions[index]),
                  );
                },
                childCount: _sessions.length,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _StatsSummarySection extends StatelessWidget {
  final (int, int)? timeData;
  final (int, int)? charData;
  final (int, int)? vocabData;
  final Color timeColor;
  final Color charactersColor;
  final Color vocabColor;

  const _StatsSummarySection({
    required this.timeData,
    required this.charData,
    required this.vocabData,
    required this.timeColor,
    required this.charactersColor,
    required this.vocabColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          if (timeData == null && vocabData == null && charData == null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                LocaleKeys.HomeScreen_study_calendar_no_study_data.tr(),
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          if (timeData != null)
            StatRow(label: "時間", data: timeData!, color: timeColor),
          if (charData != null)
            StatRow(label: "文字", data: charData!, color: charactersColor),
          if (vocabData != null)
            StatRow(label: "単語", data: vocabData!, color: vocabColor),
        ],
      ),
    );
  }
}

class _TimelineHeader extends StatelessWidget {
  const _TimelineHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Text(
        "タイムライン",
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _EmptySessionState extends StatelessWidget {
  const _EmptySessionState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Text(
          "No sessions recorded",
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}