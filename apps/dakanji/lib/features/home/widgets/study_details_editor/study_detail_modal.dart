import 'dart:async';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/home/model/stud_session_model.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/session_editor_sheet.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/study_stats_widgets.dart';
import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/timeline_widgets.dart';
import 'package:da_kanji_mobile/globals.dart';
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
  /// Prevents UI rendering before DB fetch completes
  bool _isLoading = true;
  
  /// Source of truth for the timeline list
  List<StudySessionUiModel> _sessions = [];
  
  /// Temporarily holds a deleted item to allow for "Undo" functionality
  StudySessionUiModel? _lastDeletedSession;

  /// Timer to update the UI for running sessions
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadData();

    // Rebuild every 30 seconds to update relative times/durations for running sessions
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    // Ensure pending deletion is committed if user closes modal while SnackBar is active
    if (_lastDeletedSession != null) {
      GetIt.I<UserDataDB>().timeTrackingDao.deleteSession(_lastDeletedSession!.id);
    }
    super.dispose();
  }

  Future<void> _loadData() async {
    final dao = GetIt.I<UserDataDB>().timeTrackingDao;
    final rawData = await dao.getSessionsForDate(widget.date);
    
    final mappedSessions = _mapSessionsToUiModels(
      rawData, 
      widget.vocabColor, 
      widget.charactersColor, 
      widget.timeColor
    );

    if (mounted) {
      setState(() {
        _sessions = mappedSessions;
        _isLoading = false;
      });
    }
  }

  /// Removes item from UI immediately (Optimistic Update).
  /// DB deletion occurs only after SnackBar closes without "Undo".
  void _deleteSession(int index, BuildContext snackContext) {
    // Capture the specific item LOCALLY.
    final deletedItem = _sessions[index];
    
    // Capture the Messenger BEFORE setState removes the widget from the tree.
    // If we wait until after setState, 'snackContext' might be unmounted.
    final messenger = ScaffoldMessenger.of(snackContext);
    
    // Update the class-level tracker purely for 'dispose' safety
    _lastDeletedSession = deletedItem;

    setState(() {
      _sessions.removeAt(index);
    });

    // 4. Use the captured messenger reference
    messenger.removeCurrentSnackBar();
    
    final controller = messenger.showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2C323A),
        content: Text(
          "${deletedItem.category} (${deletedItem.totalWorkDuration.inMinutes} min.) session deleted",
          style: const TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "Undo",
          textColor: Theme.brightnessOf(context) == Brightness.dark
              ? Colors.white
              : Colors.black,
          onPressed: () {
            setState(() {
              // If other items were deleted while this SnackBar was active, 
              // the original 'index' might now be out of bounds.
              final insertionIndex = index > _sessions.length 
                  ? _sessions.length 
                  : index;

              _sessions.insert(insertionIndex, deletedItem);
              
              // Only clear the global tracker if it still matches this item
              if (_lastDeletedSession == deletedItem) {
                _lastDeletedSession = null;
              }
            });
          },
        ),
      ),
    );

    controller.closed.then((reason) async {
      // 6. If the user did NOT press undo (timeout, swipe, or replaced by next delete)
      if (reason != SnackBarClosedReason.action) {
        await GetIt.I<UserDataDB>().timeTrackingDao.deleteSession(deletedItem.id);
      }
      
      // Cleanup global tracker if this specific cycle is finished
      if (_lastDeletedSession == deletedItem) {
        _lastDeletedSession = null;
      }
    });
  }

  Future<void> _openSessionSheet([StudySessionUiModel? session]) async {
    final isEditing = session != null;
    final defaultStart = DateTime.now().subtract(const Duration(minutes: 30));
    final defaultEnd = DateTime.now();

    // Calculate occupied time ranges to prevent overlapping sessions in the editor
    final occupiedRanges = _sessions
        .where((s) => s.id != session?.id)
        .map((s) => DateTimeRange(start: s.startTime, end: s.endTime))
        .toList();

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
        initialBreakMinutes: isEditing ? session.totalBreakDuration.inMinutes : 0,
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
    } else {
      await dao.insertPastSession(
        startTime: start,
        endTime: end,
        category: category,
        tag: tag,
        breakMinutes: breakMinutes,
      );
    }

    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy年MM月dd日 (E)', 'ja_JP').format(widget.date);

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: const Color(0xFF1E2329),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openSessionSheet(null),
          backgroundColor: g_Dakanji_green,
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
            const SliverToBoxAdapter(child: Divider(color: Colors.white10, height: 1)),
            
            // Inlined Timeline Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Text(
                  "タイムライン",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            if (_isLoading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (_sessions.isEmpty)
              // Inlined Empty State
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      "No sessions recorded",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (itemContext, index) {
                    return SessionTimelineRow(
                      session: _sessions[index],
                      onDelete: () => _deleteSession(index, itemContext),
                      onEdit: () => _openSessionSheet(_sessions[index]),
                    );
                  },
                  childCount: _sessions.length,
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
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
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

// -----------------------------------------------------------------------------
// Helper Methods
// -----------------------------------------------------------------------------

List<StudySessionUiModel> _mapSessionsToUiModels(
  List<dynamic> rawData, 
  Color vocabColor,
  Color charactersColor,
  Color timeColor,
) {
  return rawData.map((e) {
    final units = e.units;
    if (units.isEmpty) return null;

    final startTime = units.first.startTime;
    final endTime = units.last.endTime ?? DateTime.now();

    Duration totalWork = Duration.zero;
    Duration totalBreak = Duration.zero;

    // Iterates units to sum work duration and calculate breaks between disjoint units
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
      sessionColor = vocabColor;
    } else if (e.session.category == 'Kanji') {
      sessionColor = charactersColor;
    } else {
      sessionColor = timeColor;
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
}