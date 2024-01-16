// Dart imports:
import 'dart:collection';

// Package imports:
import 'package:graphview/GraphView.dart';
import 'package:tuple/tuple.dart';
import 'package:xml/xml.dart';

// Project imports:
import 'package:da_kanji_mobile/globals.dart';

/// Parses a KanjiVG entry `kanjiVGEntry` and adds it to the given `graph`
/// Returns a List with all SVG strings that were added to `graph` matching
/// the order of the Id in `graph` and if the character is available as unicode
/// add it to a second list which is also returned
Tuple2<List<String>, List<String>> kanjiVGToGraph(String kanjiVGEntry, Graph graph){

  // preprocess and convert the KanjiVG entry to a Xml doc
  kanjiVGEntry = preprocessKanjiVGString(kanjiVGEntry);
  final document = colorizeKanjiVGGroups(XmlDocument.parse(kanjiVGEntry));
  
  // find the first complete kanji definition in the XML doc (without numbers)
  XmlElement firstElem = document.root.findAllElements('g').where(
    (element) => element.getAttribute("kvg:element") != null
  ).first;

  /// list of sub-SVGs ordered the same way as `graph`
  List<String> kanjiSVGStringList = ["$kanjiVGHeader$firstElem</g></svg>"];
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
        for (XmlElement node in childElement.descendantElements) {
          if(!node.attributes.any((p0) => p0.name.qualified == "kvg:part")) {
            t += node.toXmlString(pretty: true);
          }
        }
        kanjiSVGStringList.add("$kanjiVGHeader$t</g></svg>");

        // add the unicode character to the list
        kanjiSVGCharacters.add(childElement.getAttribute("kvg:element") ?? "");

        // create new Graph Node, connect it with parent and append to queue
        Node newNode = Node.Id(cnt);
        graph.addEdge(parentNode, newNode);
        nodeQueue.add(newNode);
        elemQueue.add(childElement);

        cnt++;
      }
    }
  }
  
  return Tuple2(kanjiSVGStringList, kanjiSVGCharacters);
}

/// Preprocesses the KanjiVG entry to make it compatible with the SVG parser
/// 
/// In particular, it merges all <g> elements that are not a complete kanji,
/// i.E. all <g> elements that have a `kvg:part` attribute
/// 
/// Examples that need separating: 彭, 樹, 懺
String preprocessKanjiVGString(String kanjiVGEntry){

  final document = colorizeKanjiVGGroups(XmlDocument.parse(kanjiVGEntry));

  // find the first complete kanji definition in the XML doc (without numbers)
  XmlElement firstElem = document.root.findAllElements('g').where(
    (element) => element.getAttribute("kvg:element") != null
  ).first;

  Map<String, XmlElement> mergedParts =
    _preprocessKanjiVGStringMergeKvgParts(firstElem);
  
  _preprocessKanjiVGStringRemoveDuplicateElements(mergedParts);

  _preprocessKanjiVGStringInsertModifiedParts(firstElem, mergedParts);

  return document.toXmlString(pretty: true);
}

/// Merges all <g> elements that are not a complete kanji,
/// i.E. all <g> elements that have a `kvg:part` attribute
Map<String, XmlElement> _preprocessKanjiVGStringMergeKvgParts(XmlElement firstElem){
  Map<String, XmlElement> mergedParts = {};

  // search for `kvg:part` in the XML document with breadth first search
  List<XmlElement> split = firstElem.findAllElements('g').where(
    (element) => element.attributes.any((p0) => p0.name.qualified == "kvg:part")
  ).toList();
  for (XmlElement childElement in split) 
  {
    String  kvgE  = childElement.getAttribute("kvg:element")!;
    String? kvgNo = childElement.getAttribute("kvg:number");
    String  key = kvgE + (kvgNo ?? "");
    if(!mergedParts.containsKey(key)){
      var elem = XmlElement(XmlName("g"));
      elem.attributes.add(XmlAttribute(XmlName("kvg:element"), kvgE));
      mergedParts[key] = elem;
    }
    XmlNode node = childElement.copy();
    mergedParts[key]!.children.add(node);
  }

  // remove all part / element definitions from the collected `XmlElements`
  for (String key in mergedParts.keys) {
    List<XmlElement> toRemove = mergedParts[key]!.findAllElements('g').where(
        (element) => element.attributes.any((p0) => p0.name.qualified == "kvg:part")
      ).toList();
    while (toRemove.isNotEmpty){
      // remove this element from its parent and add all its children to parent
      XmlNode parent = toRemove.first.parent!;
      parent.children.remove(toRemove.first);
      parent.children.addAll(toRemove.first.children.map((p0) => p0.copy()));

      toRemove = mergedParts[key]!.findAllElements('g').where(
        (element) => element.attributes.any((p0) => p0.name.qualified == "kvg:part")
      ).toList();
    }
  }

  return mergedParts;
}

/// removes all duplicate elements from `mergedParts`
void _preprocessKanjiVGStringRemoveDuplicateElements(Map<String, XmlElement> mergedParts){
  for (XmlElement value in mergedParts.values) {
    List<String> ids = [];
    for (XmlElement childElement in value.findAllElements('g').toList()) 
    {
      if(!ids.contains(childElement.getAttribute("id")!)){
        ids.add(childElement.getAttribute("id")!);
      }
      else{
        childElement.parent!.children.remove(childElement);
      }
    }
  }
}

/// Modifies the XML document given by `firstElem` by inserting the modified
/// parts `mergedParts` into the document
void _preprocessKanjiVGStringInsertModifiedParts(
  XmlElement firstElem, Map<String, XmlElement> mergedParts)
{
  // insert the modified parts into the original document
  Queue<XmlElement> elemQueue = Queue()..add(firstElem);
  List<XmlElement> toRemove = [];
  while (elemQueue.isNotEmpty){
    XmlElement parentElement = elemQueue.removeFirst();

    // iterate over all children of this element that are <g> elem
    for (XmlElement childElement in parentElement.childElements) {
      if(childElement.name.local == "g"){
          
        elemQueue.add(childElement);

        // if this element is a part of a kanji-element 
        if(childElement.getAttribute("kvg:part") != null){
          String  kvgE  = childElement.getAttribute("kvg:element")!;
          String? kvgNo = childElement.getAttribute("kvg:number");
          // replace it if it is the first one
          if(mergedParts.containsKey(kvgE+(kvgNo ?? ""))){
            childElement.replace(mergedParts.remove(kvgE+(kvgNo ?? ""))!);
          }
          // otherwise add it to the list of elements to remove
          else {
            toRemove.add(childElement);
          }
        }
      }
    }
  }
  // remove all elements that are not needed anymore
  for (XmlElement element in toRemove) {
    element.parent!.children.remove(element);
  }
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
