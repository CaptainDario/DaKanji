import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



/// Widget that implements custom text selection and furigana rendering
class CustomSelectableText extends StatefulWidget {
  const CustomSelectableText({
    Key? key,
    required this.words,
    required this.rubys,
    this.showRubys = false,
    this.addSpaces = false,
    this.width,
    this.height,
    this.initialSelection,
    this.style,
    this.selectionColor = Colors.blueAccent,
    this.caretColor = Colors.black,
    this.caretWidth = 1,
    this.allowSelection = true,
    this.paintTextBoxes = false,
    this.textBoxesColor = Colors.grey,
    this.onSelectionChange,
  }) : super(key: key);

  /// a list containing all words that should be displayed
  final List<String> words;
  /// a list matching the length of `words` containing all ruby texts to show
  final List<String> rubys;
  /// should the rubys be shown or not
  final bool showRubys;
  /// should spaces be added to the text between words
  final bool addSpaces;
  /// give this widget a fixed width
  final double? width;
  /// give this widget a fixed height
  final double? height;
  /// the initial selection of this widget
  final TextSelection? initialSelection;
  /// text text style used for the main text
  final TextStyle? style;
  /// the color that should be used when selecting text
  final Color selectionColor;
  /// the color of the text selection caret
  final Color caretColor;
  /// the width of the text selection caret
  final double caretWidth;
  /// can the text be selected
  final bool allowSelection;
  /// should boxes be drawn around the text
  final bool paintTextBoxes;
  /// the color of the boxss create by `paintTextBoxes`
  final Color textBoxesColor;
  /// callback that should be executed when the currently selected text chagnes
  /// provides the current selection as parameter
  final void Function(String)? onSelectionChange;

  @override
  _CustomSelectableTextState createState() => _CustomSelectableTextState();
}

class _CustomSelectableTextState extends State<CustomSelectableText> {

  /// global key to access the render paragraph
  final _textKey = GlobalKey();
  /// list with all rects for the texts
  final _textBoxRects = <Rect>[];
  /// list with selection rects
  final _selectionRects = <Rect>[];
  /// the current text selection
  TextSelection? _textSelection;
  /// the current selection base offset
  int? _selectionBaseOffset;
  /// the selection caret rect
  Rect? _caretRect;
  /// the cursor to use when hovering over text
  MouseCursor _cursor = SystemMouseCursors.text;
  /// list containg all positions for the ruby texts
  List<Rect> rubyPositions = []; 
  /// the timer to check for multi taps on the text
  Timer? multiTapTimer;
  /// how many times was tapped on this widget
  num tapped = 0;
  /// the current split of ruby texts, this is used because when a text breaks
  /// lines in a word the rubys need to be split
  List<String> rubys = [];
  /// a list of all words
  List<String> _words = [];
  /// a list of all words with spaces between them
  List<String> _wordsWithSpaces = [];
  /// a list of all words, when `widget.addSpaces == true` there are spaces
  /// between all the words, otherwise not
  List<String> get words {
    if (!widget.addSpaces) return _words;
    else return _wordsWithSpaces;
  }
  set words (List<String> newWords){
    _words = newWords;
    _wordsWithSpaces.clear();
    for (var i = 0; i < _words.length; i++) {
      _wordsWithSpaces.add(_words[i]);
      if (i < _words.length-1)
        	_wordsWithSpaces.add(" ");
    }
  }



  @override
  void initState() {
    super.initState();
    _textSelection = widget.initialSelection ?? TextSelection.collapsed(offset: -1);
    _scheduleTextLayoutUpdate();
  }

