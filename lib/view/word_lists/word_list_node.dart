import 'package:flutter/material.dart';

import 'package:tuple/tuple.dart';

import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/word_lists.dart';



enum  PopupMenuButtonItems {
  Rename,
  Delete
}

class WordListNode extends StatefulWidget {

  /// The tree node that represents this tile
  final TreeNode<Tuple3<String, WordListNodeType, List<int>>> node;
  /// The index of this tile in the list
  final int index;
  /// If the textfield should be enabled and focused when the tile is created
  final bool editTextOnCreate;
  /// Callback that is executed when the user taps on this tile, provides the
  /// `TreeNode` as a parameter
  final void Function(TreeNode<Tuple3<String, WordListNodeType, List<int>>> node)? onTap;
  /// Callback that is executed when the user drags this tile over another tile
  /// and drops it there. Provides this and destination `TreeNode`s as parameters
  final void Function(TreeNode destinationNode, TreeNode thisNode)? onDragAccept;
  /// Callback that is executed when the user taps the delete button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode thisNode)? onDeletePressed;

  const WordListNode(
    this.node,
    this.index,
    {
      this.editTextOnCreate = false,
      this.onTap,
      this.onDragAccept,
      this.onDeletePressed,
      super.key
    }
  );

  @override
  State<WordListNode> createState() => _WordListNodeState();
}

class _WordListNodeState extends State<WordListNode> {
  /// The text controller for the name editing text field
  TextEditingController _controller = TextEditingController();
  /// is the name of the folder currently being edited
  bool nameEditing = false;
  /// Focus node for the name editing text field
  FocusNode nameEditingFocus = FocusNode();
  /// is an item currently being dragged over this tile
  bool itemDraggingOverThis = false;


  @override
  void initState() {
    _controller.text = widget.node.value.item1;

    if(widget.editTextOnCreate) nameEditing = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // make list reorderable
    return ReorderableDelayedDragStartListener(
      index: widget.index,
      // make tile draggable
      child: Draggable(
        feedback: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: 0.5,
            child: widget
          )
        ),
        data: widget.node,
        onDraggableCanceled: (velocity, offset) => setState(() => {}),
        // make tile droppable
        child: DragTarget<TreeNode>(
          onWillAccept: (data) {
            // do not allow self drags
            if(data == widget.node ||
              wordListFolderTypes.contains(widget.node.value.item2))
              return false;

            // mark this widget as accepting the element
            setState(() {itemDraggingOverThis = true;});

            return true;
          },
          onLeave: (data) {
            setState(() {itemDraggingOverThis = false;});
          },
          onAccept: (TreeNode data) {
            setState(() {
              widget.node.addChild(data.parent!.removeChild(data)
                as TreeNode<Tuple3<String, WordListNodeType, List<int>>>);
            });
    
            widget.onDragAccept?.call(data, widget.node);
          },
          builder: (context, candidateItems, rejectedItems) {
            return Card(
              color: itemDraggingOverThis ? Colors.grey[300] : null,
              child: InkWell(
                onTap: () {
                  if(widget.onTap != null){
                    widget.onTap!(widget.node);
                  };
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                  child: Row(
                    children: [
                      Icon(
                        wordListFolderTypes.contains(widget.node.value.item2)
                          ? Icons.folder
                          : Icons.list
                      ),
                      SizedBox(width: 8.0,),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          focusNode: nameEditingFocus,
                          controller: _controller,
                          enabled: nameEditing,
                          decoration: InputDecoration(
                            border: nameEditing ? null : InputBorder.none,
                            hintText: "Name"
                          ),
                          onEditingComplete: () {
                            renamingComplete();
                          },
                          onTapOutside: (event) {
                            renamingComplete();
                          },
                        )
                      ),
                      if(!widget.node.value.item2.name.contains("Default"))
                      PopupMenuButton<PopupMenuButtonItems>(
                        onSelected: (PopupMenuButtonItems value) {
                          switch(value){
                            case PopupMenuButtonItems.Rename:
                              renameButtonPressed();
                              break;
                            case PopupMenuButtonItems.Delete:
                              deleteButtonPressed();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          if(!widget.node.value.item2.name.contains("Default"))
                            PopupMenuItem(
                              value: PopupMenuButtonItems.Rename,
                              child: Text("Rename")
                            ),
                          if(!widget.node.value.item2.name.contains("Default"))
                            PopupMenuItem(
                              value: PopupMenuButtonItems.Delete,
                              child: Text("Delete")
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  /// Executed when the user presses the rename button
  void renameButtonPressed(){
         
    setState(() {
      nameEditing = true;
    });
    
    // set the focus AFTER the widget has been built
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameEditingFocus.requestFocus();
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length
      );
    });
    
  }

  void renamingComplete(){
    setState(() {
      nameEditing = false;
    });
    widget.node.value = Tuple3(_controller.text, widget.node.value.item2, widget.node.value.item3);
  }

  /// Executed when the user presses the delete button
  void deleteButtonPressed(){
    widget.onDeletePressed?.call(widget.node);
  }

}