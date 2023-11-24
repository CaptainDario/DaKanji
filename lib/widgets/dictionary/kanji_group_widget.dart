// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphview/GraphView.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/application/dictionary/kanji_vg.dart';
import 'package:da_kanji_mobile/domain/navigation_arguments.dart';
import 'package:da_kanji_mobile/globals.dart';

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
  late Graph graph;
  /// builder configuration for the GraphView
  late BuchheimWalkerConfiguration builder;
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
    graph = Graph()..isTree = true;

    Tuple2 tmp = kanjiVGToGraph(widget.kanjiVG, graph);
    kanjiVGStringList = tmp.item1;
    kanjiVGChars = tmp.item2;

    builder = BuchheimWalkerConfiguration()
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
              return MouseRegion(
                cursor: kanjiVGChars[node.key!.value] != ""
                  ? SystemMouseCursors.click
                  : MouseCursor.defer,
                child: GestureDetector(
                  onLongPress: (){
                    if(kanjiVGChars[node.key!.value] != ""){
                      Navigator.pushNamedAndRemoveUntil(
                        context, 
                        '/dictionary', 
                        (route) => false,
                        arguments: NavigationArguments(
                          false, dictInitialSearch: kanjiVGChars[node.key!.value]
                        )
                      );
                    }
                  },
                  onTap: () {
                    if(kanjiVGChars[node.key!.value] != ""){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("copied: ${kanjiVGChars[node.key!.value]}"),
                          duration: const Duration(seconds: 1),
                        )
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
