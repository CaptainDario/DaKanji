import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import 'calligraphy_pen_painter.dart';



class KanjiDrawingWidget extends StatefulWidget {
  const KanjiDrawingWidget(
    {
      super.key
    }
  );

  @override
  State<KanjiDrawingWidget> createState() => _KanjiDrawingWidgetState();
}

class _KanjiDrawingWidgetState extends State<KanjiDrawingWidget> {
  
  /// list containing all points that have been drawn
  final List<List<Offset>> _paths = [];
  /// list containing the pen pressure values when drawing `_points`
  final List<double> _penPressures = [];
  /// list containing the pen tilts when drawing `_points`
  final List<double> _penTilts = [];

  ui.Image? brush;

  @override
  void initState() {
    loadUiImage('assets/images/brush.png').then((value) {
      setState(() {
        brush = value;
      }); 
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Listener(
            onPointerDown: (event) {
              _paths.add([Offset(
                event.localPosition.dx,
                event.localPosition.dy
              )]);
            },
            onPointerMove: (PointerMoveEvent event) {
              setState(() {
                _penPressures.add(event.pressure);
                _penTilts.add(event.tilt);
                _paths.last.add(
                  Offset(event.localPosition.dx, event.localPosition.dy)
                );
              });
            },
            onPointerUp: (event) {
              //_paths.last.close();
            },
            child: brush != null ?
              CustomPaint(
                painter: CalligraphyPenPainter(
                  brush: brush!,
                  paths: _paths,
                  penPressures: _penPressures,
                  penTilts: _penTilts,
                ),
              )
              : Container()
          ),
        ),
        IconButton(
          onPressed: (){
            setState(() {
              _penPressures.clear();
              _paths.clear();
              _penTilts.clear();
            });
          },
          icon: const Icon(Icons.refresh)
        )
      ],
    );
  }

  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final data = await rootBundle.load(imageAssetPath);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}