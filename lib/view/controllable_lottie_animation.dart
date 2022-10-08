import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';



/// Widget for showing and controlling a lottie animation.
/// 
/// The animation can be controlled via 
/// `ControllableLottieAnimation.state.lottieAnimationController`
class ControllableLottieAnimation extends StatefulWidget {
  ControllableLottieAnimation(

  /// The path to the lottie animation to use
  this.lottieAnimPath,
  {
    Key? key,
  }) : super(key: key);

  /// the state of this lottie animation
  final _ControllableLottieAnimationState state = _ControllableLottieAnimationState();

  @override
  State<ControllableLottieAnimation> createState() => state;

  final String lottieAnimPath;
}

class _ControllableLottieAnimationState extends State<ControllableLottieAnimation> 
  with SingleTickerProviderStateMixin{

  late AnimationController lottieAnimationController;

  @override
  void initState() {
    super.initState();
    lottieAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    lottieAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.lottieAnimPath,
      //repeat: true
      controller: lottieAnimationController,
    );
  }

  void play() {
    lottieAnimationController.forward(from: 0.0);
  }
}