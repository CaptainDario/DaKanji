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

    if (!isRunning) {
      // Idle State
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
      // Paused State
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
      // Running State
      centerButton = ElevatedButton.icon(
        key: ValueKey("pause_btn"),
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
      } (),
      builder: (context, asyncSnapshot) {

        if(!asyncSnapshot.hasData) return SizedBox();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _OptionButton(
              icon: Icons.category_outlined,
              label: asyncSnapshot.data!.selectedCategory,
              tooltip: LocaleKeys.TimeTrackingScreen_categories.tr(),
              onTap: () async {
                showCategorySelectionBottomSheet(context);
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: centerButton,
            ),
            _OptionButton(
              icon: Icons.tag_outlined,
              label: asyncSnapshot.data!.selectedTag,
              tooltip: LocaleKeys.TimeTrackingScreen_tags.tr(),
              onTap: () {
                showTagSelectionBottomSheet(context);
              },
            ),
          ],
        );
      }
    );
  }
}

class _OptionButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String tooltip;
  final VoidCallback onTap;

  const _OptionButton({
    required this.icon,
    this.label,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon),
            color: Colors.grey,
            tooltip: tooltip,
          ),
        ),
        if (label != null)
          Text(
            label!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          )
      ],
    );
  }
}
