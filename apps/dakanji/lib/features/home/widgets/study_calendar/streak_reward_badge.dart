import 'package:da_kanji_mobile/features/home/widgets/study_calendar/breathing_neon_wrapper.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StreakRewardBadge extends StatefulWidget {
  final int streak;
  final Color streakColor;
  final Color timeColor;
  final Color charactersColor;
  final Animation<double>? externalAnimation;
  final double scale;

  const StreakRewardBadge({
    super.key,
    required this.streak,
    this.streakColor = g_color_scheme_green,
    this.timeColor = g_color_scheme_blue,    
    this.charactersColor = g_color_scheme_red, 
    this.externalAnimation,
    this.scale = 1.0,
  });

  @override
  State<StreakRewardBadge> createState() => _StreakRewardBadgeState();
}

class _StreakRewardBadgeState extends State<StreakRewardBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _localController;
  late final Animation<double> _localAnimation;

  @override
  void initState() {
    super.initState();
    _localController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _localAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _localController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _localController.dispose();
    super.dispose();
  }

  Animation<double> get _activeAnimation => widget.externalAnimation ?? _localAnimation;

  @override
  Widget build(BuildContext context) {
    final style = _calculateStreakStyle();

    final double paddingH = 8.0 * widget.scale;
    final double paddingV = 4.0 * widget.scale;
    final double fontSize = 12.0 * widget.scale;
    
    // UNIFIED SIZE: This variable controls the exact box size for the icon slot
    final double badgeHeight = 20.0 * widget.scale;

    final double gap = 4.0 * widget.scale;
    final double borderRadius = 8.0 * widget.scale;

    return AnimatedBuilder(
      animation: _activeAnimation, 
      builder: (context, child) {
        Color activeGlowColor = Colors.transparent;
        if (style.glowOpacity > 0) {
           activeGlowColor = Color.lerp(Colors.orangeAccent, Colors.redAccent, 0.5)!;
           activeGlowColor = activeGlowColor.withValues(alpha: style.glowOpacity);
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
          decoration: BoxDecoration(
            color: style.containerFill,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: style.containerBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // assure same height
              SizedBox(height: badgeHeight),
              
              if (widget.streak > 10) ...[
                SizedBox(
                  width: badgeHeight,
                  height: badgeHeight,
                  child: style.showLottie
                    ? BreathingNeonWrapper(
                        isActive: true, 
                        glowAnimation: _activeAnimation,
                        glowColor: activeGlowColor,
                        customGlowChild: ColorFiltered(
                          colorFilter: ColorFilter.mode(activeGlowColor, BlendMode.srcIn),
                          child: Lottie.asset(
                            'assets/animations/fire.json',
                            width: badgeHeight,
                            height: badgeHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(style.iconColor, BlendMode.srcIn),
                          child: Lottie.asset(
                            'assets/animations/fire.json',
                            width: badgeHeight, 
                            height: badgeHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : Opacity(
                        opacity: style.iconOpacity,
                        child: BreathingNeonWrapper(
                          isActive: style.glowOpacity > 0,
                          glowAnimation: _activeAnimation,
                          glowColor: activeGlowColor,
                          customGlowChild: Icon(
                            Icons.local_fire_department,
                            color: activeGlowColor,
                            size: badgeHeight,
                          ),
                          child: Icon(
                            Icons.local_fire_department, 
                            color: style.iconColor, 
                            size: badgeHeight,
                          ),
                        ),
                      ),
                ),
                SizedBox(width: gap), 
              ],
              Text(
                "${widget.streak} 日連続",
                style: TextStyle(
                  color: style.textColor, 
                  fontWeight: style.textWeight, 
                  fontSize: fontSize,
                  height: 1.0, 
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  _StreakStyle _calculateStreakStyle() {
    Color textColor = Colors.grey;
    FontWeight textWeight = FontWeight.normal;
    Color containerColor = Colors.grey;
    Color iconColor = Colors.white; 
    double iconOpacity = 0.0; 
    double glowOpacity = 0.0;
    bool showLottie = false;

    double getT(double start, double end) => ((widget.streak - start) / (end - start)).clamp(0.0, 1.0);

    if (widget.streak >= 1) {
      textColor = Color.lerp(Colors.grey, Colors.white, getT(1, 5))!;
    }
    if (widget.streak >= 5) {
      textWeight = FontWeight.lerp(FontWeight.normal, FontWeight.bold, getT(5, 10))!;
    }
    if (widget.streak >= 10) {
      iconOpacity = getT(10, 20);
    }
    if (widget.streak >= 20) {
      containerColor = Color.lerp(Colors.grey, widget.streakColor, getT(20, 30))!;
    }
    if (widget.streak >= 30) {
      containerColor = Color.lerp(widget.streakColor, widget.timeColor, getT(30, 45))!;
    }
    if (widget.streak >= 45) {
      containerColor = Color.lerp(widget.timeColor, widget.charactersColor, getT(45, 60))!;
    }
    if (widget.streak >= 60) {
      iconColor = Color.lerp(Colors.white, widget.charactersColor, getT(60, 90))!;
    }
    if (widget.streak >= 90) {
      glowOpacity = getT(90, 180);
    }
    if (widget.streak >= 360) {
      showLottie = true;
    }

    return _StreakStyle(
      textColor: textColor,
      textWeight: textWeight,
      containerFill: containerColor.withValues(alpha: 0.15),
      containerBorder: containerColor.withValues(alpha: 0.5),
      iconColor: iconColor,
      iconOpacity: iconOpacity,
      glowOpacity: glowOpacity,
      showLottie: showLottie,
    );
  }
}

class _StreakStyle {
  final Color textColor;
  final FontWeight textWeight;
  final Color containerFill;
  final Color containerBorder;
  final Color iconColor;
  final double iconOpacity;
  final double glowOpacity;
  final bool showLottie;

  const _StreakStyle({
    required this.textColor,
    required this.textWeight,
    required this.containerFill,
    required this.containerBorder,
    required this.iconColor,
    required this.iconOpacity,
    required this.glowOpacity,
    required this.showLottie,
  });
}