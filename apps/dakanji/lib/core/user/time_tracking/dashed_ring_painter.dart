import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedDashedStopwatchPainter extends CustomPainter {
  final Color color;
  final double progress; // 0.0 to 1.0 (Rotation position)
  final int dashCount;

  AnimatedDashedStopwatchPainter({
    required this.color,
    required this.progress,
    this.dashCount = 30, // Standard 60 ticks for a clock look
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Align radius with your NeonPainter (size.width/2 - knobRadius - extra padding)
    final radius = (size.width / 2) - 8.0; 
    
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final double dashAngle = (2 * math.pi) / dashCount;
    final double gap = 0.4; // 40% gap between dashes

    // The precise float position of the highlight head (0.0 to 60.0)
    // This allows the highlight to exist "between" dashes for smooth movement
    final double currentPos = progress * dashCount;
    
    // How wide the glow is (in dash units)
    // A spread of 6 means the light fades out over 6 dashes on either side
    const double fadeSpread = 3.0; 

    for (int i = 0; i < dashCount; i++) {
      // Calculate continuous distance from the current highlight position.
      double dist = (currentPos - i).abs();
      
      // Handle wrap-around (shortest distance on the circle)
      // e.g., distance between index 0 and index 59 is 1, not 59
      if (dist > dashCount / 2) {
        dist = dashCount - dist;
      }

      double opacity = 0.1; // Base dim opacity for inactive dashes
      
      if (dist < fadeSpread) {
        // Calculate intensity based on how close the dash is to the "center" of the light
        // dist 0.0 (Center) -> Intensity 1.0
        // dist 6.0 (Edge)   -> Intensity 0.0
        double intensity = 1.0 - (dist / fadeSpread);
        
        // Map intensity to actual opacity range (0.1 to 1.0)
        opacity = 0.1 + (0.9 * intensity);
      }

      // Clamp ensures we stay within valid alpha bounds
      opacity = opacity.clamp(0.0, 1.0);

      paint.color = color.withValues(alpha: opacity);

      // -pi/2 to start drawing at 12 o'clock
      final double startAngle = (i * dashAngle) - (math.pi / 2);
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashAngle * (1 - gap),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AnimatedDashedStopwatchPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}