  @override
  void didUpdateWidget(CustomSelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.words != oldWidget.words) {
      _textBoxRects.clear();
      _selectionRects.clear();
      _textSelection = TextSelection.collapsed(offset: -1);
      _caretRect = null;
      _scheduleTextLayoutUpdate();
      words = widget.words;
    }
  }

  RenderParagraph? get _renderParagraph => 
    _textKey.currentContext?.findRenderObject()  as RenderParagraph;

  void _scheduleTextLayoutUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      recalculateRubys();
      _updateVisibleTextBoxes();
      _updateSelectionDisplay();
    });
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _selectionBaseOffset = _getTextPositionAtOffset(details.localPosition).offset;
      _onUserSelectionChange(TextSelection.collapsed(
        offset: _selectionBaseOffset != null ? _selectionBaseOffset! : 0
      ));
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      final selectionExtentOffset = _getTextPositionAtOffset(details.localPosition).offset;
      final textSelection = TextSelection(
        baseOffset: _selectionBaseOffset != null ? _selectionBaseOffset! : 0,
        extentOffset: selectionExtentOffset,
      );

      _onUserSelectionChange(textSelection);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _selectionBaseOffset = null;
    });
  }

  void _onDragCancel() {
    setState(() {
      _selectionBaseOffset = null;
      _onUserSelectionChange(TextSelection.collapsed(offset: 0));
    });
  }

  void _onUserSelectionChange(TextSelection textSelection) {
    _textSelection = textSelection;
    _updateSelectionDisplay();
    int start = min(_textSelection!.baseOffset, _textSelection!.extentOffset);
    int end = max(_textSelection!.baseOffset, _textSelection!.extentOffset);
    widget.onSelectionChange?.call(
      words.join().substring(start, end)
    );
  }

  void _updateSelectionDisplay() {
    setState(() {
      final selectionRects = _computeSelectionRects(_textSelection);
      _selectionRects
        ..clear()
        ..addAll(selectionRects);
      _caretRect = _textSelection != null ? 
        _computeCursorRectForTextOffset(_textSelection!.extentOffset) : 
        null;
    });
  }

  void _updateVisibleTextBoxes() {
    
    setState(() {
      _textBoxRects
        ..clear()
        ..addAll(_computeAllTextBoxRects());
    });
  }

  /// Recalculates all rubys and the rubyPositions
  /// and writes them to `widget.rubyss` and `widget.rubyPos`
  void recalculateRubys(){
    rubyPositions.clear();
    rubys.clear();

    int cnt = 0, i = 0;
    for (String word in words) {

      // get the rect surrounding the current word (this COULD span more than one line)
      List<Rect> charRects = _computeSelectionRects(
        TextSelection(baseOffset: cnt, extentOffset: cnt + word.length)
      );

      // skip spaces
      if(word == " ");

      // empty 
      else if(charRects.length == 0 || widget.rubys[i] == ""){
        rubyPositions.add(Rect.zero);
        rubys.add(widget.rubys[i]);
        i += 1;
      }
      // the text DOES NOT span more than one line
      else if(charRects.length == 1){
        rubyPositions.add(charRects[0]);
        rubys.add(widget.rubys[i]);
        i += 1;
      }
      // the text DOES span more than one line
      else if(charRects.length > 1){
        // calculate the total width of all boxs summed
        double totalWidth = charRects.fold(
          0, (value, element) => value + element.width
        );
        
        // remove the original split ruby text
        String ruby = widget.rubys[i];
        // split the text into secgtions and add them to the ruby list
        double cumPercent = 0.0;  
        for (Rect rect in charRects) {
          rubyPositions.add(rect);
          double rectPercentag = rect.width / totalWidth;
          String rubySplit = ruby.substring(
            (cumPercent * ruby.length).floor(),
            ((cumPercent + rectPercentag) * ruby.length).ceil(),
          );
          rubys.add(rubySplit);
          cumPercent += rectPercentag;
          
        }
        i += 1;
      }

      cnt += word.length;
    }
  }

  Rect _computeCursorRectForTextOffset(int offset) {
    if (offset < 0) {
      return Rect.zero;
    }
    if (_renderParagraph == null) {
      return Rect.zero;
    }

    final caretOffset = _renderParagraph!.getOffsetForCaret(
      TextPosition(offset: offset),
      Rect.zero,
    );
    final caretHeight = _renderParagraph!.getFullHeightForCaret(
      TextPosition(offset: offset),
    );
    return Rect.fromLTWH(
      caretOffset.dx - (widget.caretWidth / 2),
      caretOffset.dy,
      widget.caretWidth,
      (caretHeight ?? 0.0),
    );
  }

  TextPosition _getTextPositionAtOffset(Offset localOffset) {
    final myBox = context.findRenderObject();
    final textOffset = _renderParagraph!.globalToLocal(localOffset, ancestor: myBox);
    return _renderParagraph!.getPositionForOffset(textOffset);
  }

  bool _isOffsetOverText(Offset localOffset) {
    final rects = _computeAllTextBoxRects();
    for (final rect in rects) {
      if (rect.contains(localOffset)) {
        return true;
      }
    }
    return false;
  }

  List<Rect> _computeAllTextBoxRects() {
    if (_textKey.currentContext == null) {
      return const [];
    }

    if (_renderParagraph == null) {
      return const [];
    }

    return _computeSelectionRects(
      TextSelection(
        baseOffset: 0,
        extentOffset: words.join().length,
      ),
    );

    
  }

  List<Rect> _computeSelectionRects(TextSelection? selection) {
    if (selection == null) {
      return [];
    }
    if (_renderParagraph == null) {
      return [];
    }

    final textBoxes = _renderParagraph!.getBoxesForSelection(selection);
    return textBoxes.map((box) => box.toRect()).toList();
  }

  void tap(PointerDownEvent event){

  }

  void doubleTap(PointerDownEvent event){
    TextPosition tapTextPos = _getTextPositionAtOffset(event.localPosition);
                  
    TextSelection sel = TextSelection(baseOffset: 0, extentOffset: 0);
    var cnt = 0;
    for (var text in words) {
      if(cnt + text.length > tapTextPos.offset){
        sel = TextSelection(
          baseOffset: cnt,
          extentOffset: cnt + text.length
        );
        break;
      }

      cnt += text.length;
    }
    
    _onUserSelectionChange(sel);
  }

  void tripleTap(PointerDownEvent event){
    TextPosition tapTextPos = _getTextPositionAtOffset(event.localPosition);
    
    TextSelection sel = TextSelection(baseOffset: 0, extentOffset: 0);
    var cntStart = 0, cntEnd = 0;
    for (int i = 0; i < words.length; i++) {
      
      // end of paragraph  or  end of text
      if(["\n\n", "\n\t", "\n\r\n\r", "\n", "\t"].contains(words[i]) ||
        i == words.length-1){

        // 
        if(cntStart <= tapTextPos.offset && tapTextPos.offset <= cntEnd){
          if(i == words.length-1)
            cntEnd += words[i].length;
          
          sel = TextSelection(
            baseOffset: cntStart,
            extentOffset: cntEnd
          );
          break;
        }

        cntStart = cntEnd;

      }
      cntEnd += words[i].length;
    }
    
    _onUserSelectionChange(sel);
  }

  @override
  Widget build(BuildContext context) {

    return Listener(
      onPointerDown: (event) {
    
        tapped++;
    
        if (multiTapTimer != null) {
          multiTapTimer!.cancel();
        }
    
        multiTapTimer = Timer(
          const Duration(milliseconds: 200),
          () {
            if (tapped == 1) tap(event);
            else if (tapped == 2) doubleTap(event);
            else if (tapped >= 3) tripleTap(event);
            
            tapped = 0;
          }
        );
        
      },
      child: MouseRegion(
        cursor: _cursor,
        child: GestureDetector(
          onPanStart: widget.allowSelection ? _onDragStart : null,
          onPanUpdate: widget.allowSelection ? _onDragUpdate : null,
          onPanEnd: widget.allowSelection ? _onDragEnd : null,
          onPanCancel: widget.allowSelection ? _onDragCancel : null,
          behavior: HitTestBehavior.translucent,
          child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // text selection
                  CustomPaint(
                    painter: _SelectionPainter(
                      color: widget.selectionColor,
                      rects: _selectionRects,
                    ),
                  ),
                  // text boxes 
                  if (widget.paintTextBoxes)
                    CustomPaint(
                      painter: _SelectionPainter(
                        color: widget.textBoxesColor,
                        rects: _textBoxRects,
                        fill: false,
                      ),
                    ),
                  // the actual text
                  Text(
                    words.join(),
                    key: _textKey,
                    style: TextStyle(
                      fontSize: 20,
                      height: widget.showRubys ? 2.0 : 1.4
                    ),
                  ),
                  // the selection caret
                  CustomPaint(
                    painter: _SelectionPainter(
                      color: widget.caretColor,
                      rects: _caretRect != null ? [_caretRect!] : const [],
                    ),
                  ),
                  // ruby texts
                  if(widget.showRubys)
                    ...List.generate(rubyPositions.length, ((index) {
                      return Positioned(
                        width: rubyPositions[index].right - rubyPositions[index].left,
                        top: rubyPositions[index].top - (rubyPositions[index].bottom - rubyPositions[index].top)/2,
                        left: rubyPositions[index].left,
                        height: (rubyPositions[index].bottom - rubyPositions[index].top)/1.5,
                        child: Container(
                          decoration: widget.paintTextBoxes ? BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                          ) : null,
                          child: Center(
                            child: Text(
                              rubys[index],
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      );
                    })),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionPainter extends CustomPainter {
  _SelectionPainter({
    required Color color,
    required List<Rect> rects,
    bool fill = true,
  })  : _color = color,
        _rects = rects,
        _fill = fill,
        _paint = Paint()..color = color;

  final Color _color;
  final bool _fill;
  final List<Rect> _rects;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    _paint.style = _fill ? PaintingStyle.fill : PaintingStyle.stroke;
    for (final rect in _rects) {
      canvas.drawRect(rect, _paint);
    }
  }

  @override
  bool shouldRepaint(_SelectionPainter other) {
    return true;
  }
}