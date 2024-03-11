// Flutter imports:
import 'package:da_kanji_mobile/application/word_lists/anki.dart';
import 'package:da_kanji_mobile/application/word_lists/csv.dart';
import 'package:da_kanji_mobile/application/word_lists/images.dart';
import 'package:da_kanji_mobile/entities/user_data/user_data.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_sql.dart';
import 'package:da_kanji_mobile/widgets/anki/anki_not_setup_dialog.dart';
import 'package:da_kanji_mobile/widgets/widgets/loading_popup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as p;

// Project imports:
import 'package:da_kanji_mobile/application/word_lists/pdf.dart';
import 'package:da_kanji_mobile/entities/tree/tree_node.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_list_types.dart';
import 'package:da_kanji_mobile/entities/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:universal_io/io.dart';

/// All actions a user can do when clicking the 
enum  WordListNodePopupMenuButtonItems {
  rename,
  delete,
  sendToAnki,
  toImages,
  toPdf,
  toCSV,
}

/// One Node of the word lists tree, can either be a folder or a word list
class WordListNode extends StatefulWidget {

  /// The tree node that represents this tile
  final TreeNode<WordListsData> node;
  /// The index of this tile in the list
  final int index;
  /// The duration for the color while hovering to animate
  final int hoveringAnimationColorDuration;
  /// The duration for the color while hovering to animate
  final int nodeMovementAnimationDuration;
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
  /// and that would accept that item
  final void Function(TreeNode<WordListsData> node,
                      TreeNode<WordListsData> other,)? onWillDragAccept;
  /// Callback that is executed when the user drags this tile over another tile
  /// and drops it there. Provides this and destination `TreeNode`s as parameters
  /// If a new folder is created, provides this as `folder` parameter
  /// The list `otherAffected` contains all other nodes that are affected by
  /// this transformation
  final void Function(TreeNode<WordListsData> destinationNode,
                      TreeNode<WordListsData> node,
                      TreeNode<WordListsData>? folder,
                      List<TreeNode<WordListsData>> otherAffected)? onDragAccept;
  /// Callback that is executed when the user taps the delete button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> node)? onDeletePressed;
  /// Callback that is executed when the user taps the folder open/close button
  /// on this tile. Provides this `TreeNode` as a parameter
  final void Function(TreeNode<WordListsData> node)? onFolderPressed;
  /// Callback that is executed when the user taps the checkbox
  /// on this tile. Provides this `TreeNode` as a parameter and the current state
  final void Function (TreeNode<WordListsData> node, bool value)? onSelectedToggled;


