// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FadingSingleChildScrollView extends StatefulWidget {
  
  /// How much of the visible area should be faded away is clamped to range [0, 1]
  final double fadePercentage;

  const FadingSingleChildScrollView(
    {
      required this.child,
      required this.fadePercentage,
      super.key
    }
  );

  final SingleChildScrollView child;

  @override
  State<FadingSingleChildScrollView> createState() => _FadingSingleChildScrollViewState();
}

class _FadingSingleChildScrollViewState extends State<FadingSingleChildScrollView> {
  
  double _stopStart = 0;
  double _stopEnd = 1;
  late final double fadePercentage;

  @override
  void initState() {
    fadePercentage = clampDouble(widget.fadePercentage, 0.0, 1.0);
    super.initState();
  }


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
                ? [0.0, fadePercentage * _stopEnd  , 1 - fadePercentage * _stopStart, 1.0]
                : [0.0, fadePercentage * _stopStart, 1 - fadePercentage * _stopEnd  , 1.0],
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
