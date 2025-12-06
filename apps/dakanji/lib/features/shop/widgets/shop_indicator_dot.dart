import 'package:flutter/material.dart';

class IndicatorDot extends StatelessWidget {
  final bool isActive;
  final bool isSmall;

  const IndicatorDot({
    super.key,
    required this.isActive,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final double activeWidth = isSmall ? 16.0 : 24.0;
    final double inactiveWidth = isSmall ? 6.0 : 8.0;
    final double height = isSmall ? 3.0 : 4.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: height,
      width: isActive ? activeWidth : inactiveWidth,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey[800],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}