import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'breathing_neon_wrapper.dart';

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
    // Initialize default styles for Streak = 0
    Color textColor = Colors.grey;
    FontWeight textWeight = FontWeight.normal;
    Color containerColor = Colors.grey;
    Color iconColor = Colors.white; 
    double iconOpacity = 0.0; 
    double glowOpacity = 0.0;
    bool showLottie = false;

    double getT(double start, double end) => ((streak - start) / (end - start)).clamp(0.0, 1.0);

    if (streak >= 1) {
      textColor = Color.lerp(Colors.grey, Colors.white, getT(1, 5))!;
    }
    if (streak >= 5) {
      textWeight = FontWeight.lerp(FontWeight.normal, FontWeight.bold, getT(5, 10))!;
    }
    if (streak >= 10) {
      iconOpacity = getT(10, 20);
    }
    if (streak >= 20) {
      containerColor = Color.lerp(Colors.grey, streakColor, getT(20, 30))!;
    }
    if (streak >= 30) {
      containerColor = Color.lerp(streakColor, timeColor, getT(30, 45))!;
    }
    if (streak >= 45) {
      containerColor = Color.lerp(timeColor, charactersColor, getT(45, 60))!;
    }
    if (streak >= 60) {
      iconColor = Color.lerp(Colors.white, charactersColor, getT(60, 90))!;
    }
    if (streak >= 90) {
      glowOpacity = getT(90, 180);
    }
    if (streak >= 360) {
      showLottie = true;
    }

    Color finalContainerFill = containerColor.withValues(alpha: 0.15);
    Color finalContainerBorder = containerColor.withValues(alpha: 0.5);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Jump to Today
        Material(
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
        ),
        
        // Streak Reward Container
        AnimatedBuilder(
          animation: glowController,
          builder: (context, child) {
            Color activeGlowColor = Colors.transparent;
            if (glowOpacity > 0) {
               activeGlowColor = Color.lerp(Colors.orangeAccent, Colors.redAccent, 0.5)!;
               activeGlowColor = activeGlowColor.withValues(alpha: glowOpacity);
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: finalContainerFill,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: finalContainerBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (streak > 10) ...[
                    if (showLottie)
                      BreathingNeonWrapper(
                        isActive: true, 
                        glowAnimation: glowAnimation,
                        glowColor: activeGlowColor,
                        customGlowChild: ColorFiltered(
                          colorFilter: ColorFilter.mode(activeGlowColor, BlendMode.srcIn),
                          child: Lottie.asset(
                            'assets/animations/fire.json',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                          child: Lottie.asset(
                            'assets/animations/fire.json',
                            width: 20, 
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    else
                      Opacity(
                        opacity: iconOpacity,
                        child: BreathingNeonWrapper(
                          isActive: glowOpacity > 0,
                          glowAnimation: glowAnimation,
                          glowColor: activeGlowColor,
                          customGlowChild: Icon(
                            Icons.local_fire_department,
                            color: activeGlowColor,
                            size: 16
                          ),
                          child: Icon(
                            Icons.local_fire_department, 
                            color: iconColor, 
                            size: 16
                          ),
                        ),
                      ),
                    const SizedBox(width: 4), 
                  ],
                  Text(
                    "$streak 日連続",
                    style: TextStyle(
                      color: textColor, 
                      fontWeight: textWeight, 
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            );
          }
        )
      ],
    );
  }
}