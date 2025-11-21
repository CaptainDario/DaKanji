// Package imports:
import 'package:flutter_test/flutter_test.dart';

final List<Offset> kuchiStrokes = [
  const Offset( 0.75,  0.75),
  const Offset(-0.75,  0.75),
  const Offset(-0.75, -0.75),
  const Offset( 0.75, -0.75),
  const Offset( 0.75,  0.75),
];

final List<Offset> nichiStroke = [
  const Offset( 0.75,  0.0),
  const Offset(-0.75,  0.0),
];

final List<Offset> meStroke1 = [
  const Offset( 0.75,  0.25),
  const Offset(-0.75,  0.25),
];
final List<Offset> meStroke2 = [
  const Offset( 0.75, -0.25),
  const Offset(-0.75, -0.25),
];


String kuchiPrediction = "囗";
String nichiPrediction = "日";
String mePrediction    = '目';

List<String> kanjiBuffer = ["目", "日", "囗"];


/// Creates a pointer and moves it to the given `points` in relation to 
/// `referencePoint` as center point. Waits for a duration of `wait` after 
/// each pointer down and movement.
/// Moves the pointer up after each point. 
Future<void> movePointer(
  WidgetTester tester,
  Offset referencePoint,
  List<Offset> points,
  double scale,
  {
    Duration wait = const Duration(milliseconds: 500),
  }) async {
    
    // create a pointer to draw a character on the canvas
    final gesture = await tester.createGesture();
    await gesture.addPointer(location: referencePoint);
    addTearDown(gesture.removePointer);
    await tester.pumpAndSettle();
    
    // draw lines between all the given points
    for (int i = 0; i < points.length-1; i++){ 
      await gesture.down(referencePoint + points[i] * scale);
      await tester.pumpAndSettle(wait);
      await gesture.moveTo(referencePoint + points[i+1] * scale);
      await gesture.up();
      await tester.pump(wait);
    }
    await tester.pumpAndSettle();

}
