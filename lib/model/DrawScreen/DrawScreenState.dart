import '../../provider/drawing/Strokes.dart';
import '../../provider/drawing/KanjiBuffer.dart';
import '../../provider/drawing/DrawingLookup.dart';
import 'DrawScreenLayout.dart';



/// Represents the state of the drawing screen
class DrawScreenState {

  /// the strokes which are drawn on the Canvas of the Drawing Screen
  Strokes strokes;
  /// stores all characters which are in the multi character lookup
  KanjiBuffer kanjiBuffer;
  /// change notifier for looking up characters in dictionaries
  DrawingLookup drawingLookup;
  /// in which layout is the app currently being rendered
  DrawScreenLayout drawScreenLayout;
  /// the current size of the drawing canvas
  double canvasSize = 0.0;

  DrawScreenState(
    this.strokes,
    this.kanjiBuffer,
    this.drawingLookup,
    this.drawScreenLayout);
}