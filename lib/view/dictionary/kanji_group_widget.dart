import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphview/GraphView.dart';

import 'package:da_kanji_mobile/model/DictionaryScreen/kanjiVG_util.dart';



class KanjiGroupWidget extends StatefulWidget {

  /// Tree containing the kanji group hirarchy to be displayed
  final String kanjiVG; 
  /// the height of this widget
  final double height;
  /// the width of this widget
  final double width;

  const KanjiGroupWidget(
    this.kanjiVG,
    this.width,
    this.height,
    {Key? key}
  ) : super(key: key);

  @override
  State<KanjiGroupWidget> createState() => _KanjiGroupWidgetState();
}

class _KanjiGroupWidgetState extends State<KanjiGroupWidget> {

  /// graph of the KanjiVG element
  final Graph graph = Graph()..isTree = true;
  // builder configuration for the GraphView
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  // List containing all sub SVGs of the KanjiVG entry and its order matches
  // all `Node.Id` in `graph`
  late List<String> kanjiVGStringList;
  

  @override
  void initState() {

    kanjiVGStringList = kanjiVGToGraph(widget.kanjiVG, graph);

    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (15)
      ..subtreeSeparation = (30)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GraphView(
            graph: graph,
            algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
            paint: Paint()
              ..color = Colors.black
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke,
            builder: (Node node) {
              return Container(
                width:  50,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)
                ),
                child: Center(
                  child: SvgPicture.string(
                    kanjiVGStringList[(node.key!.value as int)]
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}