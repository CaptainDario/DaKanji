import 'package:flutter/material.dart';



class CutAndFadeLongWidgetWrapper extends StatelessWidget {

  /// The child widget to apply the fade effect to
  final Widget child;
  ///  The height to which the content is shown
  final double maxContentHeight;
  /// The percentage of the height (`maxContentHeight`) at which to start the fade effect
  final double fadeStartPercentage;
  /// Whether the fade effect is enabled
  final bool enabled;


  const CutAndFadeLongWidgetWrapper(
    {
      required this.child,
      required this.maxContentHeight,
      this.fadeStartPercentage = 0.7,
      this.enabled = true,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {

    if(!enabled) return child;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
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
          physics: const NeverScrollableScrollPhysics(),
          child: child
        )
      ),
    );
  }
}