import 'Strokes.dart';
import 'KanjiBuffer.dart';
import 'DrawingLookup.dart';
import 'DrawScreenLayout.dart';



/// Represents the state of the drawing screen
class DrawScreenState {

  /// the strokes which are drawn on the Canvas of the Drawing Screen
  Strokes strokes;

  KanjiBuffer kanjiBuffer;

  DrawingLookup drawingLookup;

  DrawScreenLayout drawScreenLayout;

  double canvasSize = 0.0;

  DrawScreenState(
    this.strokes,
    this.kanjiBuffer,
    this.drawingLookup,
    this.drawScreenLayout);
}