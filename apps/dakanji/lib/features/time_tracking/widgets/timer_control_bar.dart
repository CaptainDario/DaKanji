import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:da_kanji_mobile/features/time_tracking/widgets/management_dialogs.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
    Widget centerButton;

    // --- Button Logic ---
    if (!isRunning) {
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

    return FutureBuilder<({String? selectedCategory, String? selectedTag})>(
      future: () async {
        return (
          selectedCategory: (await GetIt.I<UserDataDB>().timeTrackingDao.getSelectedCategory()),
          selectedTag: (await GetIt.I<UserDataDB>().timeTrackingDao.getSelectedTag()),
        );
      }(),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) return const SizedBox();

        return Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          // 1. HORIZONTAL SPACING FIX
          // Intrinsic: Shrink column to fit the content exactly
          // Flex: Expand column to fill all remaining space
          columnWidths: const {
            0: IntrinsicColumnWidth(),  // Left Content: Fit to size
            1: FlexColumnWidth(1),      // Spacer: TAKE AVAILABLE SPACE
            2: IntrinsicColumnWidth(),  // Center Content: Fit to size
            3: FlexColumnWidth(1),      // Spacer: TAKE AVAILABLE SPACE
            4: IntrinsicColumnWidth(),  // Right Content: Fit to size
          },
          children: [
            // --- ROW 1: Controls ---
            TableRow(
              children: [
                // Left Icon
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showCategorySelectionBottomSheet(
                          context,
                          onCategorySelected: (category) async {
                            await GetIt.I<UserDataDB>().timeTrackingDao.setSelectedCategory(category);
                          },
                        );
                      },
                      icon: const Icon(Icons.category_outlined),
                      color: Colors.grey,
                      tooltip: LocaleKeys.TimeTrackingScreen_categories.tr(),
                    ),
                  ),
                ),
                
                // Spacer
                const SizedBox(),

                // Center Button (Wrapped in ConstrainedBox to prevent layout jumping when label changes width)
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 120), // Optional: Minimum width for stability
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: centerButton,
                    ),
                  ),
                ),

                // Spacer
                const SizedBox(),

                // Right Icon
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showTagSelectionBottomSheet(
                          context,
                          onTagSelected: (tag) async {
                            await GetIt.I<UserDataDB>().timeTrackingDao.setSelectedTag(tag);
                          },
                        );
                      },
                      icon: const Icon(Icons.tag_outlined),
                      color: Colors.grey,
                      tooltip: LocaleKeys.TimeTrackingScreen_tags.tr(),
                    ),
                  ),
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
            TableRow(
              children: [
                Center(
                  child: Text(
                    asyncSnapshot.data!.selectedCategory ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                Center(
                  child: Text(
                    asyncSnapshot.data!.selectedTag ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}