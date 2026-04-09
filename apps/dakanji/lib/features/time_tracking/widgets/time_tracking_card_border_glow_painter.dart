import 'dart:math' as math;

import 'package:flutter/material.dart';



class CardBorderGlowPainter extends CustomPainter {
  final double progress;
  final int lapIndex;
  final Color activeColor;
  final Color trackColor;

  CardBorderGlowPainter({
    required this.progress,
    required this.lapIndex,
    required this.activeColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Initial Check: Don't paint if we haven't started yet (and it's the first lap)
    if (progress <= 0.001 && lapIndex < 2) return;

    final rect = Offset.zero & size;
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(40));

    List<Color> colors;
    List<double> stops;
    GradientRotation rotation;

    // ===============================================
    // MODE: 3+ LOOPS (Infinite Rotating Spotlight)
    // ===============================================
    if (lapIndex >= 2) {
      // 1. Define colors to create a "Spotlight" effect
      // Base: 40% Opacity Orange (Keeps the card glowing, no "reset" to black)
      // Highlight: 100% Opacity Orange (The "slight extend" near the knob)
      final Color baseGlow = activeColor.withValues(alpha: 0.4);
      final Color highlightGlow = activeColor;

      colors = [baseGlow, highlightGlow, baseGlow];
      
      // 2. Position the highlight in the middle of the gradient (at 0.5)
      stops = [0.0, 0.5, 1.0];

      // 3. Calculate Rotation
      // The gradient highlight is defined at 0.5 (180 degrees / 9 o'clock).
      // We need to rotate it to match the Knob (which starts at 12 o'clock).
      // 9 o'clock -> 12 o'clock is +90 degrees (+pi/2).
      // Then we add the current progress rotation.
      final double currentRotation = (2 * math.pi * progress) + (math.pi / 2);
      rotation = GradientRotation(currentRotation);
    } 
    // ===============================================
    // MODE: NORMAL (Growing Loop 1 & 2)
    // ===============================================
    else {
      const double smooth = 0.05;
      final double safeProgress = progress.clamp(0.0, 0.99);
      
      colors = [trackColor, activeColor, activeColor, trackColor, trackColor];
      
      stops = [
        0.0,
        0.02,
        safeProgress, 
        (safeProgress + smooth).clamp(0.0, 1.0), 
        1.0
      ];
      
      // Standard start position (-90 degrees / 12 o'clock)
      rotation = const GradientRotation(-math.pi / 2);
    }

    final paint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        transform: rotation, 
        colors: colors,
        stops: stops,
        tileMode: TileMode.clamp,
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CardBorderGlowPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.lapIndex != lapIndex;
  }
}