import 'dart:typed_data';

import 'package:da_kanji_mobile/view/drawing/canvas_snappable.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:da_kanji_mobile/provider/settings.dart';
import 'package:da_kanji_mobile/provider/drawing/strokes.dart';
import 'package:da_kanji_mobile/view/drawing/drawing_painter.dart';
import 'package:da_kanji_mobile/model/DrawScreen/draw_screen_state.dart';
import 'package:da_kanji_mobile/locales_keys.dart';



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


  const DrawingCanvas(
    this.width,
    this.height,
    this.strokes,
    this.margin,
    {
      this.onFinishedDrawing,
      this.onDeletedLastStroke,
      this.onDeletedAllStrokes,
      Key? key, 
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
  /// Keep track of, if the pointer moved
  bool pointerMoved = false;
  /// Animation controller of the delete stroke animation
  late AnimationController _canvasController;
  /// should the app run in dark mode.
  late bool darkMode;
    


  @override
  void initState() { 
    super.initState();
    // delete last stroke / clear canvas animation
    _canvasController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );
    _canvasController.value = 1.0;
    
    _canvasController.addStatusListener((status) async {
      // when the animation finished 
      if(status == AnimationStatus.dismissed){
        if(GetIt.I<DrawScreenState>().strokes.deletingLastStroke){
          widget.strokes.removeLastStroke();
          GetIt.I<DrawScreenState>().strokes.deletingLastStroke = false;
          _canvasController.value = 1.0;

          // execute the callback once the stroke was deleted
          if(widget.onDeletedLastStroke != null){

            _canvas = DrawingPainter(
              widget.strokes.path, 
              darkMode, Size(widget.width, widget.height),
              1.0
            );

            widget.onDeletedLastStroke!(await _canvas.getPNGListFromCanvas(true));
          }
        }

        if(GetIt.I<DrawScreenState>().strokes.deletingAllStrokes){
          widget.strokes.removeAllStrokes();
          GetIt.I<DrawScreenState>().strokes.deletingAllStrokes = false;
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
  void dispose() {
    _canvasController.dispose();
    super.dispose();
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

      GetIt.I<DrawScreenState>().strokes.deletingAllStrokes = true;
      GetIt.I<DrawScreenState>().strokes.deletingLastStroke = false;
    }
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: Listener(
        // started drawing
        onPointerDown: (details) async {
          // finish deleting stroke(s) when user starts drawing
          if(GetIt.I<DrawScreenState>().strokes.deletingLastStroke){
            widget.strokes.removeLastStroke();
            _canvasController.value = 1.0;
            GetIt.I<DrawScreenState>().strokes.deletingLastStroke = false;
          }
          if(GetIt.I<DrawScreenState>().strokes.deletingAllStrokes){
            widget.strokes.removeAllStrokes();
            _canvasController.value = 1.0;
            GetIt.I<DrawScreenState>().strokes.deletingAllStrokes = false;
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
            const Image( 
              image: AssetImage("assets/images/ui/kanji_drawing_aid.png")
            ),
            CanvasSnappable(
              key: GetIt.I<Settings>().advanced.useThanosSnap ?
                GetIt.I<DrawScreenState>().snappableKey : GlobalKey(),
              snapColor: GetIt.I<Settings>().misc.selectedTheme == LocaleKeys.General_light
                ? Colors.black
                : Colors.white,
              offset: const Offset(20, -20),
              randomDislocationOffset: const Offset(5, 5),
              numberOfBuckets: 16,
              onSnapped: () {
                GetIt.I<DrawScreenState>().strokes.removeAllStrokes();
                GetIt.I<DrawScreenState>().snappableKey.currentState?.reset();
              },
              child: AnimatedBuilder(
                animation: _canvasController,
                builder: (BuildContext context, Widget? child) {
                  _canvas = DrawingPainter(
                    widget.strokes.path, 
                    darkMode, Size(widget.width, widget.height),
                    GetIt.I<DrawScreenState>().strokes.deletingLastStroke ? 
                      _canvasController.value : currentDeleteLastprogress
                  );
                  Widget canvas = CustomPaint(
                      size: Size(widget.width, widget.height),
                      painter: _canvas,
                  );
            
                  if(GetIt.I<DrawScreenState>().strokes.deletingAllStrokes) {
                    return Opacity(
                      opacity: _canvasController.value,
                      child: canvas
                    );
                  } else {
                    return canvas;
                  }
                }
              ),
            ),
          ],
        )
      ),
    );
  }

  /// convenience wrapper for getting a PNG-image as list of the current canvas.
  Future<Uint8List> getPNGImage() async {
    return _canvas.getPNGListFromCanvas(true);
  } 
  
  /// convenience wrapper for getting a RGBA-list of the current canvas.
  Future<Uint8List> getRGBAImage() async {
    return _canvas.getRGBAListFromCanvas(true);
  } 

  /// Handle all cases how the DeleteLastAnimation could be triggered
  void handleDeleteLastAnimation() async {

    if(widget.strokes.playDeleteLastStrokeAnimation && !GetIt.I<DrawScreenState>().strokes.deletingAllStrokes){
      widget.strokes.playDeleteLastStrokeAnimation = false;
      
      // start deleting the last stroke if the animation is not already running
      if(!GetIt.I<DrawScreenState>().strokes.deletingLastStroke){
        _canvasController.reverse(from: 1.0); 
        GetIt.I<DrawScreenState>().strokes.deletingLastStroke = true;
      }
      // if the animation is already running delete a stroke
      else if(GetIt.I<DrawScreenState>().strokes.deletingLastStroke && widget.strokes.strokeCount > 0){
        widget.strokes.removeLastStroke();
        _canvasController.reverse(from: 1.0);
        
        // and stop the animation if it was the last stroke
        if(widget.strokes.strokeCount == 0){
          GetIt.I<DrawScreenState>().strokes.deletingLastStroke = false;
          _canvasController.value = 1.0;
        }
      }
      
    }
  }

}