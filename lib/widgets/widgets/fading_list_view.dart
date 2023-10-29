// Flutter imports:
import 'package:flutter/material.dart';

class FadingListView extends StatefulWidget {
  const FadingListView({required this.child, super.key});

  final ListView child;

  @override
  State<FadingListView> createState() => _FadingListViewState();
}

class _FadingListViewState extends State<FadingListView> {
  double _stopStart = 0;
  double _stopEnd = 1;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        setState(() {
          _stopStart = scrollNotification.metrics.pixels / 10;
          _stopEnd = (scrollNotification.metrics.maxScrollExtent -
                  scrollNotification.metrics.pixels) /
              10;
          _stopStart = _stopStart.clamp(0.0, 1.0);
          _stopEnd = _stopEnd.clamp(0.0, 1.0);
        });
        return true;
      },
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: widget.child.scrollDirection == Axis.horizontal
                ? Alignment.centerLeft
                : Alignment.topCenter,
            end: widget.child.scrollDirection == Axis.horizontal
                ? Alignment.centerRight
                : Alignment.bottomCenter,
            colors: const [
              Colors.black,
              Colors.transparent,
              Colors.transparent,
              Colors.black
            ],
            stops: widget.child.reverse
                ? [0.0, 0.05 * _stopEnd, 1 - 0.05 * _stopStart, 1.0]
                : [0.0, 0.05 * _stopStart, 1 - 0.05 * _stopEnd, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: widget.child,
        ),
      ),
    );
  }
}
