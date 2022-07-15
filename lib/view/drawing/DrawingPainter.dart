import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';


/// The canvas widget on which the user draws the kanji.
class DrawingPainter extends CustomPainter {
  
  /// the size of the canvas
  late Size _size;
  /// the path which should be drawn on the canvas
  /// 
  /// **Note:** the stored path and sub paths are normalized between 0 .. 1
  /// this has to be done to be resolution and size independent
  /// when this path gets drawn the normalized coordinates are scale to the 
  /// current size
  late Path _path;
  /// if the app is running in dark mode
  late bool _darkMode;
  /// if the canvas is currently being recorded
  late bool _recording;
  /// Amount of the last stroke which should be shown (delete stroke animation)
  late double _deleteProgress;


  /// Constructs an DrawingPainter instance.
  /// 
  /// All points given with [pointsList] will be drawn on the canvas.
  /// [darkMode] should reflect in which mode the app is running.
  /// [size] is the desired size of the canvas and [progress] should be
  /// a double in the range [0 .. 1] that indicates how much of the strokes
  /// should be rendered
  DrawingPainter(Path path, bool darkMode, Size size, double progress) {
    this._size = size;
    this._path = path;
    this._darkMode = darkMode;
    this._recording = false;
    this._deleteProgress = progress;
  }


  
  /// Returns an image of the current canvas as ui.Image.
  ///
  /// Creates a new ui.Canvas and repaints the current image on it. This canvas 
  /// than generates an image and returns it. [inference] should indicate
  /// if the returned image will be used for inference
  Future<ui.Image> getImageFromCanvas(bool inference) async {
    // record the drawn character on a new canvas
    this._recording = inference;
    ui.PictureRecorder drawnImageRecorder = ui.PictureRecorder();
    Canvas getImageCanvas = new ui.Canvas(drawnImageRecorder);
    paint(getImageCanvas, _size);
    ui.Picture pic = drawnImageRecorder.endRecording();
    this._recording = false;

    // convert the recording to an image
    return pic.toImage(_size.width.floor(), _size.height.floor());
  }

  /// Returns an image of the current canvas as Uint8List (PNG-format).
  ///
  /// Creates a new ui.Canvas and repaints the current image on it. This canvas 
  /// than generates an the drawn image and returns a Uint8List of it.
  Future<Uint8List> getPNGListFromCanvas(bool inference) async {

    final ui.Image img = await getImageFromCanvas(inference);
    
    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }
  
  /// Returns an image of the current canvas as Uint8List (raw RGBA-format).
  ///
  /// Creates a new ui.Canvas and repaints the current image on it. This canvas 
  /// than generates an the drawn image and returns a Uint8List of it.
  Future<Uint8List> getRGBAListFromCanvas(bool inference) async {

    final ui.Image img = await getImageFromCanvas(inference);
    
    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.rawRgba);
    Uint8List rgbaBytes = byteData!.buffer.asUint8List();

    return rgbaBytes;
  }

  /// Paints [this._path] on the given [canvas].
  void drawPath(Canvas canvas) {
    // Setup canvas and paint
    canvas.clipRect(Rect.fromLTWH(0, 0, _size.width, _size.height));
    Paint paint = Paint()
      ..strokeWidth = _size.width * 0.02
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // set the stroke color for creating an image and mode selection
    if (this._darkMode || this._recording)
      paint.color = Colors.white;
    else
      paint.color = Colors.black;

    // create the scale transformation matrix (paths are normalized [0..1])
    var b = this._path.getBounds().isEmpty ?
      ui.Rect.fromLTRB(0, 0, 1, 1) :
      this._path.getBounds();

    Float64List scale = transformationMatrix(
      scaleX: _size.width, scaleY: _size.height
    );

    // if image is being recorded for inference
    if(this._recording){
      canvas.drawPath(
        _path
          // move to origin
          .shift(Offset(-b.center.dx, -b.center.dy))
          // scale to 85% of canvas
          .transform(transformationMatrix(
            scaleX: _size.width / (b.height > b.width ? b.height : b.width) * 0.75,
            scaleY: _size.height / (b.height > b.width ? b.height : b.width) * 0.75
          ))
          // move to center
          .shift(Offset(_size.width / 2.0, _size.height / 2.0)),
          paint
      );
    }
    else{

      // animate deleting the last stroke only if the animation is running
      if(_deleteProgress < 1){
        ui.PathMetrics metrics = _path.computeMetrics();
        int metricsAmount = _path.computeMetrics().length;
        int metricsCount = 0;
        for (ui.PathMetric metric in metrics){
          double percentage;

          // draw all paths except the last one at full length
          if(metricsAmount > metricsCount+1)
            percentage = metric.length;
          else
            percentage = metric.length * _deleteProgress;
          Path extractPath = metric.extractPath(0.0, percentage);
          canvas.drawPath(extractPath.transform(scale), paint);
          metricsCount += 1;
        }
      }
      // otherwise just draw the whole path (improved drawing performance)
      else
        canvas.drawPath(
          _path.transform(scale), 
        paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) async {
    drawPath(canvas);
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate){
    return true;
  }

  /// Returns a transformation matrix based on the given parameters
  Float64List transformationMatrix({
    scaleX = 1.0, scaleY = 1.0, scaleZ = 1.0,
    transX = 0.0, transY = 0.0, transZ = 0.0,
    }){

    return Float64List.fromList([
      scaleX,      0,      0, 0,
      0,      scaleY,      0, 0,
      0,           0, scaleZ, 0,
      transX, transY, transZ, 1,
    ]);
  }
}
