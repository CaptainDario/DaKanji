import 'package:flutter/material.dart';



class AnimatedFilterChip extends StatefulWidget {
  final String filter;
  final VoidCallback onDeleted;

  const AnimatedFilterChip({
    super.key,
    required this.filter,
    required this.onDeleted,
  });

  @override
  State<AnimatedFilterChip> createState() => _AnimatedFilterChipState();
}

class _AnimatedFilterChipState extends State<AnimatedFilterChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 1.0,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut
      ),
      axis: Axis.horizontal, 
      child: FadeTransition(
        opacity: _controller,
        child: InputChip(
          label: Text(widget.filter),
          onDeleted: () async {
            await _controller.reverse();
            widget.onDeleted();
          },
        ),
      ),
    );
  }
}