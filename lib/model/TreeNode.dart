import 'dart:collection';



/// Class representing one TreeNode of a Tree datastructure
class TreeNode<T> {

  /// the value of this node
  late T value;
  /// a list containing all children of this TreeNode
  List<TreeNode<T>> children = [];
  /// the parent TreeNode of this TreeNode, if null this is the root
  TreeNode<T>? parent;
  /// the level of this node in the tree, 0 means it is the root
  int level = 0;


  TreeNode (T value){
    this.value = value;
  }

  /// adds newNode as a child to this node
  void add (TreeNode<T> newNode) {
    children.add(newNode);
    newNode.parent = this;
    
    // update the level information for the whole subtree
    forEachBreadthFirst((node) {
      if(node.parent != null)
        node.level = node.parent!.level + 1;
      else
        node.level = 1;
    });
  }

  /// Traverse the tree in depth first order
  void forEachDepthFirst(void Function(TreeNode node) performAction) {
    performAction(this);
    for (final child in children) {
      child.forEachDepthFirst(performAction);
    }
  }

  /// Traverse the tree in breadth first order
  void forEachBreadthFirst(void Function(TreeNode node) performAction){

    Queue queue = Queue();
    queue.add(this);

    while (queue.isNotEmpty){

      performAction(queue.first);

      for (final child in queue.first.children) {
        queue.add(child);
      }
      queue.removeFirst();
    }
  }

  /// Traverse the tree in pre order
  void forEachPreOrder(void Function(TreeNode node) performAction){

    for (var child in children) {
      child.forEachPreOrder(performAction);
    }
    
    performAction(this);
  }

  /// Searches the `query` in the tree. If the tree contains multiple identical
  /// nodes, returns the first one found. If the tree does not contain the 
  /// `query` returns null
  TreeNode<T>? find(TreeNode<T> query){
    TreeNode<T>? result = null;
    
    Queue queue = Queue();
    queue.add(this);

    while (queue.isNotEmpty){

      if(queue.first == query){
        result = query;
        break;
      }

      for (final child in queue.first.children) {
        queue.add(child);
      }
      queue.removeFirst();
    }

    return result;
  }

  /// Copies the structure of this tree to a new tree
  /// All elements of the new tree will be initialized with `initValue`
  /// The copy will be returned;
  /// 
  /// A function can be used to dynamically generate the new values of the tree
  /// the current child is passed to the function
  TreeNode copyStructure(dynamic Function(TreeNode oldChild) initValue){

    TreeNode copiedTree = _copyChildStructure(initValue);
    copiedTree.value = copiedTree.value(this);
    return copiedTree;
  }

  /// Function to recursively copy the child tree
  /// Should only be called from `copyStructure`
  TreeNode _copyChildStructure(dynamic Function(TreeNode oldChild) initValue){

    TreeNode newTree = TreeNode(initValue);

    for (var child in this.children) {
      TreeNode newChild = child._copyChildStructure(initValue);
      newChild.value = newChild.value(child);
      newTree.add(newChild);
    }
    
    return newTree;
  }

  /// Copies the tree to a new tree and returns it
  TreeNode copy(){
    TreeNode newTree = TreeNode(this.value);

    for (var child in this.children) {
      print(child.value);
      newTree.add(child.copy());
    }

    return newTree;
  }

  @override
  String toString() {
    return this.value.toString();
  }

  List<T> toList() {
    List<T> graphList = [];

    forEachBreadthFirst((node) {
      graphList.add(node.value);
    });

    return graphList;
  }

  List<TreeNode> toTreeNodeList() {
    List<TreeNode> graphList = [];

    forEachBreadthFirst((node) {
      graphList.add(node);
    });

    return graphList;
  }

}