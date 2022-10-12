import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';



/// Folding Cell Widget
/// 
/// A widget which can un-/fold a widget to transition to a different widget.
class FoldingWidget extends StatefulWidget {
  const FoldingWidget(
    {
      required this.unfoldedWidget,
      required this.unfoldedWidth,
      required this.unfoldedHeight,
      required this.foldedWidget,
      required this.foldedWidth,
      required this.foldedHeight,
      required this.animationController,
      this.unfolded = false,
      this.onOpen,
      this.onClose,
      this.backgroundColor = Colors.transparent,
      super.key
    }
  );

  // Widget that is shown when this widget is unfolded
  final Widget unfoldedWidget;
  // the width of the widget to fold
  final double unfoldedWidth;
  // the height of the widget to fold
  final double unfoldedHeight;
  /// Widget that is shown when this widget is folded
  final Widget foldedWidget;
  // the width of the widget to fold
  final double foldedWidth;
  // the height of the widget to fold
  final double foldedHeight;
  /// Controller to control the folding
  final AnimationController animationController;
  /// If true cell will be created in unfolded stat, otherwise in folded state
  final bool unfolded;
  /// The background color of this widget
  final Color backgroundColor;
  /// Called when cell fold animations completes
  final VoidCallback? onOpen;
  /// Called when cell unfold animations completes
  final VoidCallback? onClose;

  @override
  FoldingWidgetState createState() => FoldingWidgetState();
}

class FoldingWidgetState extends State<FoldingWidget> {

  final int noAnims = 7;
  /// List that contains all animations of this widget
  /// 
  /// A `FoldingWidget` is divided into a 3x3 grid, in this list there is one
  /// animation for each `FoldingWidgetSlice`. The indices of the list are used
  /// as show here: 
  /// 
  /// |   |   |   |
  /// |---|---|---|
  /// | 0 | 1 | 2 |
  /// | 4 |   | 5 |
  /// | 1 | 2 | 3 |
  final List<Animation> _animations = [];


