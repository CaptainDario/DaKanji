import 'package:flutter/material.dart';
import 'dart:math' as math;



class NeonStopwatchPainter extends CustomPainter {
  final double progress;
  final int lapIndex;
  final Color activeColor;
  final Color trackColor;
  final double knobRadius;
  final double glowOpacity;

  NeonStopwatchPainter({
    required this.progress,
    required this.lapIndex,
    required this.activeColor,
    required this.trackColor,
    this.knobRadius = 8.0,
    this.glowOpacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - knobRadius;
    const strokeWidth = 12.0;

    const startAngle = -math.pi / 2;
    final currentAngle = startAngle + (2 * math.pi * progress);

    // ===========================================
    // MODE: 3+ LOOPS (Infinite Trail)
    // ===========================================
    if (lapIndex >= 2) {
      canvas.save();
      // Rotate canvas so 0.0 radians aligns with the knob
      canvas.translate(center.dx, center.dy);
      canvas.rotate(currentAngle); 
      canvas.translate(-center.dx, -center.dy);

      // FADE LOGIC:
      // The "Gap" (transparency) should be IN FRONT of the knob.
      // So at 0.0 (Knob), it should be Transparent (or fading to it).
      // On Lap 3, transition this "Gap" from Solid to Transparent smoothly.
      
      double gapOpacity;
      if (lapIndex > 2) {
        // Lap 4+: The gap in front is fully transparent (Dark).
        gapOpacity = 0.0;
      } else {
        // Lap 3: The gap fades from Solid (1.0) to Transparent (0.0)
        // as the knob travels the first 180 degrees.
        gapOpacity = (1.0 - (progress * 2.0)).clamp(0.0, 1.0);
      }

      final gradientPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          center: Alignment.center,
          colors: [
            // Start (At Knob, 0.0): Transparent (The Gap)
            activeColor.withValues(alpha: gapOpacity), 
            
            // Middle (Forward, 0.25): Fades into Solid Orange
            activeColor,                        
            
            // End (Behind Knob, 1.0): Solid Orange
            activeColor,                        
          ],
          // The fade happens in the first 25% of the circle (Forward from knob)
          stops: const [0.0, 0.25, 1.0], 
          tileMode: TileMode.clamp,
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, gradientPaint);
      canvas.restore();
    } 
    // ===========================================
    // MODE: NORMAL (Loops 1 & 2)
    // ===========================================
    else {
      // Background
      final trackPaint = Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, radius, trackPaint);

      // Active Arc
      final activePaint = Paint()
        ..color = activeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        2 * math.pi * progress,
        false,
        activePaint,
      );
    }

    // ===========================================
    // KNOB RENDERING
    // ===========================================
    final knobX = center.dx + radius * math.cos(currentAngle);
    final knobY = center.dy + radius * math.sin(currentAngle);
    final knobCenter = Offset(knobX, knobY);

    if (glowOpacity > 0.01) {
      final glowPaint = Paint()
        ..color = activeColor.withValues(alpha: glowOpacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
      canvas.drawCircle(knobCenter, knobRadius + 4, glowPaint);
    }

    final corePaint = Paint()..color = activeColor;
    canvas.drawCircle(knobCenter, knobRadius, corePaint);

    final HSLColor hsl = HSLColor.fromColor(activeColor);
    final Color restingOutline = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();
    final Color activeOutline = hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0)).toColor();
    final Color currentOutline = Color.lerp(restingOutline, activeOutline, glowOpacity)!;

    final outlinePaint = Paint()
      ..color = currentOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(knobCenter, knobRadius, outlinePaint);

    if (glowOpacity > 0.01) {
      final whiteCenterPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.9 * glowOpacity);
      canvas.drawCircle(knobCenter, knobRadius * 0.4, whiteCenterPaint);
    }
  }

  @override
  bool shouldRepaint(covariant NeonStopwatchPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.lapIndex != lapIndex ||
        oldDelegate.glowOpacity != glowOpacity;
  }
}