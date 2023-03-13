import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';



/// Enum that defines the traversal mode available for the tree
enum TreeTraversalMode{
  /// Traverse the tree in breadth first order
  BFS,
  /// Traverse the tree in depth first order
  DFS,
}

/// A node in a tree structure, emits a notification when it is modified
class TreeNode<T> with ChangeNotifier{

  /// the value of this node
  T value;
  /// a list containing all children of this TreeNode
  List<TreeNode<T>> _children = [];
  /// a list containing all children of this TreeNode
  List<TreeNode<T>> get children => List.unmodifiable(_children);
  /// the parent TreeNode of this TreeNode, if null this is the root
  TreeNode<T>? parent;
  /// the level of this node in the tree, 0 means it is the root
  int _level = 0;
  /// the level of this node in the tree, 0 means it is the root
  int get level => _level;

  @JsonKey(ignore: true)
  late Map<TreeTraversalMode, Iterable<TreeNode<T>>> _iterDict = {
    TreeTraversalMode.BFS: BFS(),
    TreeTraversalMode.DFS: DFS(),
  };


  TreeNode (this.value, {int level = 0});

  /// adds newNode as a child to this node
  void addChild (TreeNode<T> newNode) {
    _children.add(newNode);
    newNode.parent = this;
    
    // update the level information for the whole subtree
    updateLevel();

    notifyListeners();
  }

  /// Adds all nodes in `newNodes` as children to this node
  void addChildren (List<TreeNode<T>> newNodes) {
    _children.addAll(newNodes);
    for (final node in newNodes) {
      node.parent = this;
    }

    // update the level information for the whole subtree
    updateLevel();

    notifyListeners();
  }

  /// inserts `newNode` as a child to this node at the given `index`
  void insertChild (TreeNode<T> newNode, int index) {
    _children.insert(index, newNode);
    newNode.parent = this;

    // update the level information for the whole subtree
    updateLevel();

    notifyListeners();
  }
  
  /// removes `node` from the children of this node and returns it
  TreeNode<T> removeChild (TreeNode<T> node) {
    _children.remove(node);
    node.parent = null;

    notifyListeners();
    return node;
  }

  /// remove all nodes given in `nodes` from the children of this node
  /// If there are multiple nodes with the same value, only the first one is
  /// removed
  /// Returns a list of all removed nodes
  List<TreeNode<T>> removeChildren (List<TreeNode<T>> nodes) {

    List<TreeNode<T>> removed = [];

    for (final node in nodes) {
      if(_children.remove(node)){
        removed.add(node);
        node.parent = null;
        node.updateLevel();
      }
    }

    notifyListeners();
    return removed;
  }

  /// removes all nodes from the children of this node and returns them
  List<TreeNode<T>> clearChildren () {

    List<TreeNode<T>> tmp = _children;

    for (final TreeNode<T> node in _children) {
      node.parent = null;
      node.updateLevel();
    }
    _children.clear();

    notifyListeners();
    return tmp;
  }

  /// Update the level information of all nodes in the subtree
  void updateLevel () {
    for (final node in DFS()) {
      node._level = node.parent!.level + 1;
    }
  }

  /// Traverses the tree and returns the top level node
  TreeNode<T> getRoot() {
    TreeNode<T> node = this;

    while (node.parent != null) {
      node = node.parent!;
    }

    return node;
  }

  /// returns a list with all nodes to this node
  /// has the structure: [root, n1, n2, ..., this]
  List<TreeNode> getPath() {
    
    List<TreeNode<T>> path = [this];

    while (path.first.parent != null) {
      TreeNode<T> parent = path.first.parent!;
      path.insert(0, parent);
    }

    return path;
  }

  /// Traverse the tree in breadth first order
  Iterable<TreeNode<T>> BFS() sync* {
    Queue<TreeNode<T>> queue = Queue()..add(this);
    
    while (queue.isNotEmpty) {
      TreeNode<T> node = queue.removeFirst();
      yield node;
      queue.addAll(node._children);
    }
  }

  /// Traverse the tree in depth first order
  Iterable<TreeNode<T>> DFS() sync* {
    for (TreeNode<T> node in _children) {
      yield node;
      yield* node.DFS();
    }
  }

  /// Searches the `query` in the tree. If the tree contains multiple identical
  /// nodes, returns the first one found. If the tree does not contain the 
  /// `query` returns null.
  /// `TreeNode`s are compared using their value only.
  /// `mode` determines the algorithm used to traverse the tree.
  TreeNode<T>? find(TreeNode<T> query, {TreeTraversalMode mode = TreeTraversalMode.BFS}){

    var iter = _iterDict[mode]!;

    for (var node in iter) {
      if(node.value == query.value){
        return node;
      }
    }

    return null;
  }

  /// Copies the tree to a new tree and returns it.
  TreeNode<T> copy(){
    return _copy(this);
  }

  /// Copies the tree to a new tree and returns it, `copy` is just the public
  /// interface to this function, so that it is not neceessary to call it with
  /// the root node as argument.
  TreeNode<T> _copy(TreeNode<T> root){
    
    if (root.children.isEmpty) return TreeNode(root.value);

    return TreeNode(root.value).._children.addAll(
      root._children.map((e) => e._copy(e))
    );
  }

  @override
  String toString() {
    return "$value, level: $level, children: ${_children.map((e) => e.value)}";
  }

  /// Converts this tree to a string by traversing it and printing the values
  /// of each layer
  String toTreeString() {
    String treeString = '';

    int previousLevel = 0;
    for (var node in BFS()) {
      if (node.level > previousLevel) {
        treeString += "\n${node.level}: ";
        previousLevel = node.level;
      }
      treeString += "${node.value} c: ${node._children.map((e) => e.value)}\t";
    }

    return treeString;
  }

  /// Converts this tree to a list by traversing it in the order specified by
  /// `mode`, finally returns the list.
  List<T> toList({TreeTraversalMode mode = TreeTraversalMode.BFS}) {
    
    List<T> treeList = [];
    
    for (var node in _iterDict[mode]!) {
      treeList.add(node.value);
    }

    return treeList;
  }

  factory TreeNode.fromJson(Map<String, dynamic> json) {

    T value = json['value'] as T;
    int level = json['level'] as int;
    List<TreeNode<T>> children = (json['children'] as List<dynamic>)
      .map((e) => TreeNode<T>.fromJson(e as Map<String, dynamic>))
      .toList();

    return TreeNode<T>(value)
      .._level = level
      .._children = children;
  }

  Map<String, dynamic> toJson(){
    return {
      'value': value,
      'level': level,
      'children': _children.map((e) => e.toJson()).toList(),
    };
  }
}