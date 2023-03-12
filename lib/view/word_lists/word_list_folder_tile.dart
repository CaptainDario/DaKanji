import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:graphview/GraphView.dart';



enum  PopupMenuButtonItems {
  Rename,
  Delete
}

class WordListFolderTile extends StatefulWidget {

  /// The tree node that represents this tile
  final TreeNode<String> node;
  /// The index of this tile in the list
  final int index;
  /// Callback that is executed when the user taps on this tile, provides the
  /// `TreeNode` as a parameter
  final void Function(TreeNode<String> node)? onTap;
  /// Callback that is executed when the user drags this tile over another tile
  /// and drops it there. Provides this and destination `TreeNode`s as parameters
  final void Function(TreeNode destinationNode, TreeNode thisNode)? onDragAccept;

  const WordListFolderTile(
    this.node,
    this.index,
    {
      this.onTap,
      this.onDragAccept,
      super.key
    }
  );

  @override
  State<WordListFolderTile> createState() => _WordListFolderTileState();
}

class _WordListFolderTileState extends State<WordListFolderTile> {
  /// The text controller for the name editing text field
  TextEditingController _controller = TextEditingController();
  /// is the name of the folder currently being edited
  bool nameEditing = false;
  /// Focus node for the name editing text field
  FocusNode nameEditingFocus = FocusNode();


  @override
  void initState() {
    _controller.text = widget.node.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: this.widget
      ),
      data: widget.node,
      onDraggableCanceled: (velocity, offset) => setState(() => {}),
      child: DragTarget<TreeNode>(
        onAccept: (TreeNode data) {
          // do not allow self drags
          if(data == widget.node) return;

          setState(() {
            widget.node.addChild(data.parent!.removeChild(data) as TreeNode<String>);
          });

          widget.onDragAccept?.call(data, widget.node);
        },
        builder: (context, candidateItems, rejectedItems) {
          return Card(
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
                    Icon(Icons.folder),
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
                    ReorderableDragStartListener(
                      index: widget.index,
                      child: PopupMenuButton<PopupMenuButtonItems>(
                        onSelected: (PopupMenuButtonItems value) {
                          switch(value){
                            case PopupMenuButtonItems.Rename:
                              renameButtonPressed();
                              break;
                            case PopupMenuButtonItems.Delete:
                              // TODO implement delete
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: PopupMenuButtonItems.Rename,
                            child: Text("Rename")
                          ),
                          PopupMenuItem(
                            value: PopupMenuButtonItems.Delete,
                            child: Text("Delete")
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  /// Executed when the user presses the rename button
  void renameButtonPressed(){
         
    setState(() {
      nameEditing = true;
    });
    
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
    widget.node.value = _controller.text;
  }

  /// Executed when the user presses the delete button
  void deleteButtonPressed(){
    // TODO implement delete
  }

}