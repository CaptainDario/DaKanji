import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



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
  final TextSelection? initialSelection;
  final TextStyle? style;
  /// the color that should be used when selecting text
  final Color selectionColor;
  /// the color for the text selection caret
  final Color caretColor;
  final double caretWidth;
  final bool allowSelection;
  final bool paintTextBoxes;
  final Color textBoxesColor;
  final void Function(TextSelection)? onSelectionChange;

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
    }
  }

  RenderParagraph? get _renderParagraph => 
    _textKey.currentContext?.findRenderObject() as RenderParagraph;

  void _scheduleTextLayoutUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    widget.onSelectionChange?.call(textSelection);
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
    rubyPositions.clear();

    int cnt = 0;
    for (String t in widget.words) {
      rubyPositions.addAll(_computeSelectionRects(
        TextSelection(baseOffset: cnt, extentOffset: cnt + t.length)
      ));
      cnt += t.length;
    }
    
    setState(() {
      _textBoxRects
        ..clear()
        ..addAll(_computeAllTextBoxRects());
    });
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
        extentOffset: widget.words.join().length,
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

  @override
  Widget build(BuildContext context) {

    return Listener(
      //onPointerHover: _onMouseMove,
      onPointerDown: (event) {
        tapped++;

        if (multiTapTimer != null) {
          multiTapTimer!.cancel();
        }

        multiTapTimer = Timer(
          const Duration(milliseconds: 200),
          () {
            if (tapped == 1){
            }
            else if (tapped == 2) {
              
                TextPosition tapTextPos = _getTextPositionAtOffset(event.localPosition);
                
                TextSelection sel = TextSelection(baseOffset: 0, extentOffset: 0);
                var cnt = 0;
                for (var text in widget.words) {
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
            else if (tapped >= 3) {
              TextPosition tapTextPos = _getTextPositionAtOffset(event.localPosition);
              
              TextSelection sel = TextSelection(baseOffset: 0, extentOffset: 0);
              var cntStart = 0, cntEnd = 0;
              for (int i = 0; i < widget.words.length; i++) {
                
                // end of paragraph  or  end of text
                if(["\n\n", "\n\t", "\n\r\n\r", "\n", "\t"].contains(widget.words[i]) ||
                  i == widget.words.length-1){

                  // 
                  if(cntStart <= tapTextPos.offset && tapTextPos.offset <= cntEnd){
                    if(i == widget.words.length-1)
                      cntEnd += widget.words[i].length;
                    
                    sel = TextSelection(
                      baseOffset: cntStart,
                      extentOffset: cntEnd
                    );
                    break;
                  }

                  cntStart = cntEnd;

                }
                cntEnd += widget.words[i].length;
              }
              
              _onUserSelectionChange(sel);
            }
            tapped = 0;
          });
      },
      child: Focus(
        onFocusChange: (value) => print(value),
        child: MouseRegion(
          cursor: _cursor,
          child: GestureDetector(
            onPanStart: widget.allowSelection ? _onDragStart : null,
            onPanUpdate: widget.allowSelection ? _onDragUpdate : null,
            onPanEnd: widget.allowSelection ? _onDragEnd : null,
            onPanCancel: widget.allowSelection ? _onDragCancel : null,
            behavior: HitTestBehavior.translucent,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _SelectionPainter(
                      color: widget.selectionColor,
                      rects: _selectionRects,
                    ),
                  ),
                  if (widget.paintTextBoxes)
                    CustomPaint(
                      painter: _SelectionPainter(
                        color: widget.textBoxesColor,
                        rects: _textBoxRects,
                        fill: false,
                      ),
                    ),
                  Text(
                    widget.words.join(widget.addSpaces ? " " : ""),
                    key: _textKey,
                    style: widget.style,
                  ),
                  CustomPaint(
                    painter: _SelectionPainter(
                      color: widget.caretColor,
                      rects: _caretRect != null ? [_caretRect!] : const [],
                    ),
                  ),
                  /*
                  ...List.generate(rubyPositions.length, ((index) {
                    return Positioned(
                      width: rubyPositions[index].right - rubyPositions[index].left,
                      top: rubyPositions[index].top - (rubyPositions[index].bottom - rubyPositions[index].top)/2,
                      left: rubyPositions[index].left,
                      height: (rubyPositions[index].bottom - rubyPositions[index].top)/1.5,
                      child: Container(
                        //.color: Colors.amber,
                        child: Center(
                          child: Text(
                            widget.rubys[index],
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    );
                  })),
                  */
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