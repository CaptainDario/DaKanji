import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/management_dialogs.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// A control bar for the time tracking feature, containing start/pause/resume
/// buttons and category/tag selection buttons.
class TimerControlBar extends StatelessWidget {
  final bool isRunning;
  final bool isPaused;
  final Color accentColor;
  final Color secondaryAccentColor;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;

  const TimerControlBar({
    super.key,
    required this.isRunning,
    required this.isPaused,
    required this.accentColor,
    required this.secondaryAccentColor,
    required this.onStart,
    required this.onPause,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch the currently selected category and tag from the database.
    return FutureBuilder<({String? selectedCategory, String? selectedTag})>(
      future: () async {
        final dao = GetIt.I<UserDataDB>().timeTrackingDao;
        return (
          selectedCategory: (await dao.getSelectedCategory()),
          selectedTag: (await dao.getSelectedTag()),
        );
      }(),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) return const SizedBox();

        final data = asyncSnapshot.data!;

        return Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: IntrinsicColumnWidth(), // Left Content: Fit to size
            1: FlexColumnWidth(1), // Spacer: Take available space
            2: IntrinsicColumnWidth(), // Center Content: Fit to size
            3: FlexColumnWidth(1), // Spacer: Take available space
            4: IntrinsicColumnWidth(), // Right Content: Fit to size
          },
          children: [
            // --- ROW 1: Controls ---
            TableRow(
              children: [
                // Left Icon for Category Selection
                _CategoryTagSelectorButton(
                  icon: Icons.category_outlined,
                  tooltipKey: LocaleKeys.TimeTrackingScreen_categories.tr(),
                  onPressed: () {
                    showCategorySelectionBottomSheet(
                      context,
                      onCategorySelected: (category) async {
                        await GetIt.I<UserDataDB>().timeTrackingDao.setSelectedCategory(category);
                      },
                    );
                  },
                ),

                const SizedBox(), // Spacer

                // Center Control Button (Start/Pause/Resume)
                _CenterControlButton(
                  isRunning: isRunning,
                  isPaused: isPaused,
                  accentColor: accentColor,
                  secondaryAccentColor: secondaryAccentColor,
                  onStart: onStart,
                  onPause: onPause,
                  onResume: onResume,
                ),

                const SizedBox(), // Spacer

                // Right Icon for Tag Selection
                _CategoryTagSelectorButton(
                  icon: Icons.tag_outlined,
                  tooltipKey: LocaleKeys.TimeTrackingScreen_tags.tr(),
                  onPressed: () {
                    showTagSelectionBottomSheet(
                      context,
                      onTagSelected: (tag) async {
                        await GetIt.I<UserDataDB>().timeTrackingDao.setSelectedTag(tag);
                      },
                    );
                  },
                ),
              ],
            ),

            // --- Spacer Row ---
            const TableRow(children: [
              SizedBox(height: 4),
              SizedBox(),
              SizedBox(height: 4),
              SizedBox(),
              SizedBox(height: 4),
            ]),

            // --- ROW 2: Labels ---
            _CategoryTagLabels(
              selectedCategory: data.selectedCategory,
              selectedTag: data.selectedTag,
            ),
          ],
        );
      },
    );
  }
}

// --- Helper Widgets ---

/// Helper widget to display the selected category and tag labels.
class _CategoryTagLabels extends TableRow {
  _CategoryTagLabels({
    required String? selectedCategory,
    required String? selectedTag,
  }) : super(children: [
          Center(
            child: Text(
              selectedCategory ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(), // Spacer
          const SizedBox(), // Center Column is empty here
          const SizedBox(), // Spacer
          Center(
            child: Text(
              selectedTag ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ]);
}

/// Helper widget for the circular icon buttons used for category and tag selection.
class _CategoryTagSelectorButton extends StatelessWidget {
  final IconData icon;
  final String tooltipKey;
  final VoidCallback onPressed;

  const _CategoryTagSelectorButton({
    required this.icon,
    required this.tooltipKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: Colors.grey,
          tooltip: tooltipKey,
        ),
      ),
    );
  }
}

/// Helper widget containing the main Start/Pause/Resume logic and button.
class _CenterControlButton extends StatelessWidget {
  final bool isRunning;
  final bool isPaused;
  final Color accentColor;
  final Color secondaryAccentColor;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;

  const _CenterControlButton({
    required this.isRunning,
    required this.isPaused,
    required this.accentColor,
    required this.secondaryAccentColor,
    required this.onStart,
    required this.onPause,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    Widget centerButton;

    // --- Button Logic ---
    if (!isRunning) {
      // Start Button
      centerButton = ElevatedButton.icon(
        key: const ValueKey("start_btn"),
        onPressed: onStart,
        icon: const Icon(Icons.play_arrow, size: 20),
        label: Text(LocaleKeys.TimeTrackingScreen_start.tr()),
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: const StadiumBorder(),
        ),
      );
    } else if (isPaused) {
      // Resume Button
      centerButton = ElevatedButton.icon(
        key: const ValueKey("resume_btn"),
        onPressed: onResume,
        icon: const Icon(Icons.play_arrow, size: 20),
        label: Text(LocaleKeys.TimeTrackingScreen_resume.tr()),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A4D8C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: const StadiumBorder(),
        ),
      );
    } else {
      // Pause Button
      centerButton = ElevatedButton.icon(
        key: const ValueKey("pause_btn"),
        onPressed: onPause,
        icon: const Icon(Icons.pause, size: 20),
        label: Text(LocaleKeys.TimeTrackingScreen_pause.tr()),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C2C2C),
          foregroundColor: secondaryAccentColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: const StadiumBorder(),
          side: BorderSide(
            color: secondaryAccentColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        // Set a minimum width for layout stability when the label text changes
        constraints: const BoxConstraints(minWidth: 120),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: centerButton,
        ),
      ),
    );
  }
}