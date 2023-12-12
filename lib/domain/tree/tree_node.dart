// Dart imports:
import 'dart:collection';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:da_kanji_mobile/domain/tree/tree_node_json_converter.dart';

part 'tree_node.g.dart';





/// Enum that defines the traversal mode available for the tree
enum TreeTraversalMode{
  /// Traverse the tree in breadth first order
  bfs,
  /// Traverse the tree in depth first order
  dfs,
}

/// A node in a tree structure, emits a notification when it's structure changes
/// If `T` is a `ChangeNotifier` it will also send notifications when one of it's
/// values is modified
@JsonSerializable(explicitToJson: true)
class TreeNode<T> with ChangeNotifier{

  /// the value of this node
  @TreeNodeConverter()
  T value;
  /// The id of this node, used for deserializing this object
  @JsonKey(includeFromJson: true, includeToJson: true)
  int _id = 0;

  /// a list containing all children of this TreeNode
  @TreeNodeConverter()
  List<TreeNode<T>> _children = [];
  /// a list containing all children of this TreeNode
  @TreeNodeConverter()
  List<TreeNode<T>> get children => List.unmodifiable(_children);

  /// the parent TreeNode of this TreeNode, if null this is the root
  @JsonKey(includeFromJson: false, includeToJson: false)
  TreeNode<T>? parent;
  /// A unique ID in the tree, used for deserializing this objetc, null means
  /// this is the root
  @JsonKey(includeFromJson: true, includeToJson: true)
  int? _parentID;

  /// the level of this node in the tree, 0 means it is the root
  @JsonKey(includeFromJson: true, includeToJson: true)
  int _level = 0;
  /// the level of this node in the tree, 0 means it is the root
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get level => _level;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late final Map<TreeTraversalMode, Iterable<TreeNode<T>>> _iterDict = {
    TreeTraversalMode.bfs: bfs(),
    TreeTraversalMode.dfs: dfs(),
  };


  TreeNode(
    this.value,
    {
      List<TreeNode<T>> children = const [],
    }
  ){

    if(children.isNotEmpty) {
      this._children = children;
    } else {
      this._children = [];
    }
  }


  /// adds newNode as a child to this node
  void addChild (TreeNode<T> newNode) {
    // if the added data is a change notifier, add `this` as a listener
    if(newNode.value is ChangeNotifier) {
      (newNode.value as ChangeNotifier).addListener(notifyListeners);
    }

    _children.add(newNode);
    newNode.parent = this;
    
    // update the tree
    updateLevel();
    updateID();

    notifyListeners();
  }

  /// Adds all nodes in `newNodes` as children to this node
  void addChildren (List<TreeNode<T>> newNodes) {
    _children.addAll(newNodes);
    for (final newNode in newNodes) {
      newNode.parent = this;

      // if the added data is a change notifier, add `this` as a listener
      if(newNode.value is ChangeNotifier) {
        (newNode.value as ChangeNotifier).addListener(notifyListeners);
      }
    }

    // update the tree
    updateLevel();
    updateID();

    notifyListeners();
  }

  /// inserts `newNode` as a child to this node at the given `index`
  void insertChild (TreeNode<T> newNode, int index) {

    _children.insert(index, newNode);
    newNode.parent = this;

    // if the added data is a change notifier, add `this` as a listener
    if(newNode.value is ChangeNotifier) {
      (newNode.value as ChangeNotifier).addListener(notifyListeners);
    }

    // update the tree
    updateLevel();
    updateID();

    notifyListeners();
  }
  
  /// removes `node` from the children of this node and returns it
  TreeNode<T> removeChild (TreeNode<T> node) {
    _children.remove(node);
    node.parent = null;
    node.updateID();
    // if the removed data is a change notifier, remove listener
    if(node.value is ChangeNotifier) {
      (node.value as ChangeNotifier).removeListener(notifyListeners);
    }

    updateID();

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
        // if the removed data is a change notifier, remove listener
        if(node.value is ChangeNotifier) {
          (node.value as ChangeNotifier).removeListener(notifyListeners);
        }
        node.parent = null;
        node.updateLevel();
        node.updateID();
      }
    }

    updateID();
    notifyListeners();

    return removed;
  }

  /// removes all nodes from the children of this node and returns them
  List<TreeNode<T>> clearChildren () {

    List<TreeNode<T>> tmp = _children;

    for (final TreeNode<T> node in _children) {
      // if the removed data is a change notifier, remove listener
      if(node.value is ChangeNotifier) {
        (node.value as ChangeNotifier).removeListener(notifyListeners);
      }
      node.parent = null;
      node.updateLevel();
      node.updateID();
    }
    _children.clear();

    updateID();
    notifyListeners();
    return tmp;
  }

  /// Update the level information of all nodes in the subtree
  void updateLevel () {
    for (final node in dfs()) {
      node._level = node.parent!.level + 1;
    }
  }

  /// Update the id of all nodes in this tree
  void updateID () {

    TreeNode<T> root = getRoot();

    int cnt = 0;
    for (final n in root.bfs()) {
      n._id = cnt;

      if(n.parent != null) {
        n._parentID = n.parent!._id;
      } else {
        n._parentID = null;
      }

      cnt++;
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
  Iterable<TreeNode<T>> bfs() sync* {
    Queue<TreeNode<T>> queue = Queue()..add(this);
    
    while (queue.isNotEmpty) {
      TreeNode<T> node = queue.removeFirst();
      yield node;
      queue.addAll(node._children);
    }
  }

  /// Traverse the tree in depth first order
  Iterable<TreeNode<T>> dfs() sync* {
    for (TreeNode<T> node in _children) {
      yield node;
      yield* node.dfs();
    }
  }

  /// Searches the `query` in the tree. If the tree contains multiple identical
  /// nodes, returns the first one found. If the tree does not contain the 
  /// `query` returns null.
  /// `TreeNode`s are compared using their value only.
  /// `mode` determines the algorithm used to traverse the tree.
  TreeNode<T>? find(TreeNode<T> query, {TreeTraversalMode mode = TreeTraversalMode.bfs}){

    var iter = _iterDict[mode]!;

    for (var node in iter) {
      if(node.value == query.value){
        return node;
      }
    }

    return null;
  }

  /// Searches the node in the tree that has the ID `id`. If the tree does not
  /// contain the `query` returns null.
  /// `mode` determines the algorithm used to traverse the tree.
  TreeNode<T>? findByID(int id, {TreeTraversalMode mode = TreeTraversalMode.bfs}){

    var iter = _iterDict[mode]!;

    for (var node in iter) {
      if(node._id == id){
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

    TreeNode(root.value)._children.addAll(
        root._children.map((e) => e._copy(e))
      );

    throw Exception('Not implemented');
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
    for (var node in bfs()) {
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
  List<T> toList({TreeTraversalMode mode = TreeTraversalMode.bfs}) {
    
    List<T> treeList = [];
    
    for (var node in _iterDict[mode]!) {
      treeList.add(node.value);
    }

    return treeList;
  }

  factory TreeNode.fromJson(Map<String,dynamic> json){
    
    TreeNode<T> root = _$TreeNodeFromJson<T>(json);
    
    for (final node in root.bfs()){
      if(node._parentID == null) continue;

      node.parent = root.findByID(node._parentID!);
    }

    return root;
  }

  Map<String,dynamic> toJson() => _$TreeNodeToJson<T>(this);
}
