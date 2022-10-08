import 'dart:isolate';
import 'dart:typed_data';



/// Bundles data to pass between Isolate
class DrawingIsolateData {

  Uint8List image;
  int interpreterAddress;
  List<String> labels;
  SendPort ?responsePort;

  DrawingIsolateData(
    this.image,
    this.interpreterAddress,
    this.labels,
  );
}