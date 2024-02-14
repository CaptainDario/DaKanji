// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Project imports:
import 'package:da_kanji_mobile/application/word_lists/pdf.dart';
import 'package:da_kanji_mobile/application/word_lists/word_lists.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_loading_indicator.dart';

/// All actions a user can do when clicking the 
enum  WordListNodePopupMenuButtonItems {
  rename,
  delete,
  sendToAnki,
  toPdf
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
  /// Callback that is executed when the user starts dragging this tile
  final void Function()? onDragEnd;
  /// Callback that is executed when the user ends dragging this tile
  final void Function()? onDragStarted;
  /// Callback that is executed when the user finished renaming this tile
  final void Function(TreeNode<WordListsData> node)? onRenameFinished;
  /// Callback that is executed when the user drags this tile over another tile
  /// and drops it there. Provides this and destination `TreeNode`s as parameters
  /// If a new folder is created, provides this as `folder` parameter
  final void Function(TreeNode<WordListsData> destinationNode, TreeNode<WordListsData> node, TreeNode<WordListsData>? folder)? onDragAccept;
  /// Callback that is executed when the user taps the delete button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> node)? onDeletePressed;
  /// Callback that is executed when the user taps the folder open/close button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> node)? onFolderPressed;
  /// Callback that is executed when the user taps the checkbox
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function (TreeNode<WordListsData> node)? onSelectedToggled;


