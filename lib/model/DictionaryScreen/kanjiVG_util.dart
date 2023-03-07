import 'dart:collection';

import 'package:tuple/tuple.dart';
import 'package:xml/xml.dart';
import 'package:graphview/GraphView.dart';

import 'package:da_kanji_mobile/globals.dart';



/// Parses a KanjiVG entry `kanjiVGEntry` and adds it to the given `graph`
/// Returns a List with all SVG strings that were added to `graph` matching
/// the order of the Id in `graph` and if the character is available as unicode
/// add it to a second list which is also returned
Tuple2<List<String>, List<String>> kanjiVGToGraph(String kanjiVGEntry, Graph graph){

  // convert the KanjiVG entry to a Xml doc
  final document = colorizeKanjiVGGroups(XmlDocument.parse(kanjiVGEntry));
  
  // find the first complete kanji definition in the XML doc (without numbers)
  XmlElement firstElem = document.root.findAllElements('g').where(
    (element) => element.getAttribute("kvg:element") != null
  ).first;

  /// list of sub-SVGs ordered the same way as `graph`
  List<String> kanjiSVGStringList = [kanjiVGHeader + firstElem.toString() + "</g></svg>"];
  /// list of unicode characters matching 
  List<String> kanjiSVGCharacters = [firstElem.getAttribute("kvg:element")!];
  
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

          if(childElement.getAttribute("kvg:element") != null){
            //print(childElement.getAttribute("kvg:element"));
            kanjiSVGCharacters.add(childElement.getAttribute("kvg:element")!);
          }
          else{
            kanjiSVGCharacters.add("");
          }
          kanjiSVGStringList.add(kanjiVGHeader + t + "</g></svg>");

          // create new Graph Node, connect it with parent and append to queue
          Node newNode = Node.Id(cnt);
          graph.addEdge(parentNode, newNode);
          nodeQueue.add(newNode);
          elemQueue.add(childElement);

          cnt++;
      }
    }
  }
  print(kanjiSVGCharacters);
  return Tuple2(kanjiSVGStringList, kanjiSVGCharacters);
}

/// Colorizes the groups in this KamjiVG entry and returns it
XmlDocument colorizeKanjiVGGroups(XmlDocument document){

  // find the first complete kanji definition in the XML doc (without numbers)
  XmlElement firstElem = document.root.findAllElements('g').where(
    (element) => element.getAttribute("kvg:element") != null
  ).first;
  
  
  // traverse the XML document with breadth first search
  Queue<XmlElement> elemQueue = Queue()..add(firstElem);
  int cnt = 1;
  while (elemQueue.isNotEmpty){
    XmlElement parentElement = elemQueue.removeFirst();

    // iterate over all children of this element that are <g> elem
    for (XmlElement childElement in parentElement.childElements) {
      if(childElement.name.local == "g"){
          
          // get the whole subtree and create a string of it
          for (var node in childElement.descendantElements) {
            node.setAttribute("stroke", "hsl($cnt, 100%, 50%)");
          }

          // create new Graph Node, connect it with parent and append to queue
          elemQueue.add(childElement);

          cnt += 30;
      }
    }
  }


  return document;
}