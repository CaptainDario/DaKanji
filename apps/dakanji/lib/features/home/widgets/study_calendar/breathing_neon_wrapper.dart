import 'dart:ui'; // Required for ImageFilter
import 'package:flutter/material.dart';

/// Reusable wrapper that applies the specific "Breathing Neon" effect
/// derived from your StudyCard implementation.
class BreathingNeonWrapper extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final bool isActive;
  final Animation<double> glowAnimation;

  // Optional: Used if you need to override the glow shape (e.g. for icons vs text)
  // but mostly the child shape defines the blur shape naturally.
  final Widget? customGlowChild;

  const BreathingNeonWrapper({
    super.key,
    required this.child,
    required this.glowColor,
    required this.isActive,
    required this.glowAnimation,
    this.customGlowChild,
  });

  @override
  Widget build(BuildContext context) {
    if (!isActive) return child;

    return AnimatedBuilder(
      animation: glowAnimation,
      builder: (context, _) {
        final double opacity = glowAnimation.value.clamp(0.0, 1.0);

        // If customGlowChild is not provided, use the child itself
        // as the source mask for the blur.
        final Widget glowSource = customGlowChild ?? child;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Wide Atmospheric Glow (Sigma 6, 50% Opacity)
            Opacity(
              opacity: (opacity * 0.5).clamp(0.0, 1.0),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(glowColor, BlendMode.srcIn),
                  child: glowSource,
                ),
              ),
            ),

            // Tight Intense Glow (Sigma 2, 100% Opacity)
            Opacity(
              opacity: opacity,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(glowColor, BlendMode.srcIn),
                  child: glowSource,
                ),
              ),
            ),

            // Sharp Child (Top)
            child,
          ],
        );
      },
    );
  }
}