import 'package:flutter/material.dart';



class FadeLongWidgetWrapper extends StatelessWidget {

  /// The child widget to apply the fade effect to
  final Widget child;
  ///  The height to which the content is shown
  final double maxContentHeight;
  /// The percentage of the height (`maxContentHeight`) at which to start the fade effect
  final double fadeStartPercentage;


  const FadeLongWidgetWrapper(
    {
      required this.child,
      this.maxContentHeight = 70,
      this.fadeStartPercentage = 0.8,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {

    return ClipRect(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxContentHeight,
        ),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white, Colors.transparent],
              stops: [0.0, fadeStartPercentage, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              child: child
            )
          )
        ),
      ),
    );
  }
}