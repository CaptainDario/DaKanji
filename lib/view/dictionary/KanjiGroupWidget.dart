import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:xml/xml.dart';
import 'package:graphview/GraphView.dart';



class KanjiGroupWidget extends StatefulWidget {
  const KanjiGroupWidget(
    this.kanjiVG,
    this.width,
    this.height,
    {Key? key}
  ) : super(key: key);

  /// Tree containing the kanji group hirarchy to be displayed
  final String kanjiVG; 
  /// the height of this widget
  final double height;
  /// the width of this widget
  final double width;

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
  /// Header of all KanjiVG entries
  String KanjiVGHeader = """
  <?xml version="1.0" encoding="UTF-8"?>

  <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd" [
  <!ATTLIST g
  xmlns:kvg CDATA #FIXED "http://kanjivg.tagaini.net"
  kvg:element CDATA #IMPLIED
  kvg:variant CDATA #IMPLIED
  kvg:partial CDATA #IMPLIED
  kvg:original CDATA #IMPLIED
  kvg:part CDATA #IMPLIED
  kvg:number CDATA #IMPLIED
  kvg:tradForm CDATA #IMPLIED
  kvg:radicalForm CDATA #IMPLIED
  kvg:position CDATA #IMPLIED
  kvg:radical CDATA #IMPLIED
  kvg:phon CDATA #IMPLIED >
  <!ATTLIST path
  xmlns:kvg CDATA #FIXED "http://kanjivg.tagaini.net"
  kvg:type CDATA #IMPLIED >
  ]>
  <svg xmlns="http://www.w3.org/2000/svg" width="109" height="109" viewBox="0 0 109 109">
  <g id="kvg:StrokePaths_09b31" style="fill:none;stroke:#000000;stroke-width:3;stroke-linecap:round;stroke-linejoin:round;">
  """;

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

  /// Parses a KanjiVG entry `kanjiVGEntry` and adds it to the given `graph`
  /// Returns a List with all SVG strings that were added to `graph` matching
  /// the order of the Id in `graph`
  List<String> kanjiVGToGraph(String kanjiVGEntry, Graph graph){

    // convert the KanjiVG entry to a Xml doc
    final document = XmlDocument.parse(kanjiVGEntry);
    
    // find the first complete kanji definition in the XML doc (without numbers)
    XmlElement firstElem = document.root.findAllElements('g').where(
      (element) => element.getAttribute("kvg:element") != null
    ).first;

    // list of sub-SVGs ordered the same way as `graph`
    List<String> kanjiSVGStringList = [KanjiVGHeader + firstElem.toString() + "</g>"];
    
    // traverse the XML document with breadth first search
    Queue<XmlElement> elemQueue = Queue()..add(firstElem);
    Queue<Node> nodeQueue = Queue()..add(Node.Id(0));
    int cnt = 1;
    while (elemQueue.isNotEmpty){
      XmlElement parentElement = elemQueue.removeFirst();
      Node parentNode = nodeQueue.removeFirst();

      // iterate over all children of this element that are <g> elem
      for (XmlElement childElement in parentElement.childElements) {
        if(childElement.name.local == "g"){
            
            String t = "";
          
            // get the whole subtree and create a string of it
            for (var node in childElement.descendantElements) {
              t += node.toString();
            }
            kanjiSVGStringList.add(KanjiVGHeader + t + "</g>");

            // create new Graph Node, connect it with parent and append to queue
            Node newNode = Node.Id(cnt);
            graph.addEdge(parentNode, newNode);
            nodeQueue.add(newNode);
            elemQueue.add(childElement);

            cnt++;
        }
      }
    }

    return kanjiSVGStringList;

  }
}