  const WordListNode(
    this.node,
    this.index,
    {
      this.editTextOnCreate = false,
      this.onTap,
      this.onDragStarted,
      this.onDragEnd,
      this.onRenameFinished,
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
  final TextEditingController _controller = TextEditingController();
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
    if(!wordListDefaultTypes.contains(widget.node.value.type)){
      _controller.text = widget.node.value.name;
    }
    // transate default types
    else {
      _controller.text = wordListsDefaultsStringToTranslation(widget.node.value.name);
    }

    if(widget.editTextOnCreate) nameEditing = true;
  }

  @override
  Widget build(BuildContext context) {
    // make list reorderable
    return ReorderableDelayedDragStartListener(
      index: widget.index,
      // make tile draggable
      child: Draggable<TreeNode<WordListsData>>(
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
        onDragStarted: () {
          widget.onDragStarted?.call();
        },
        onDragEnd: (details) {
          widget.onDragEnd?.call();
        },
        onDraggableCanceled: (velocity, offset) => setState(() => {}),
        // make tile droppable
        child: DragTarget<TreeNode<WordListsData>>(
          onWillAccept: (data) {
            // do not allow dropping ...
            if(data == null ||
              wordListDefaultTypes.contains(widget.node.value.type) // .. in a non-user-entry
            ) {
              return false;
            }
    
            // mark this widget as accepting the element
            setState(() {itemDraggingOverThis = true;});
    
            return true;
          },
          onLeave: (data) {
            setState(() {itemDraggingOverThis = false;});
          },
          onAccept: (TreeNode<WordListsData> data) {

            // dragging the tile in itself should do nothing
            if(data == widget.node){
              itemDraggingOverThis = false;
              return;
            }
    
            TreeNode<WordListsData>? newFolder;

            // list / folder draged on folder
            if((data.value.type == WordListNodeType.folder || 
              data.value.type == WordListNodeType.wordList) &&
              widget.node.value.type == WordListNodeType.folder){
              data.parent!.removeChild(data);
              widget.node.addChild(data);
              _controller.text = widget.node.value.name;
              itemDraggingOverThis = false;
            }
            // list draged on list
            else if(data.value.type == WordListNodeType.wordList &&
              widget.node.value.type == WordListNodeType.wordList){
              // add a new folder
              newFolder = TreeNode<WordListsData>(
                WordListsData("New Folder", WordListNodeType.folder, [], true)
              );
              int idx = widget.node.parent!.children.indexOf(widget.node);
              widget.node.parent!.insertChild(newFolder, idx);
  
              // add this and the drag target to the new folder and remove them from their old parents
              data.parent!.removeChild(data);
              widget.node.parent!.removeChild(widget.node);
              newFolder.addChild(widget.node);
              newFolder.addChild(data);
  
              _controller.text = widget.node.value.name;
              itemDraggingOverThis = false;
            }
            setState(() {});
    
            widget.onDragAccept?.call(data, widget.node, newFolder);
          },
          builder: (context, candidateItems, rejectedItems) {
            return Container(
              color: itemDraggingOverThis ? g_Dakanji_green.withOpacity(0.5) : null,
              padding: EdgeInsets.fromLTRB(
                15.0*(widget.node.level-1)+8, 0, 0, 0
              ),
              child: InkWell(
                onTap: () {
                  if(widget.onTap != null){
                    widget.onTap!(widget.node);
                  }
                },
                child: Row(
                  children: [
                    // if this is a folder show open/close button
                    wordListFolderTypes.contains(widget.node.value.type)
                      ? IconButton(
                        icon: Icon( widget.node.value.isExpanded
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right
                        ),
                        // open / close callback
                        onPressed: () {
                          if(widget.node.level < 1) return;
    
                          widget.node.value.isExpanded = !widget.node.value.isExpanded;
                          widget.onFolderPressed?.call(widget.node);
                        },
                      )
                      : const SizedBox(
                        width: 48,
                        child: Icon(Icons.list)
                      ),
                    const SizedBox(width: 8.0,),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        focusNode: nameEditingFocus,
                        controller: _controller,
                        enabled: nameEditing,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black
                        ),
                        decoration: InputDecoration(
                          border: nameEditing ? null : InputBorder.none,
                          hintText: LocaleKeys.WordListsScreen_node_hint_text.tr()
                        ),
                        onEditingComplete: () {
                          renamingComplete();
                        },
                        onTapOutside: (event) {
                          if(nameEditing){
                            renamingComplete();
                          }
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
                            widget.node.dfs().forEach((element) {
                              element.value.isChecked = value;
                            });
                          });
    
                          widget.onSelectedToggled!.call(widget.node);
                        }
                      ),
                    if(!wordListDefaultTypes.contains(widget.node.value.type))
                      PopupMenuButton<WordListNodePopupMenuButtonItems>(
                        onSelected: (WordListNodePopupMenuButtonItems value) {
                          switch(value){
                            case WordListNodePopupMenuButtonItems.rename:
                              renameButtonPressed();
                              break;
                            case WordListNodePopupMenuButtonItems.delete:
                              deleteButtonPressed();
                              break;
                            case WordListNodePopupMenuButtonItems.sendToAnki:
                              break;
                            case WordListNodePopupMenuButtonItems.toPdf:
                              toPDFPressed();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          if(!wordListDefaultTypes.contains(widget.node.value.type))
                            PopupMenuItem(
                              value: WordListNodePopupMenuButtonItems.rename,
                              child: Text(
                                LocaleKeys.WordListsScreen_rename.tr(),
                              )
                            ),
                          if(!wordListDefaultTypes.contains(widget.node.value.type))
                            PopupMenuItem(
                              value: WordListNodePopupMenuButtonItems.delete,
                              child: Text(
                                LocaleKeys.WordListsScreen_delete.tr(),
                              )
                            ),
                          if(wordListListypes.contains(widget.node.value.type))
                            ...[
                              PopupMenuItem(
                                value: WordListNodePopupMenuButtonItems.sendToAnki,
                                child: Text(
                                  LocaleKeys.WordListsScreen_send_to_anki.tr()
                                )
                              ),
                              PopupMenuItem(
                                value: WordListNodePopupMenuButtonItems.toPdf,
                                child: Text(
                                  LocaleKeys.WordListsScreen_create_pdf.tr()
                                )
                              ),
                            ]
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

    widget.onRenameFinished?.call(widget.node);
  }

  /// Executed when the user presses the delete button
  void deleteButtonPressed(){
    
    widget.onDeletePressed?.call(widget.node);
    
  }

  /// Creates a pdf document in portrait mode and opens a dialog to show it
  /// From this dialog the list can be printed, shared, etc...
  void toPDFPressed() async {

    pw.Document pdf = await pdfPortrait(widget.node.value);

    // ignore: use_build_context_synchronously
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PdfPreview(
                loadingWidget: const DaKanjiLoadingIndicator(),
                actions: [
                  // to portrait
                  IconButton(
                    icon: const Icon(Icons.description),
                    onPressed: () async {
                      pdf = await pdfPortrait(widget.node.value);
                      setState(() {});
                    },
                  ),
                  IconButton(
                    onPressed: () {}, 
                    icon: const Icon(Icons.more_vert)
                  )
                ],
                canChangeOrientation: false,
                canChangePageFormat: false,
                
                pdfFileName: "${widget.node.value.name}.pdf",
                build: (format) {
                  return pdf.save();
                }
                
              ),
            ),
          );
        }
      )
    ).show();
  }


}
