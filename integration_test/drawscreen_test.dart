import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:da_kanji_mobile/main.dart' as app;
import 'package:da_kanji_mobile/view/drawing/DrawingCanvas.dart';




void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("DrawScreen test", (WidgetTester tester) async {
    // create app instance and wait until it finished initializing
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));

    Offset canvasCenter = tester.getCenter(find.byType(DrawingCanvas));

    // draw 口 on the canvas
    List<Offset> kuchi = [
      canvasCenter + Offset( 50,  50),
      canvasCenter + Offset(-50,  50),
      canvasCenter + Offset(-50, -50),
      canvasCenter + Offset( 50, -50),
      canvasCenter + Offset( 50,  50),
    ];
    await movePointer(tester,  kuchi);
    await tester.pump(Duration(seconds: 30));
    
  });
}

/// Creates a pointer and moves it 
Future<void> movePointer(WidgetTester tester, List<Offset> points) async {
    
    // create a pointer to draw a character on the canvas
    final gesture = await tester.createGesture();
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();
    
    // start drawing at the first point
    await gesture.down(points[0]);
    await tester.pumpAndSettle();
    
    for (int i = 1; i < points.length; i++){ 
      await gesture.moveTo(points[i]);
    }
    await tester.pumpAndSettle();

}