import 'package:da_kanji_mobile/features/home/widgets/study_details_editor/editor_widgets.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/management_dialogs.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';

class SessionEditorSheet extends StatefulWidget {
  final DateTime initialStart;
  final DateTime initialEnd;
  final String initialCategory;
  final String? initialTag;
  final int initialBreakMinutes;
  final Color vocabColor;
  final Color kanjiColor;
  final bool isEditing;
  final List<DateTimeRange> occupiedRanges;

  const SessionEditorSheet({
    super.key,
    required this.initialStart,
    required this.initialEnd,
    required this.initialCategory,
    this.initialTag,
    required this.initialBreakMinutes,
    required this.vocabColor,
    required this.kanjiColor,
    required this.isEditing,
    required this.occupiedRanges,
  });

  @override
  State<SessionEditorSheet> createState() => _SessionEditorSheetState();
}

class _SessionEditorSheetState extends State<SessionEditorSheet> {
  late DateTime _startTime;
  late DateTime _endTime;
  late String? _category;
  String? _tag;
  late TextEditingController _breakController;

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStart;
    _endTime = widget.initialEnd;
    _category = widget.initialCategory;
    _tag = widget.initialTag;
    _breakController =
        TextEditingController(text: widget.initialBreakMinutes.toString());
  }

  @override
  void dispose() {
    _breakController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool isStart) async {
    final initial = isStart ? _startTime : _endTime;
    
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: g_Dakanji_green, // Header background & Active dial hand
              onPrimary: Colors.white,
              surface: Color(0xFF2C323A), // Dialog background
              onSurface: Colors.white, // General text
            ),
            
            // 1. Customize the AM/PM Switch
            timePickerTheme: TimePickerThemeData(
              // Background color of the AM/PM container
              dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? g_Dakanji_green // Background when selected
                      : Colors.white10), // Background when not selected
              
              // Text color inside the AM/PM container
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.white // Text color when selected
                      : Colors.grey), // Text color when not selected

              // 1. Style the "Cancel" button (e.g., Grey or Red)
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.grey),
              ),

              // 2. Style the "OK" button (e.g., Green)
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(
                  Theme.brightnessOf(context) == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
                      
              // Optional: Remove or color the border
              dayPeriodBorderSide: BorderSide.none, 
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null) return;

    setState(() {
      if (isStart) {
        // Simple update for start time
        final newStart = DateTime(
          _startTime.year,
          _startTime.month,
          _startTime.day,
          time.hour,
          time.minute,
        );
        _startTime = newStart;

        // If pushing start time makes end time invalid, push end time forward
        if (_endTime.isBefore(_startTime)) {
          _endTime = _startTime.add(const Duration(minutes: 30));
        }
      } else {
        // Smart logic for End Time:
        // 1. Create a candidate DateTime on the SAME day as the start time
        final candidateSameDay = DateTime(
          _startTime.year,
          _startTime.month,
          _startTime.day,
          time.hour,
          time.minute,
        );

        // 2. If the candidate time is before the start time (e.g. Start 23:00, Picked 01:00),
        // we assume the user means the next day.
        if (candidateSameDay.isBefore(_startTime)) {
          _endTime = candidateSameDay.add(const Duration(days: 1));
        } else {
          _endTime = candidateSameDay;
        }
      }
    });
  }

  void _openCategorySelector() {
    showCategorySelectionBottomSheet(
      context,
      onCategorySelected: (val) {
        setState(() => _category = val);
        Navigator.pop(context);
      },
    );
  }

  void _openTagSelector() {
    showTagSelectionBottomSheet(
      context,
      onTagSelected: (val) {
        setState(() => _tag = val);
        Navigator.pop(context);
      },
    );
  }

  Color get _activeColor =>
      _category == 'Vocab' ? widget.vocabColor : widget.kanjiColor;

  _OverlapResult _calculateOverlap() {
    bool isStartOverlap = false;
    bool isEndOverlap = false;
    bool hasAnyOverlap = false;

    for (final range in widget.occupiedRanges) {
      if (_startTime.isBefore(range.end) && _endTime.isAfter(range.start)) {
        hasAnyOverlap = true;
        if (!_startTime.isBefore(range.start) &&
            _startTime.isBefore(range.end)) {
          isStartOverlap = true;
        }
        if (_endTime.isAfter(range.start) && !_endTime.isAfter(range.end)) {
          isEndOverlap = true;
        }
        if (_startTime.isBefore(range.start) && _endTime.isAfter(range.end)) {
          isStartOverlap = true;
          isEndOverlap = true;
        }
      }
    }
    return _OverlapResult(isStartOverlap, isEndOverlap, hasAnyOverlap);
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = _endTime.difference(_startTime);
    final totalMinutes = totalDuration.inMinutes;
    int breakMinutes = int.tryParse(_breakController.text) ?? 0;

    final overlap = _calculateOverlap();
    final bool isTimeValid = _endTime.isAfter(_startTime);
    final bool isBreakValid = breakMinutes < totalMinutes;
    final bool isValid = isTimeValid &&
        isBreakValid &&
        breakMinutes >= 0 &&
        !overlap.hasAnyOverlap;

    final netStudyMinutes = isValid ? totalMinutes - breakMinutes : 0;
    final isEndNextDay = _endTime.day != _startTime.day;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _EditorHeader(
              title: widget.isEditing ? "セッションの編集" : "新しいセッション",
              isValid: isValid,
              netStudyMinutes: netStudyMinutes,
            ),
            const SizedBox(height: 24),
            _SelectionTile(
              label: "カテゴリー",
              value: _category ?? "",
              icon: Icons.category_outlined,
              valueColor: _tag == null ? Colors.grey : Colors.white,
              onTap: _openCategorySelector,
            ),
            const SizedBox(height: 16),
            _SelectionTile(
              label: "タグ",
              value: _tag ?? "",
              icon: Icons.label_outline,
              valueColor: _tag == null ? Colors.grey : Colors.white,
              onTap: _openTagSelector,
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TimeDisplay(
                    label: "Start",
                    time: _startTime,
                    onTap: () => _pickTime(true),
                    isError: overlap.isStartOverlap,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                  child: Icon(Icons.arrow_forward,
                      color: Colors.grey[600], size: 20),
                ),
                Expanded(
                  child: TimeDisplay(
                    label: "End",
                    time: _endTime,
                    onTap: () => _pickTime(false),
                    isError: !isTimeValid || overlap.isEndOverlap,
                    isNextDay: isEndNextDay,
                  ),
                ),
              ],
            ),
            if (!isTimeValid)
              const _ErrorMessage(text: "終了時間は開始時間より後である必要があります"),
            if (overlap.hasAnyOverlap)
              const _ErrorMessage(text: "選択した時間は他のセッションと重なっています"),
            const SizedBox(height: 24),
            _BreakDurationInput(
              controller: _breakController,
              isBreakValid: isBreakValid,
              onChanged: (_) => setState(() {}),
              activeColor: _activeColor,
            ),
            if (!isBreakValid && isTimeValid)
              const _ErrorMessage(text: "休憩時間は合計時間より短くする必要があります"),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white10,
                  disabledForegroundColor: Colors.grey[600],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isValid
                    ? () {
                        Navigator.pop(context, {
                          'start': _startTime,
                          'end': _endTime,
                          'category': _category,
                          'tag': _tag,
                          'breakMinutes': breakMinutes,
                        });
                      }
                    : null,
                child: const Text("保存",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverlapResult {
  final bool isStartOverlap;
  final bool isEndOverlap;
  final bool hasAnyOverlap;

  _OverlapResult(this.isStartOverlap, this.isEndOverlap, this.hasAnyOverlap);
}

class _EditorHeader extends StatelessWidget {
  final String title;
  final bool isValid;
  final int netStudyMinutes;

  const _EditorHeader({
    required this.title,
    required this.isValid,
    required this.netStudyMinutes,
  });

  @override
  Widget build(BuildContext context) {
    const successGreen = g_Dakanji_green;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (isValid)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: successGreen.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: successGreen),
            ),
            child: Text(
              "Net Study: ${netStudyMinutes}m",
              style: TextStyle(
                  color: successGreen.withGreen(130),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final Color? activeColor;
  final Color? valueColor;

  const _SelectionTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    this.activeColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: activeColor ?? Colors.grey[400], size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BreakDurationInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isBreakValid;
  final ValueChanged<String> onChanged;
  final Color activeColor;

  const _BreakDurationInput({
    required this.controller,
    required this.isBreakValid,
    required this.onChanged,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.coffee_outlined, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        const Text("休憩時間 (分):", style: TextStyle(color: Colors.grey)),
        const SizedBox(width: 16),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: activeColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String text;

  const _ErrorMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 4),
      child: Text(text,
          style: const TextStyle(color: g_Dakanji_red, fontSize: 12)),
    );
  }
}