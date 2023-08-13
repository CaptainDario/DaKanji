import 'package:flutter/material.dart';



class ObjectDetections extends ChangeNotifier {

  List<ObjectDetection> _objectDetections = [];

  List<ObjectDetection> get objectDetections => _objectDetections;

  set objectDetections(List<ObjectDetection> objectDetections) {
    _objectDetections = objectDetections;
    notifyListeners();
  }
}

class ObjectDetection {
  /// Index of the result
  int _id;

  /// Label of the result
  String _label;

  /// Confidence [0.0, 1.0]
  double _score;

  /// Location of bounding box rect
  ///
  /// The rectangle corresponds to the raw input image
  /// passed for inference
  Rect _location;

  ObjectDetection(this._id, this._label, this._score, this._location);

  int get id => _id;

  String get label => _label;

  double get score => _score;

  Rect get location => _location;
}