  const WordListNode(
    this.node,
    this.index,
    {
      required this.hoveringAnimationColorDuration,
      required this.nodeMovementAnimationDuration,
      this.editTextOnCreate = false,
      this.onTap,
      this.onDragStarted,
      this.onDragEnd,
      this.onRenameFinished,
      this.onWillDragAccept,
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

    if(widget.editTextOnCreate) nameEditing = true;
  }

  @override
  Widget build(BuildContext context) {
    // make list reorderable
    return ReorderableDelayedDragStartListener(
      index: widget.index,
      // make tile draggable
      child: Draggable<TreeNode<WordListsData>>(
        maxSimultaneousDrags: widget.node.value.type == WordListNodeType.wordListDefault
          ? 0
          : 1,
        data: widget.node,
        feedback: SizedBox(
          width: MediaQuery.sizeOf(context).width,
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

            widget.onWillDragAccept?.call(widget.node, data);
    
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
            TreeNode<WordListsData>  oldParentData = data.parent!;
            TreeNode<WordListsData>  oldParentThis = widget.node.parent!;

            // list / folder draged on folder
            if((data.value.type == WordListNodeType.folder || data.value.type == WordListNodeType.wordList) &&
              widget.node.value.type == WordListNodeType.folder){

              data.parent!.removeChild(data);
              widget.node.addChild(data);
              _controller.text = widget.node.value.name;
              itemDraggingOverThis = false;
            }
            // list draged on list
            else if((data.value.type == WordListNodeType.wordList || data.value.type == WordListNodeType.folder) &&
              widget.node.value.type == WordListNodeType.wordList){
              // add a new folder to the parent of this
              newFolder = TreeNode<WordListsData>(
                WordListsData("New Folder", WordListNodeType.folder, [], true),);
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
    
            widget.onDragAccept?.call(data, widget.node, newFolder,
              [oldParentData, oldParentThis]);
          },
          builder: (context, candidateItems, rejectedItems) {
            return AnimatedContainer(
              height: 48,
              duration: Duration(milliseconds: widget.hoveringAnimationColorDuration),
              color: itemDraggingOverThis
                ? g_Dakanji_green.withOpacity(0.5)
                : Colors.transparent,
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
                        icon: AnimatedRotation(
                          turns: widget.node.value.isExpanded ? 2/8 : 0,
                          duration: Duration(milliseconds: widget.nodeMovementAnimationDuration),
                          child: const Icon(Icons.arrow_right),
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
                    if(widget.onSelectedToggled != null)
                      Checkbox(
                        value: widget.node.value.isChecked,
                        onChanged: (value) {

                          if(value == null) return;

                          widget.onSelectedToggled!.call(widget.node, value);
                          
                        }
                      ),
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
                              sendToAnkiPressed();
                              break;
                            case WordListNodePopupMenuButtonItems.toImages:
                              toImagesPressed();
                              break;
                            case WordListNodePopupMenuButtonItems.toPdf:
                              toPDFPressed();
                              break;
                            case WordListNodePopupMenuButtonItems.toCSV:
                              toCSVPressed();
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
                          if(widget.node.value.type != WordListNodeType.wordListDefault)
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
                                value: WordListNodePopupMenuButtonItems.toImages,
                                child: Text(
                                  LocaleKeys.WordListsScreen_export_images.tr()
                                )
                              ),
                              PopupMenuItem(
                                value: WordListNodePopupMenuButtonItems.toPdf,
                                child: Text(
                                  LocaleKeys.WordListsScreen_export_pdf.tr()
                                )
                              ),
                              PopupMenuItem(
                                value: WordListNodePopupMenuButtonItems.toCSV,
                                child: Text(
                                  LocaleKeys.WordListsScreen_export_csv.tr()
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

  /// Callback when the user presses the send to anki option
  /// Sends all elements in this word list to anki
  void sendToAnkiPressed() async {

    if(!GetIt.I<UserData>().ankiSetup){
      await ankiNotSetupDialog(context).show();
    }
    else{
      // show loading indicator
      loadingPopup(
        context,
        waitingInfo: Text(LocaleKeys.WordListsScreen_send_to_anki_progress.tr())
      ).show();

      // send to anki PDF
      await sendListToAnkiFromWordListNode(widget.node);

      // close loading indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

  }

  /// Creates a pdf document in portrait mode and opens a dialog to show it
  /// From this dialog the list can be printed, shared, etc...
  void toPDFPressed() async {

    // let the user select a folder
    String? path = await FilePicker.platform.getDirectoryPath();
    if(path == null) return;

    // show loadign indicator
    // ignore: use_build_context_synchronously
    loadingPopup(
      context,
      waitingInfo: Text(LocaleKeys.WordListsScreen_export_pdf_progress.tr())
    ).show();

    // create PDF
    pw.Document pdf = await pdfPortraitFromWordListNode(
      await GetIt.I<WordListsSQLDatabase>().getEntryIDsOfWordList(widget.node.id),
      widget.node.value.name);

    // close loading indicator
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    // write PDF to file
    File f = File(p.join(path, "${widget.node.value.name}.pdf"));
    f.createSync();
    f.writeAsBytesSync(await pdf.save());

  }

  /// Creates a csv file and lets the user share it
  void toCSVPressed() async {

    // let the user select a folder
    String? path = await FilePicker.platform.getDirectoryPath();

    if (path == null) return;

    // show loadign indicator
    // ignore: use_build_context_synchronously
    loadingPopup(
      context,
      waitingInfo: Text(LocaleKeys.WordListsScreen_export_csv_progress.tr())
    ).show();

    // create csv
    String csv = await csvFromWordListNode(widget.node);
    
    // close loading indicator
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    // write csv to file
    File f = File(p.join(path, "${widget.node.value.name}.csv"));
    f.createSync();
    f.writeAsStringSync(csv);

  }

  /// Creates a folder of images of vocab cards and lets the user share it
  void toImagesPressed() async {

    // let the user select a folder
    String? path = await FilePicker.platform.getDirectoryPath();
    if(path == null) return;

    // show loadign indicator
    // ignore: use_build_context_synchronously
    loadingPopup(
      context,
      waitingInfo: Text(LocaleKeys.WordListsScreen_export_images_progress.tr())
    ).show();

    // create csv
    List<File> files = await imagesFromWordListNode(widget.node);
    
    // close loading indicator
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    // copy files from temp to new directory
    final destDirectory = Directory(p.join(path, widget.node.value.name));
    destDirectory.createSync();
    for (var file in files) {

      file.copySync(p.join(destDirectory.path, p.basename(file.path)));
      file.deleteSync();

    }

  }

}
