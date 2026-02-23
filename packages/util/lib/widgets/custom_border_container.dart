import 'package:flutter/material.dart';

/// The specific type of line to draw
enum CustomBorderStyleTypes {
  none,
  solid,
  dashed
}

/// The bundle class holding the configuration for all 4 sides
class CustomBorderStyle {
  final CustomBorderStyleTypes left;
  final CustomBorderStyleTypes top;
  final CustomBorderStyleTypes right;
  final CustomBorderStyleTypes bottom;

  const CustomBorderStyle({
    this.left = CustomBorderStyleTypes.none,
    this.top = CustomBorderStyleTypes.none,
    this.right = CustomBorderStyleTypes.none,
    this.bottom = CustomBorderStyleTypes.none,
  });

  /// Helper to set all sides to the same type
  const CustomBorderStyle.all(CustomBorderStyleTypes type)
      : left = type,
        top = type,
        right = type,
        bottom = type;

  /// vital for your logic: allows you to modify just one side
  CustomBorderStyle copyWith({
    CustomBorderStyleTypes? left,
    CustomBorderStyleTypes? top,
    CustomBorderStyleTypes? right,
    CustomBorderStyleTypes? bottom,
  }) {
    return CustomBorderStyle(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}

class CustomBorderContainer extends StatelessWidget {
  final Widget child;
  final CustomBorderStyle border; // The bundled class
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  const CustomBorderContainer({
    super.key,
    required this.child,
    this.border = const CustomBorderStyle(), // Defaults to all none
    this.color = Colors.grey,
    this.strokeWidth = 1.5,
    this.dashLength = 4.0,
    this.dashSpace = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BorderPainter(
        border: border,
        color: color,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashSpace: dashSpace,
      ),
      child: child,
    );
  }
}

class _BorderPainter extends CustomPainter {
  final CustomBorderStyle border;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;

  _BorderPainter({
    required this.border,
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    void drawSide(Offset p1, Offset p2, CustomBorderStyleTypes type) {
      if (type == CustomBorderStyleTypes.none) return;

      if (type == CustomBorderStyleTypes.solid) {
        canvas.drawLine(p1, p2, paint);
      } else if (type == CustomBorderStyleTypes.dashed) {
        double distance = (p2 - p1).distance;
        double dx = p2.dx - p1.dx;
        double dy = p2.dy - p1.dy;
        double normX = dx / distance;
        double normY = dy / distance;
        double currentDist = 0.0;

        while (currentDist < distance) {
          double endDist = currentDist + dashLength;
          if (endDist > distance) endDist = distance;

          double x1 = p1.dx + normX * currentDist;
          double y1 = p1.dy + normY * currentDist;
          double x2 = p1.dx + normX * endDist;
          double y2 = p1.dy + normY * endDist;

          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
          currentDist += dashLength + dashSpace;
        }
      }
    }

    final topLeft = Offset(0, 0);
    final topRight = Offset(size.width, 0);
    final bottomLeft = Offset(0, size.height);
    final bottomRight = Offset(size.width, size.height);

    // Unpack the bundle here
    drawSide(topLeft, bottomLeft, border.left);
    drawSide(topLeft, topRight, border.top);
    drawSide(topRight, bottomRight, border.right);
    drawSide(bottomLeft, bottomRight, border.bottom);
  }

  @override
  bool shouldRepaint(covariant _BorderPainter oldDelegate) {
    return oldDelegate.border != border || oldDelegate.color != color;
  }
}