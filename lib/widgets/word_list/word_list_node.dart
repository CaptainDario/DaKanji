import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

import 'package:database_builder/database_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/domain/tree/tree_node.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists.dart';
import 'package:da_kanji_mobile/domain/word_lists/word_lists_data.dart';
import 'package:da_kanji_mobile/widgets/widgets/da_kanji_progress_indicator.dart';
import 'package:da_kanji_mobile/domain/isar/isars.dart';



enum  PopupMenuButtonItems {
  Rename,
  Delete,
  SendToAnki,
  ToPdf
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
              wordListDefaultTypes.contains(widget.node.value.type) || // .. in a non-user-entry
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
              
              // list / folder draged on folder
              if((d.value.type == WordListNodeType.folder || 
                d.value.type == WordListNodeType.wordList) &&
                widget.node.value.type == WordListNodeType.folder){
                d.parent!.removeChild(d);
                widget.node.addChild(d);
                _controller.text = widget.node.value.name;
                itemDraggingOverThis = false;
              }
              // list draged on list
              else if(d.value.type == WordListNodeType.wordList &&
                widget.node.value.type == WordListNodeType.wordList){
                // add a new folder
                TreeNode<WordListsData> newFolder = TreeNode<WordListsData>(
                  WordListsData(
                    "New Folder", WordListNodeType.folder, [], true
                  )
                );
                widget.node.parent!.addChild(newFolder);
    
                // add this and the drag target to the new folder and remove them from their old parents
                d.parent!.removeChild(d);
                widget.node.parent!.removeChild(widget.node);
                newFolder.addChild(widget.node);
                newFolder.addChild(d);
    
                _controller.text = widget.node.value.name;
                itemDraggingOverThis = false;
              }
    
              
            });
    
            widget.onDragAccept?.call(data, widget.node);
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
                            case PopupMenuButtonItems.SendToAnki:
                              break;
                            case PopupMenuButtonItems.ToPdf:
                              toPDFPressed();
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
                          if(wordListListypes.contains(widget.node.value.type))
                            ...[
                              PopupMenuItem(
                                value: PopupMenuButtonItems.SendToAnki,
                                child: Text(
                                  "Send to anki"
                                )
                              ),
                              PopupMenuItem(
                                value: PopupMenuButtonItems.ToPdf,
                                child: Text(
                                  "To PDF"
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
  }

  /// Executed when the user presses the delete button
  void deleteButtonPressed(){
    widget.onDeletePressed?.call(widget.node);
    
  }

  /// Creates a pdf document in portrait mode and opens a dialog to show it
  /// From this dialog the list can be printed, shared, etc...
  void toPDFPressed() async {

    pw.Document pdf = await pdfPortrait();

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
                loadingWidget: DaKanjiProgressIndicator(),
                actions: [
                  // to portrait
                  IconButton(
                    icon: Icon(Icons.description),
                    onPressed: () async {
                      pdf = await pdfPortrait();
                      setState(() {});
                    },
                  ),
                  // to landscape
                  IconButton(
                    icon: Transform.rotate(
                      angle: 90 * pi / 180,
                      child: Icon(Icons.description)
                    ),
                    onPressed: () async {
                      pdf = await pdfLandscape();
                      setState(() {});
                    },
                  ),
                  IconButton(
                    onPressed: () {}, 
                    icon: Icon(Icons.more_vert)
                  )
                ],
                canChangeOrientation: false,
                canChangePageFormat: false,
                
                pdfFileName: widget.node.value.name + ".pdf",
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

  /// Get all `JMDict` entries from the database that are in this word list
  /// Remove all translations that are not in `langsToInclude` and sort the
  /// translations matching `langsToInclude`. Lastly retruns the list of entries
  Future<List<JMdict>> wordListEntries(List<String> langsToInclude) async {

    List<JMdict> entries = await GetIt.I<Isars>().dictionary.jmdict
    // get all entries
    .where()
      .anyOf(widget.node.value.wordIds, (q, element) => q.idEqualTo(element))
    .filter()
      // only include them in the list if they have a translation in a selected language
      .anyOf(langsToInclude, (q, l) => 
        q.meaningsElement((m) => 
          m.languageEqualTo(l)
        )
      )
    .findAll();

    for (JMdict entry in entries) {
      // remove all translations that are not in `langsToInclude` and create a 
      entry.meanings = entry.meanings.where(
        (element) => langsToInclude.contains(element.language)
      ).toList();
      // sort the translations matching `langsToInclude`
      entry.meanings.sort((a, b) =>
        langsToInclude.indexOf(a.language!).compareTo(langsToInclude.indexOf(b.language!))
      );
      // only include the first `maxTranslations` translations
      entry.meanings = entry.meanings.sublist(0, min(3, entry.meanings.length));
    }

    return entries;

  }

  /// Export this word list as a PDF file
  Future<pw.Document> pdfPortrait() async {
    
    // Create document
    final pw.Document pdf = pw.Document();
    // load Japanese font
    final ttf = await fontFromAssetBundle("assets/fonts/Noto_Sans_JP/NotoSansJP-Medium.ttf");
    final notoStyle = pw.TextStyle(
      font: ttf,
      fontSize: 12
    );
    // load the dakanji logo
    final dakanjiLogo = await rootBundle.load("assets/images/dakanji/icon.png");

    // find all elements from the word list in the database
    List<String> langsToInclude = ["rus", "eng", "ger"];
    int maxTranslations = 3;
    bool includeKana = true;
    bool maxOneLine = true;
    List<JMdict> entries = await wordListEntries(langsToInclude);


    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        margin: pw.EdgeInsets.all(16),
        footer: (context) {
          return pdfFooter(context, dakanjiLogo);
        },
        build: (pw.Context context) {
          return [
            for (JMdict entry in entries)
              ...[
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // translations
                    pw.Expanded(
                      child: pw.Table(
                        children: [
                          for (LanguageMeanings language in entry.meanings)
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  language.language ?? "None",
                                  style: notoStyle,
                                  maxLines: maxOneLine ? 1 : null
                                ),
                                pw.Text(
                                  language.meanings!.join(", "),
                                  style: notoStyle,
                                  maxLines: 1
                                ),
                              ]
                            )
                        ]
                      )
                    ),
                    // japanese
                    pw.Expanded(
                      child: pw.Text(
                        (entry.kanjis + entry.readings).join("、"),
                        style: notoStyle
                      )
                    )
                  ]
                ),
                pw.Divider(),
              ]
          ];
        }
      )
    );

    return pdf;

  }

  /// create the footer for the portrait pdf document
  pw.Widget pdfFooter(pw.Context context, ByteData dakanjiLogo) {

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            '${widget.node.value.name}',
            style: pw.TextStyle(
              color: PdfColors.grey,
              fontSize: 10,
            ),
          ),
          pw.Image(
            pw.MemoryImage(
              dakanjiLogo.buffer.asUint8List()
            ),
            height: 25,
            width: 25
          ),
          pw.Text(
            'Page: ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(
              color: PdfColors.grey,
              fontSize: 10,
            ),
          ),
        ]
      )
    );

  }

  /// Export this word list as a PDF file in landscape mode
  Future<pw.Document> pdfLandscape() async {

    // Create document
    final pw.Document pdf = pw.Document();
    // load Japanese font
    final ttf = await fontFromAssetBundle("assets/fonts/Noto_Sans_JP/NotoSansJP-Medium.ttf");
    final notoStyle = pw.TextStyle(
      font: ttf,
      fontSize: 12
    );
    // load the dakanji logo
    final dakanjiLogo = await rootBundle.load("assets/images/dakanji/icon.png");
    // find all elements from the word list in the database
    List<JMdict> entries = await wordListEntries(["rus", "eng", "ger"]);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        orientation: pw.PageOrientation.landscape,
        margin: pw.EdgeInsets.all(32),
        footer: (context) {
          return pdfFooter(context, dakanjiLogo);
        },
        build: (pw.Context context) {
          return [
            for (JMdict entry in entries)
              ...[
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // translations
                    pw.Expanded(
                      child: pw.Table(
                        children: [
                          for (LanguageMeanings language in entry.meanings)
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  language.language ?? "None",
                                  style: notoStyle,
                                  maxLines: 1
                                ),
                                pw.Text(
                                  language.meanings!.join(", "),
                                  style: notoStyle,
                                  maxLines: 1
                                )
                              ]
                            )
                        ]
                      )
                    ),
                    // japanese
                    pw.Expanded(
                      child: pw.Text(
                        entry.kanjis.join("、"),
                        style: notoStyle
                      )
                    )
                  ]
                ),
                pw.Divider(),
              ]
          ];
        }
      )
    );

    return pdf;

  }

}