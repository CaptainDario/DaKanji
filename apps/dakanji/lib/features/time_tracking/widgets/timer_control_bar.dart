import 'package:flutter/material.dart';

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
        label: const Text("Start"),
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
        label: const Text("Resume"),
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
        key: const ValueKey("pause_btn"),
        onPressed: onPause,
        icon: const Icon(Icons.pause, size: 20),
        label: const Text("Pause"),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _OptionButton(
          icon: Icons.category_outlined,
          onTap: () {},
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: centerButton,
        ),
        _OptionButton(
          icon: Icons.tag_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _OptionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon),
        color: Colors.grey,
        tooltip: "Option",
      ),
    );
  }
}