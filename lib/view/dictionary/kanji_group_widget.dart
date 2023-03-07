import 'package:da_kanji_mobile/model/navigation_arguments.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphview/GraphView.dart';
import 'package:tuple/tuple.dart';

import 'package:da_kanji_mobile/globals.dart';
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
  /// builder configuration for the GraphView
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  /// List containing all sub SVGs of the KanjiVG entry and its order matches
  /// all `Node.Id` in `graph`
  late List<String> kanjiVGStringList;
  /// List containing the unicode characters matching the order of 
  /// `kanjiVGStringList`
  /// Empty strings in the list mean that this character part does not exist
  /// in unicode
  late List<String> kanjiVGChars;
  

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KanjiGroupWidget oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    Tuple2 tmp = kanjiVGToGraph(widget.kanjiVG, graph);
    kanjiVGStringList = tmp.item1;
    kanjiVGChars = tmp.item2;

    builder
      ..siblingSeparation = (10)
      ..levelSeparation = (15)
      ..subtreeSeparation = (30)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
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
              return GestureDetector(
                onLongPress: (){
                  if(kanjiVGChars[node.key!.value] != ""){
                    Navigator.pushNamedAndRemoveUntil(
                      context, 
                      '/dictionary', 
                      (route) => false,
                      arguments: NavigationArguments(false, kanjiVGChars[node.key!.value])
                    );
                  }
                },
                child: Container(
                  width:  50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: kanjiVGChars[node.key!.value] != ""
                          ? g_Dakanji_green
                          : Colors.black,
                      )
                  ),
                  child: Center(
                    child: SvgPicture.string(
                      kanjiVGStringList[(node.key!.value as int)]
                    ),
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