import 'package:da_kanji_mobile/core/user/user_data_db.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'streak_reward_badge.dart'; // Import the new reusable widget

class StreakFooter extends StatelessWidget {
  final int streak;
  final DateTime now;
  final PageController pageController;
  final AnimationController glowController; 
  final Animation<double> glowAnimation;
  
  final Color streakColor;
  final Color timeColor;
  final Color charactersColor;

  const StreakFooter({
    super.key,
    required this.streak,
    required this.now,
    required this.pageController,
    required this.glowController,
    required this.glowAnimation,
    required this.streakColor,
    required this.timeColor,
    required this.charactersColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _JumpToTodayButton(
          now: now,
          pageController: pageController,
        ),
        // Simplified usage:
        FutureBuilder(
          future: GetIt.I<UserDataDB>().timeTrackingDao.calculateTimeStreak(),
          builder: (context, asyncSnapshot) {
            return StreakRewardBadge(
              streak: asyncSnapshot.data ?? 0,
              streakColor: streakColor,
              timeColor: timeColor,
              charactersColor: charactersColor,
              externalAnimation: glowAnimation, // Syncs with calendar
            );
          }
        ),
      ],
    );
  }
}

class _JumpToTodayButton extends StatelessWidget {
  // ... (Keep existing implementation) ...
  final DateTime now;
  final PageController pageController;

  const _JumpToTodayButton({
    required this.now,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          pageController.animateToPage(0, 
            duration: const Duration(milliseconds: 500), 
            curve: Curves.easeOutExpo
          );
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            DateFormat('yyyy年MM月dd日 (E)', 'ja_JP').format(now),
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
      ),
    );
  }
}
