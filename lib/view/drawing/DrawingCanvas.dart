import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/provider/drawing/Strokes.dart';
import 'package:da_kanji_mobile/view/drawing/DrawingPainter.dart';



class DrawingCanvas extends StatefulWidget {

  /// the width of the DrawingCanvas 
  final double width;
  /// the height of the DrawingCanvas 
  final double height;
  /// the margins around the DrawingCanvas 
  final EdgeInsets margin;
  /// the Strokes which should be drawn on the canvas
  final Strokes strokes;
  /// is invoked once a stroke was drawn (pointerUp)
  /// 
  /// Provides the current image of the canvas as parameter
  final void Function(Uint8List image)? onFinishedDrawing;
  /// is invoked when the delete last stroke animation finished
  /// 
  /// Provides the current image of the canvas as parameter
  final void Function(Uint8List image)? onDeletedLastStroke;
  /// is invoked when the 'delete all strokes animation' finished
  final void Function()? onDeletedAllStrokes;


  DrawingCanvas(
    this.width,
    this.height,
    this.strokes,
    this.margin,
    Key key,
    {
    this.onFinishedDrawing,
    this.onDeletedLastStroke,
    this.onDeletedAllStrokes
  }) : super(key: key);

  @override
  _DrawingCanvasState createState() => _DrawingCanvasState();
    
}

class _DrawingCanvasState extends State<DrawingCanvas> 
  with TickerProviderStateMixin {
  
  /// the DrawingPainter instance which defines the canvas to drawn on.
  late DrawingPainter _canvas;
  /// the ID of the pointer which is currently drawing
   int? _pointerID;
  /// Keep track of if the pointer moved
  bool pointerMoved = false;
  /// Animation controller of the delete stroke animation
  late AnimationController _canvasController;
  /// should the app run in dark mode.
  late bool darkMode;
  /// if the animation to delete the last stroke is currently running
  bool deletingLastStroke = false;
  /// if the animation to delete all strokes is currently running
  bool deletingAllStrokes = false;
    


  @override
  void initState() { 
    super.initState();
    // delete last stroke / clear canvas animation
    _canvasController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );
    _canvasController.value = 1.0;
    
    _canvasController.addStatusListener((status) async {
      // when the animation finished 
      if(status == AnimationStatus.dismissed){
        if(deletingLastStroke){
          widget.strokes.removeLastStroke();
          deletingLastStroke = false;
          _canvasController.value = 1.0;

          // execute the callback once the stroke was deleted
          if(widget.onDeletedLastStroke != null){

            _canvas = DrawingPainter(
              widget.strokes.path, 
              darkMode, Size(widget.width, widget.height),
              1.0
            );

            widget.onDeletedLastStroke!(await _canvas.getPNGListFromCanvas());
          }
        }

        if(deletingAllStrokes){
          widget.strokes.removeAllStrokes();
          deletingAllStrokes = false;
          _canvasController.value = 1.0;
          
          // execute the callback once all strokes were deleted
          if(widget.onDeletedAllStrokes != null){
            widget.onDeletedAllStrokes!();
          }
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // set dark / light mode
    darkMode = (Theme.of(context).brightness == Brightness.dark);
    // progress of deleting last stroke when clearing the whole canvas called
    double currentDeleteLastprogress = 1.0;

    // handle all cases how the delete animations could be triggered
    handleDeleteLastAnimation();
    if(widget.strokes.playDeleteAllStrokesAnimation){
      widget.strokes.playDeleteAllStrokesAnimation = false;

      currentDeleteLastprogress = _canvasController.value;
      _canvasController.reverse(from: 1.0);

      deletingAllStrokes = true;
      deletingLastStroke = false;
    }
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: Listener(
        // started drawing
        onPointerDown: (details) async {
          // finish deleting stroke(s) when user starts drawing
          if(deletingLastStroke){
            widget.strokes.removeLastStroke();
            _canvasController.value = 1.0;
            deletingLastStroke = false;
          }
          if(deletingAllStrokes){
            widget.strokes.removeAllStrokes();
            _canvasController.value = 1.0;
            deletingAllStrokes = false;
          }

          // allow only one pointer at a time
          if(_pointerID == null){
            _pointerID = details.pointer;
            Offset point = details.localPosition / widget.height;
            widget.strokes.moveTo(point.dx, point.dy);
          }
        },
        // drawing pointer moved
        onPointerMove: (details) {
          // allow only one pointer at a time
          if(_pointerID == details.pointer){
            Offset point = details.localPosition / widget.height;
            widget.strokes.lineTo(point.dx, point.dy);
            pointerMoved = true;
          }
        },
        // finished drawing a stroke
        onPointerUp: (details) async {
          if(pointerMoved){
            pointerMoved = false;
            widget.strokes.incrementStrokeCount();

            if(widget.onFinishedDrawing != null){
              widget.onFinishedDrawing!(await getPNGImage());
            }
          }
          // mark this pointer as removed
          _pointerID = null;
        },
        child: Stack(
          children: [
            Image(image: 
              AssetImage("assets/kanji_drawing_aid.png")
            ),
            AnimatedBuilder(
              animation: _canvasController,
              builder: (BuildContext context, Widget? child) {
                _canvas = DrawingPainter(
                  widget.strokes.path, 
                  darkMode, Size(widget.width, widget.height),
                  deletingLastStroke ? 
                    _canvasController.value : currentDeleteLastprogress
                );
                Widget canvas = CustomPaint(
                    size: Size(widget.width, widget.height),
                    painter: _canvas,
                );

                if(deletingAllStrokes)
                  return Opacity(
                    opacity: _canvasController.value,
                    child: canvas
                  );
                else 
                  return canvas;
              }
            ),
          ],
        )
      ),
    );
  }

  /// convenience wrapper for getting a PNG-image as list of the current canvas.
  Future<Uint8List> getPNGImage() async {
    return _canvas.getPNGListFromCanvas();
  } 
  
  /// convenience wrapper for getting a RGBA-list of the current canvas.
  Future<Uint8List> getRGBAImage() async {
    return _canvas.getRGBAListFromCanvas();
  } 

  /// Handle all cases how the DeleteLastAnimation could be triggered
  void handleDeleteLastAnimation() async {
    if(widget.strokes.playDeleteLastStrokeAnimation && !deletingAllStrokes){
      widget.strokes.playDeleteLastStrokeAnimation = false;
      
      // start deleting the last stroke if the animation is not already running
      if(!deletingLastStroke){
        _canvasController.reverse(from: 1.0); 
        deletingLastStroke = true;
      }
      // if the animation is already running delete a stroke
      else if(deletingLastStroke && widget.strokes.strokeCount > 0){
        widget.strokes.removeLastStroke();
        _canvasController.reverse(from: 1.0);
        
        // and stop the animation if it was the last stroke
        if(widget.strokes.strokeCount == 0){
          deletingLastStroke = false;
          _canvasController.value = 1.0;
        }
      }
    }
  }

}