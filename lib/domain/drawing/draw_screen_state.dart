// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/domain/drawing/drawing_lookup.dart';
import 'package:da_kanji_mobile/domain/drawing/kanji_buffer.dart';
import 'package:da_kanji_mobile/domain/drawing/strokes.dart';
import 'package:da_kanji_mobile/widgets/drawing/canvas_snappable.dart';
import 'draw_screen_layout.dart';

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
  /// the key to access the snappable animation
  final snappableKey = GlobalKey<CanvasSnappableState>();

  DrawScreenState(
    this.strokes,
    this.kanjiBuffer,
    this.drawingLookup,
    this.drawScreenLayout
  );
}
