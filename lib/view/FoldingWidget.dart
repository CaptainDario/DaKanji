import 'dart:typed_data';
import 'dart:math';

import 'package:flutter/material.dart';



/// Folding Cell Widget
/// 
/// A widget which can fold /unfold a widget to transition to a different widget.
class FoldingWidget extends StatefulWidget {
  FoldingWidget(
      this.outerWidget,
      this.innerWidget,
      this.foldingKey,
      this.width,
      this.height,
      {this.unfoldCell = false,
      this.foldingColor = Colors.white,
      this.animationDuration = const Duration(milliseconds: 2000),
      this.onOpen,
      this.onClose}) : super(key: foldingKey);

  // Front widget in folded cell
  final Widget outerWidget;

  /// Inner widget in unfolded cell
  final Widget innerWidget;
  
  // the global key of this widget
  final GlobalKey foldingKey;
  // the color when the widget folds
  final Color foldingColor;
  // the width of the widget to fold
  final double width;
  // the height of the widget to fold
  final double height;

  /// If true cell will be unfolded when created, if false cell will be folded when created
  final bool unfoldCell;

  /// Animation duration
  final Duration animationDuration;

  /// Called when cell fold animations completes
  final VoidCallback onOpen;

  /// Called when cell unfold animations completes
  final VoidCallback onClose;


  @override
  FoldingWidgetState createState() => FoldingWidgetState();
}

