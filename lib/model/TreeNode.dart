


/// Class representing one TreeNode of a Tree datastructure
class TreeNode<T> {

  /// the value of this node
  late T value;
  /// a list containing all children of this TreeNode
  List<TreeNode<T>> children = [];
  /// the parent TreeNode of this TreeNode, if null this is the root
  TreeNode<T>? parent;


  TreeNode (T value){
    this.value = value;
  }

  /// adds newNode as a child to this node
  void add (TreeNode<T> newNode) {
    children.add(newNode);
    newNode.parent = this;
  }

  /// Traverse the tree in depth first order
  void forEachDepthFirst(void Function(TreeNode<T> node) performAction) {
    performAction(this);
    for (final child in children) {
      child.forEachDepthFirst(performAction);
    }
  }

}