  @override
  void initState() {
    super.initState();

    widget.animationController.value = widget.unfolded ? 1.0 : 0.0;
    
    for (var i = 0; i < noAnims; i++) {
      _animations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0
        ).animate( CurvedAnimation(
          parent: widget.animationController,
          curve: Interval(
            1 / noAnims * i, 
            1 / noAnims * (i+1), 
            curve: Curves.easeInOutCubic
          )
        ))
      );
    }

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onClose != null) {
          widget.onClose!();
        }
      }
      else if (status == AnimationStatus.dismissed) {
        if (widget.onOpen != null) {
          widget.onOpen!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 1000 ~/ noAnims),
          transitionBuilder: (child, animation) => Transform(
            transform: Matrix4.rotationY((1 - animation.value) * pi),
            alignment: Alignment.center,
            //child: ScaleTransition(
            //  scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child
              )
            //),
          ),
          child: (widget.animationController.value < (1 / noAnims) * 6 &&
          widget.animationController.status == AnimationStatus.forward ||
          widget.animationController.status == AnimationStatus.dismissed) ||
          
          widget.animationController.value < 1 &&
          widget.animationController.status == AnimationStatus.reverse
          ? 
            Stack(
              children: [
                // 1, 1 -> 4
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 1,
                  y: 1,
                  rotationX: 0,
                  rotationXAlign: Alignment.center,
                  rotationY: 0,
                  rotationYAlign: Alignment.center,
                  widget: widget.unfoldedWidget,
                ),
                // 1, 0 -> 1
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 1,
                  y: 0,
                  rotationX: _animations[1].value,
                  rotationXAlign: Alignment.bottomCenter,
                  rotationY: 0,
                  rotationYAlign: Alignment.centerRight,
                  widget: widget.unfoldedWidget,
                ),
          
                // 1, 2 -> 7
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 1,
                  y: 2,
                  rotationX: _animations[2].value,
                  rotationXAlign: Alignment.topCenter,
                  rotationY: 0,
                  rotationYAlign: Alignment.center,
                  widget: widget.unfoldedWidget,
                ),
          
                // 0, 1 -> 3
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 0,
                  y: 1,
                  rotationX: 0,
                  rotationXAlign: Alignment.center,
                  rotationY: _animations[4].value,
                  rotationYAlign: Alignment.centerRight,
                  widget: widget.unfoldedWidget,
                ),
                // 0, 0 -> 0
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 0,
                  y: 0,
                  rotationX: _animations[0].value,
                  rotationXAlign: Alignment.bottomCenter,
                  rotationY: _animations[4].value,
                  rotationYAlign: Alignment.centerRight,
                  widget: widget.unfoldedWidget,
                ),
                // 0, 2 -> 6
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 0,
                  y: 2,
                  rotationX: _animations[1].value,
                  rotationXAlign: Alignment.topCenter,
                  rotationY: _animations[4].value,
                  rotationYAlign: Alignment.centerRight,
                  widget: widget.unfoldedWidget,
                ),            
                
                // 2, 1 -> 5
                FoldingWidgetSlice(
                  height: widget.unfoldedHeight,
                  width: widget.unfoldedWidth,
                  x: 2,
                  y: 1,
                  rotationX: 0,
                  rotationXAlign: Alignment.center,
                  rotationY: _animations[5].value,
                  rotationYAlign: Alignment.centerLeft,
                  widget: widget.unfoldedWidget,
                ),
                // 2, 0 -> 2
                if(_animations[5].value == 0)
                  FoldingWidgetSlice(
                    height: widget.unfoldedHeight,
                    width: widget.unfoldedWidth,
                    x: 2,
                    y: 0,
                    rotationX: _animations[2].value,
                    rotationXAlign: Alignment.bottomCenter,
                    rotationY: _animations[5].value,
                    rotationYAlign: Alignment.centerLeft,
                    widget: widget.unfoldedWidget,
                  ),
                // 2, 2 -> 8
                if(_animations[5].value <= 0.5)
                  FoldingWidgetSlice(
                    height: widget.unfoldedHeight,
                    width: widget.unfoldedWidth,
                    x: 2,
                    y: 2,
                    rotationX: _animations[3].value,
                    rotationXAlign: Alignment.topCenter,
                    rotationY: _animations[5].value,
                    rotationYAlign: Alignment.centerLeft,
                    widget: widget.unfoldedWidget,
                  ),
              ],
            )
            : Center(
              child: SizedBox(
                width: widget.foldedWidth,
                height: widget.foldedHeight,
                child: widget.foldedWidget
              ),
            ),
        );
      }
    );
  }
}

/// One slice of a `FoldingWidget`.
/// 
/// A `FoldingWidget` is cut in a 3x3 grid for the folding animation. This
/// helper Widget is one slice (or cell) of this 3x3 grid.
class FoldingWidgetSlice extends StatelessWidget{

  const FoldingWidgetSlice(
    {
      required this.height,
      required this.width,
      required this.x,
      required this.y,
      required this.widget,
      required this.rotationX,
      required this.rotationXAlign,
      required this.rotationY,
      required this.rotationYAlign,
      super.key
    }
  );

  /// Height of the unfolded widget
  final double height;
  /// Width of the unfolded widget
  final double width;
  /// Which horizontal part of the widget this cell belongs to (valid 0..2)
  final int x;
  /// Which vertical part of the widget this cell belongs to (valid 0..2)
  final int y;
  /// The current x-rotation of this slice in radians 
  final double rotationX;
  /// Around which point this should rotate in x direction
  final Alignment rotationXAlign;
  /// The current y-rotation of this slice in radians
  final double rotationY;
  /// Around which point this should rotate in y direction
  final Alignment rotationYAlign;

  final Widget widget;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width / 3 * x,
      top: height / 3 * y,
      child: Transform(
        alignment: rotationXAlign,
        transform: Matrix4.rotationX(rotationX * pi),
        child: Transform(
          alignment: rotationYAlign,
          transform: Matrix4.rotationY(rotationY * pi),
          child: ClipRect(
            child: Align(
              alignment: Alignment.center,
              heightFactor: 1/3,
              widthFactor: 1/3,
              child: Transform.translate(
                offset: Offset(
                  width/3  * ((-x)+1),
                  height/3 * ((-y)+1),
                ),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: widget
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}