class FoldingWidgetState extends State<FoldingWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isUnfolded = true;
  
  AnimationController _animationController;
  Animation _animation1;
  Animation _animation2;
  Animation _animation3;
  Animation _animation4;

  Uint8List innerWidgetImage;


  @override
  void initState() {
    super.initState();
  
    _animationController =
      AnimationController(vsync: this, duration: widget.animationDuration);
    // vertical fold
    _animation1 = Tween<double>(
      begin: 0.0,
      end: 1.0
    ).animate( CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.25, curve: Curves.ease)
    ));
    _animation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate( CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.25, 0.5, curve: Curves.ease)
    ));
    // horizontal fold
    _animation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate( CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.5, 0.75, curve: Curves.ease)
    ));
    _animation4 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate( CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.75, 1.0, curve: Curves.ease)
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onClose != null)
          widget.onClose();
      }
      else if (status == AnimationStatus.dismissed) {
        if (widget.onOpen != null)
          widget.onOpen();
        // mark the folding widget as completely unfolded
        setState(() {
          _isUnfolded = true;
        });
      }
    });

    if (widget.unfoldCell == true) {
      _animationController.value = 1;
      _isExpanded = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {

      int folds = 5;
      double cellHeight = widget.height / folds;
      double cellWidth  = widget.width  / folds;

      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: () {
          if(!_isUnfolded)
            return verticalFold(cellHeight, cellWidth, folds);
          else
            return widget.innerWidget;
        } (),
      );
      }
    );
  }

  Widget verticalFold(double cellHeight, double cellWidth, int folds){
    return Stack(
      children: [
        // middle part of the image which stays in place
        Positioned(
          top: cellHeight*2,
          child: horizontalFold(cellHeight, cellWidth, folds) 
        ),
        Positioned(
          top: cellHeight,
          child: innerSliceVertical(2,
            hFactor: 1/folds,
            bottomCard: false,
          ),
        ),
        Positioned(
          top: 0,
          child: outerSliceVertical(
            cellHeight, widget.width, 1,
            hFactor: 1/folds,
            bottomCard: false
          ),
        ),
        // 4th slice
        Positioned(
          top: cellHeight*3,
          child: innerSliceVertical(4,
            hFactor: 1/folds
          ),
        ),
        // 5th slice
        Positioned(
          top: cellHeight*4,
          child: outerSliceVertical(
            cellHeight, widget.width, 5,
            hFactor: 1/folds
          ),
        )
      ],
    );
  }

  Widget horizontalFold(double cellHeight, double cellWidth, int folds){
      
    // if the vertical folding did not finish
    if(_animation2.value < 1.0)
      return ClipRect(
        child: Transform.translate(
          offset: Offset(0, -2*cellHeight),
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1/folds,
            child: widget.innerWidget
          ),
        ),
      );
    // after the vertical folding fold the widget horizontally 
    else
      return SizedBox(
        height: cellHeight,
        width: widget.width,
        child: Stack(
          children: [
            Positioned(
              left: 2*cellWidth,
              child: () { 
                if(_animation4.value < 1.0)
                  return Container(
                    width: cellWidth,
                    height: cellHeight,
                    color: widget.foldingColor 
                  );
                else
                  return Container(
                    width: cellWidth,
                    height: cellHeight,
                    color: widget.foldingColor
                  );
              } ()
            ),
            Positioned(
              left: 0,
              child: outerSliceHorizontal(cellHeight, cellWidth),
            ),
            Positioned(
              left: cellWidth,
              child: innerSliceHorizontal(cellHeight, cellWidth)
            ),
            Positioned(
              left: cellWidth * 4,
              child: outerSliceHorizontal(cellHeight, cellWidth, leftCell: false),
            ),
            Positioned(
              left: cellWidth * 3,
              child: innerSliceHorizontal(cellHeight, cellWidth, leftCell: false)
            ),
          ]
        ),
      );
  }

  Widget innerWidget(double height, double width){
    return Transform(
      transform: new Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(-_animation4.value * pi),
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: width,
        height: height,
        child: widget.outerWidget
      )
    );
  }

  Widget outerSliceHorizontal(double height, double width, 
    {bool leftCell = true}){
    return Transform(
      transform: new Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY((leftCell ? -1 : 1) * _animation3.value * pi),
      alignment: leftCell 
        ? Alignment.centerRight
        : Alignment.centerLeft,
      child: Visibility(
        visible: _animation3.value < 1.0,
        child: Container(
          width: width,
          height: height,
          color: widget.foldingColor,
        )
      ),
    );
  }
  
  Widget innerSliceHorizontal(double height, double width, 
    {bool leftCell = true}){
    return Transform(
      transform: new Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY((leftCell ? -1 : 1) * _animation4.value * pi),
      alignment: leftCell 
        ? Alignment.centerRight
        : Alignment.centerLeft,
      child:  ()
      {
        if(_animation4.value < 0.5 || leftCell)
          return Container(
            width: width,
            height: height,
            color: widget.foldingColor,
          );
        else
          return SizedBox(
            width: width,
            height: height,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: widget.outerWidget
            ),
          );
      } ()
    );
  }

  Widget innerSliceVertical(int sliceNumber,
    {double hFactor = 1.0, double wFactor = 1.0, bool bottomCard = true}){

    return Opacity(
      opacity: _animation2.value < 1.0 ? 1.0 : 0.0,
      child: Transform(
        transform: new Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX((bottomCard ? -1 : 1) * _animation2.value * pi),
        alignment: bottomCard
          ? Alignment.topCenter
          : Alignment.bottomCenter,
        child: Stack(
          children: [
            // outer
            Visibility(
              visible: _animation2.value > 0.0,
              child: () { 
                return Container(
                  width: widget.width * wFactor,
                  height: widget.height * hFactor,
                  color: widget.foldingColor,
                );
              } ()
            ),
            Visibility(
              visible: _animation1.value < 1.0,
              child: ClipRect(
                child: Transform.translate(
                  offset: Offset(0.0, -(sliceNumber-1)*(widget.height*hFactor)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: hFactor,
                    widthFactor: wFactor,
                    child: widget.innerWidget 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget outerSliceVertical(double height, double width, int sliceNumber, 
    {double hFactor = 1.0, double wFactor = 1.0, bool bottomCard = true}){

    return Opacity(
      opacity: _animation1.value < 1.0 ? 1.0 : 0.0,
      child: Transform(
        transform: new Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX((bottomCard ? -1 : 1) * _animation1.value * pi),
        alignment: bottomCard 
          ? Alignment.topCenter
          : Alignment.bottomCenter,
        child: Stack(
          children: [
            // inner
            Visibility(
              visible: _animation1.value < 0.5,
              child: ClipRect(
                child: Transform.translate(
                  offset: Offset(0, -(sliceNumber-1)*height),
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: hFactor,
                    widthFactor: wFactor,
                    child: widget.innerWidget 
                  ),
                ),
              ),
            ),
            // outer 
            Visibility(
              visible: _animation1.value > 0.5,
              child: Container(
                width: width,
                height: height,
                color: widget.foldingColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleFold() async{

    if (_isExpanded) {
      _animationController.reverse();
    } 
    else {
      _animationController.forward();
      _isUnfolded = false;
    }
    _isExpanded = !_isExpanded;
  }
}

bool isInRange(double lower, double upper, double value){

  if(value > lower && value < upper)
    return true;
  else 
    return false;

}