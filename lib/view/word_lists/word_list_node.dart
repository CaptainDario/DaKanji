import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/model/tree_node.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists.dart';
import 'package:da_kanji_mobile/model/WordLists/word_lists_data.dart';



enum  PopupMenuButtonItems {
  Rename,
  Delete
}

class WordListNode extends StatefulWidget {

  /// The tree node that represents this tile
  final TreeNode<WordListsData> node;
  /// The index of this tile in the list
  final int index;
  /// If the textfield should be enabled and focused when the tile is created
  final bool editTextOnCreate;
  /// Callback that is executed when the user taps on this tile, provides the
  /// `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> node)? onTap;
  /// Callback that is executed when the user drags this tile over another tile
  /// and drops it there. Provides this and destination `TreeNode`s as parameters
  final void Function(TreeNode<WordListsData> destinationNode, TreeNode thisNode)? onDragAccept;
  /// Callback that is executed when the user taps the delete button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> thisNode)? onDeletePressed;
  /// Callback that is executed when the user taps the folder open/close button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> thisNode)? onFolderPressed;
  /// Callback that is executed when the user taps the checkbox
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function (TreeNode<WordListsData> thisNode)? onSelectedToggled;


  const WordListNode(
    this.node,
    this.index,
    {
      this.editTextOnCreate = false,
      this.onTap,
      this.onDragAccept,
      this.onDeletePressed,
      this.onFolderPressed,
      this.onSelectedToggled,
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
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WordListNode oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init(){
    _controller.text = widget.node.value.name;

    if(widget.editTextOnCreate) nameEditing = true;
  }

  @override
  Widget build(BuildContext context) {
    // make list reorderable
    return ReorderableDelayedDragStartListener(
      index: widget.index,
      // make tile draggable
      child: Draggable(
        maxSimultaneousDrags: wordListDefaultTypes.contains(widget.node.value.type)
          ? 0
          : 1,
        data: widget.node,
        feedback: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: 0.5,
            child: widget
          )
        ),
        onDraggableCanceled: (velocity, offset) => setState(() => {}),
        // make tile droppable
        child: DragTarget<TreeNode>(
          onWillAccept: (data) {
            // do not allow dropping ...
            if(data == null ||
              data == widget.node || // ... in itself
              widget.node.value.type != WordListNodeType.folder || // .. in a non-user-folder
              widget.node.getPath().contains(data)) // ... in a child
              return false;

            // mark this widget as accepting the element
            setState(() {itemDraggingOverThis = true;});

            return true;
          },
          onLeave: (data) {
            setState(() {itemDraggingOverThis = false;});
          },
          onAccept: (TreeNode data) {

            var d = data as TreeNode<WordListsData>;

            setState(() {
              data.parent!.removeChild(d);
              widget.node.addChild(d);
              _controller.text = widget.node.value.name;
              itemDraggingOverThis = false;
            });
    
            widget.onDragAccept?.call(data, widget.node);
          },
          builder: (context, candidateItems, rejectedItems) {
            return Container(
              color: itemDraggingOverThis ? Colors.grey[300] : null,
              padding: EdgeInsets.fromLTRB(
                15.0*(widget.node.level-1)+8, 0, 0, 0
              ),
              child: InkWell(
                onTap: () {
                  if(widget.onTap != null){
                    widget.onTap!(widget.node);
                  };
                },
                child: Row(
                  children: [
                    wordListFolderTypes.contains(widget.node.value.type)
                      ? IconButton(
                        icon: Icon( widget.node.value.isExpanded
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right
                        ),
                        onPressed: () {
                          if(widget.node.level < 1) return;

                          setState(() {
                            widget.node.value.isExpanded = !widget.node.value.isExpanded;
                          });
                          widget.onFolderPressed?.call(widget.node);
                        },
                      )
                      : Container(
                        width: 48,
                        child: Icon(Icons.list)
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
                          hintText: LocaleKeys.WordListsScreen_node_hint_text.tr()
                        ),
                        onEditingComplete: () {
                          renamingComplete();
                        },
                        onTapOutside: (event) {
                          renamingComplete();
                        },
                      ),
                    ),
                    // checkbox for this entry
                    if(!wordListDefaultTypes.contains(widget.node.value.type) &&
                      widget.onSelectedToggled != null)
                      Checkbox(
                        value: widget.node.value.isChecked,
                        onChanged: (value) {
                          if(value == null) return;

                          setState(() {
                            widget.node.value.isChecked = value;
                            widget.node.DFS().forEach((element) {
                              element.value.isChecked = value;
                            });
                          });

                          widget.onSelectedToggled!.call(widget.node);
                        }
                      ),
                    if(!wordListDefaultTypes.contains(widget.node.value.type.name.contains("Default")))
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
                          if(!wordListDefaultTypes.contains(widget.node.value.type))
                            PopupMenuItem(
                              value: PopupMenuButtonItems.Rename,
                              child: Text(
                                LocaleKeys.WordListsScreen_rename.tr(),
                              )
                            ),
                          if(!wordListDefaultTypes.contains(widget.node.value.type))
                            PopupMenuItem(
                              value: PopupMenuButtonItems.Delete,
                              child: Text(
                                LocaleKeys.WordListsScreen_delete.tr(),
                              )
                            ),
                        ],
                      ),
                  ],
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

  /// Executed when the user finishes renaming the folder
  void renamingComplete(){
    setState(() {
      nameEditing = false;
    });
    widget.node.value.name = _controller.text;
  }

  /// Executed when the user presses the delete button
  void deleteButtonPressed(){
    widget.onDeletePressed?.call(widget.node);
  }

}