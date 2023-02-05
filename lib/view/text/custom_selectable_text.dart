import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


/// Widget that implements custom text selection and furigana rendering
class CustomSelectableText extends StatefulWidget {
  const CustomSelectableText({
    Key? key,
    required this.words,
    required this.rubys,
    this.wordColors,

    this.showRubys = false,
    this.addSpaces = false,
    this.showColors = false,

    this.initialSelection,
    this.selectionColor = Colors.blueAccent,
    this.textColor = Colors.black,
    this.caretColor = Colors.black,
    this.caretWidth = 1,
    this.allowSelection = true,
    this.paintTextBoxes = false,
    this.textBoxesColor = Colors.grey,
    
    this.onSelectionChange,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onTripleTap
  }) : super(key: key);

  /// a list containing all words that should be displayed
  final List<String> words;
  /// a list matching the length of `words` containing all ruby texts to show
  final List<String> rubys;
  /// a list matching `words` in length containing colors in which words
  /// should be rendered
  final List<Color?>? wordColors;


  /// should the rubys be shown or not
  final bool showRubys;
  /// should spaces be added to the text between words
  final bool addSpaces;
  /// should the text be rendered in colors matching the POS
  final bool showColors;

  /// the initial selection of this widget
  final TextSelection? initialSelection;
  /// the color that should be used when selecting text
  final Color selectionColor;
  /// The color in which the text should be rendered
  final Color textColor;
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
  final void Function(TextSelection)? onSelectionChange;
  /// callback that is executed when a single tap is executed on the text
  final void Function(TextSelection)? onTap;
  /// callbach that is executed when a long press is executed on the text
  final void Function(TextSelection)? onLongPress;
  /// callback that is executed when a double tap is executed on the text
  final void Function(TextSelection)? onDoubleTap;
  /// callback that is executed when a triple tap is executed on the text
  final void Function(TextSelection)? onTripleTap;

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
  TextSelection _textSelection = TextSelection(baseOffset: 0, extentOffset: 0);
  /// is the left text selection handles selected
  bool _leftHandleSelected = false;
  /// is the right text selection handles selected
  bool _rightHandleSelected = false;
  /// is the user currently dragging the on the text to select it
  bool _isDragging = false;
  /// the selection caret rect
  Rect? _caretRect;
  /// the cursor to use when hovering over text
  final MouseCursor _cursor = SystemMouseCursors.text;
  /// list containg all positions for the ruby texts
  List<Rect> rubyPositions = []; 

  /// the timer to check for multi taps on the text
  Timer? multiTapTimer;
  /// how many times was tapped on this widget
  num tapped = 0;
  /// Is the pointer for detecing taps currently down
  bool isTapped = false;

  /// matches full and half width punctuations
  static const String punctuations = "。|？|！|\\.|\\!|\\?";
  /// matches japanese ending parantheses
  static const String japaneseParantheses = "』|」";

  static const String anyWhiteSpace = "\\s|　";
  /// Regex that matches a sentence
  RegExp sentenceRegex = RegExp(
    "(?:[^$anyWhiteSpace])+?(?:(?!($punctuations)$japaneseParantheses)$punctuations|\\n|\$)",
    multiLine: true
  );
  /// Regex that matches a paragraph
  RegExp paragraphRegex = RegExp(
    "(?:[^$anyWhiteSpace])+?(?:\\n|\$)",
    multiLine: true
  );

  /// the current split of ruby texts, this is used because when a text breaks
  /// lines in a word the rubys need to be split
  List<String> rubys = [];
  /// a list of all words
  List<String> _words = [];
  /// a list of all words with spaces between them
  final List<String> _wordsWithSpaces = [];
  /// a list of all words, when `widget.addSpaces == true` there are spaces
  /// between all the words, otherwise not
  List<String> get words {
    if (!widget.addSpaces) {
      return _words;
    } else {
      return _wordsWithSpaces;
    }
  }
  set words (List<String> newWords){
    _words = newWords;
    _wordsWithSpaces.clear();
    for (var i = 0; i < _words.length; i++) {
      _wordsWithSpaces.add(_words[i]);
      if (i < _words.length-1) {
        _wordsWithSpaces.add("█");
      }
    }
  }
  
  /// The screen X dimension during the last build
  double lastBuildScreenDimX = 0.0;
  /// The screen Y dimension during the last build
  double lastBuildScreenDimY = 0.0;
  /// true if the dimensions have changed compared to the last frame
  /// false otherwise
  bool dimChanged = false;
  /// Focus node of this widget
  FocusNode focuseNode = FocusNode();
  /// Shortcut bindings
  late final Map<ShortcutActivator, VoidCallback> bindings;



  @override
  void initState() {
    super.initState();
    _textSelection = widget.initialSelection ?? const TextSelection.collapsed(offset: -1);
    _scheduleTextLayoutUpdate();

    /// allow copying the text
    bindings = {
      LogicalKeySet.fromSet(
        {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyC}
      ) : () async => await Clipboard.setData(
        ClipboardData(
          text: words.join().substring(
            _textSelection.start,
            _textSelection.end
            ).replaceAll("█", ""))),
      LogicalKeySet.fromSet(
        {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyA}
      ) : () async => setState(() {
        _textSelection = TextSelection(
          baseOffset: 0, 
          extentOffset: words.join().length
        );
        _updateSelectionDisplay();
      }) 
      
    };
  }

  @override
  void didUpdateWidget(CustomSelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // if the displayed text, widget dimensions, rubys/space-option changed
    // recalculate the furigana
    if (widget.words != oldWidget.words
      || dimChanged
      || widget.showRubys != oldWidget.showRubys
      || widget.addSpaces != oldWidget.addSpaces) {
      _textBoxRects.clear();
      _selectionRects.clear();
      _textSelection = const TextSelection.collapsed(offset: -1);
      _caretRect = null;
      _scheduleTextLayoutUpdate();
      words = widget.words;
      dimChanged = false;
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

  /// User started dragging on the text
  void _onDragStart(DragStartDetails details) {
    if(_leftHandleSelected || _rightHandleSelected) return;
    _isDragging = true;

    setState(() {
      int offset = _getTextPositionAtOffset(details.localPosition).offset;
      _textSelection = TextSelection.collapsed(offset: offset);
      _onUserSelectionChange(_textSelection);
    });
  }

  /// User updated an existing drag on the text
  void _onDragUpdate(DragUpdateDetails details) {
    if(_leftHandleSelected)
      _textSelection = TextSelection(
        baseOffset:   _getTextPositionAtOffset(details.localPosition).offset,
        extentOffset: _textSelection.extentOffset 
      );
    else  
      _textSelection = TextSelection(
        baseOffset:   _textSelection.baseOffset,
        extentOffset: _getTextPositionAtOffset(details.localPosition).offset,
      );

    print("dragging");

    setState(() {
      _onUserSelectionChange(_textSelection);
    });
  }

  /// User ended a drag
  void _onDragEnd(DragEndDetails details) {
    if(_leftHandleSelected || _rightHandleSelected) return;
    _isDragging = false;
    setState(() {});
  }

  void _onUserSelectionChange(TextSelection textSelection) {
    _textSelection = textSelection;
    _updateSelectionDisplay();
    widget.onSelectionChange?.call(_textSelection);
  }

  void _updateSelectionDisplay() {
    setState(() {
      final selectionRects = _computeSelectionRects(_textSelection);
      _selectionRects
        ..clear()
        ..addAll(selectionRects);
      _caretRect = _computeCursorRectForTextOffset(_textSelection.extentOffset);
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
  /// and writes them to `widget.rubys` and `widget.rubyPos`
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
      if(word == "█") {
      
      } 
      else if(charRects.isEmpty || widget.rubys[i] == ""){
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
          if(rectPercentag.isNaN) rectPercentag = 0;
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

  // ignore: unused_element
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

  /// Selects the word (PoS) where `event` happend
  void selectWord(PointerDownEvent event){
    TextPosition tapTextPos = _getTextPositionAtOffset(event.localPosition);

    var cnt = 0;
    for (var text in words) {
      if(cnt + text.length > tapTextPos.offset){
        _textSelection = TextSelection(
          baseOffset: cnt,
          extentOffset: cnt + text.length
        );
        break;
      }

      cnt += text.length;
    }
    
    _onUserSelectionChange(_textSelection);
  }

  /// Selects the sentance in which the position the user tapped is located
  void selectSentence(PointerDownEvent event){
    int tapTextPos = _getTextPositionAtOffset(event.localPosition).offset;

    for (var match in sentenceRegex.allMatches(words.join(""))) {
      if (match.start <= tapTextPos && tapTextPos <= match.end) {
        _textSelection = TextSelection(
          baseOffset: match.start, 
          extentOffset: match.end
        );
        break;
      }
    }
    _onUserSelectionChange(_textSelection);
  }

  /// Selects the paragraph that contains the word where `event` happend
  void selectParagraph(PointerDownEvent event){
    int tapTextPos = _getTextPositionAtOffset(event.localPosition).offset;
    
    for (var match in paragraphRegex.allMatches(words.join(""))) {
      if (match.start <= tapTextPos && tapTextPos <= match.end) {
        _textSelection = TextSelection(
          baseOffset: match.start, 
          extentOffset: match.end
        );
        print("paragraph");
        break;
      }
    }
    _onUserSelectionChange(_textSelection);
  }

  @override
  Widget build(BuildContext context) {

    return Listener(
      onPointerDown: (event) {
        // assure that words are in the text fields AND 
        if(words.length == 0 || _leftHandleSelected || _rightHandleSelected) return;

        tapped++; isTapped = true;
    
        if (multiTapTimer != null) {
          multiTapTimer!.cancel();
        }
    
        multiTapTimer = Timer(
          const Duration(milliseconds: 200),
          () {
            if(_isDragging)return;
            
            if (tapped == 1 && !isTapped){
              selectWord(event);
              if(widget.onTap != null) widget.onTap!(_textSelection);
            }
            else if (tapped == 1 && isTapped){
              selectWord(event);
              if(widget.onLongPress != null) widget.onLongPress!(_textSelection);
            }
            else if (tapped == 2){
              selectSentence(event);
              if(widget.onDoubleTap != null) widget.onDoubleTap!(_textSelection);
            }
            else if (tapped >= 3){
              selectParagraph(event);
              if(widget.onTripleTap != null) widget.onTripleTap!(_textSelection);
            }
            tapped = 0;
          }
        );
      },
      onPointerUp: (event) => isTapped = false,
      child: Focus(
        focusNode: focuseNode,
        canRequestFocus: true,
        onKey: (node, event) {
          KeyEventResult result = KeyEventResult.ignored;
          // Activates all key bindings that match, returns handled if any handle it.
          for (final ShortcutActivator activator in bindings.keys) {
            if (activator.accepts(event, RawKeyboard.instance)) {
              bindings[activator]!.call();
              result = KeyEventResult.handled;
            }
          }
          return result;
        },
        child: MouseRegion(
          cursor: _cursor,
          child: GestureDetector(
            onPanStart: widget.allowSelection ? _onDragStart : null,
            onPanUpdate: widget.allowSelection ? _onDragUpdate : null,
            onPanEnd: widget.allowSelection ? _onDragEnd : null,
            onTap: () {
              focuseNode.requestFocus();
            },
            behavior: HitTestBehavior.translucent,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if(lastBuildScreenDimX != constraints.maxWidth ||
                      lastBuildScreenDimY != constraints.maxHeight){
                      lastBuildScreenDimX = constraints.maxWidth;
                      lastBuildScreenDimY = constraints.maxHeight;
                      dimChanged = true;
                    }
                    return Stack(
                      clipBehavior: Clip.none,
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
                        RichText(
                          key: _textKey,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              height: widget.showRubys ? 2.0 : 1.4,
                            ),
                            children: () {
                              List<TextSpan> ret = [];
                              int cnt = 0;
                              for (var word in words) {
                                ret.add(
                                  TextSpan(
                                    text: word.replaceAll("█", " "),
                                    style: TextStyle(
                                      color: widget.showColors 
                                      && widget.wordColors != null
                                      && word != "█"
                                        ? widget.wordColors![cnt]
                                        : widget.textColor
                                    )
                                  )
                                );
                                if(word != "█"){
                                  cnt++;
                                }
                              }
                              return ret;
                            } ()
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
                              top: rubyPositions[index].top -
                                (rubyPositions[index].bottom - rubyPositions[index].top)/1.75,
                              left: rubyPositions[index].left,
                              height: (rubyPositions[index].bottom - rubyPositions[index].top)/1.5,
                              child: FittedBox(
                                child: Container(
                                  decoration: widget.paintTextBoxes ? BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent)
                                  ) : null,
                                  child: Center(
                                    child: Text(
                                      rubys[index],
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: widget.textColor
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            );
                          })),
                        // the text selection handles (left)
                        if(_selectionRects.isNotEmpty)
                          Positioned(
                            left: _selectionRects.first.left - 10,
                            top: _selectionRects.first.top - 10,
                            child: Listener(
                              onPointerDown: (event) => _leftHandleSelected = true,
                              onPointerUp: (event) => _leftHandleSelected = false,
                              child: Container(
                                height: 20,
                                width:  20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1000000)
                                  ),
                                  color: widget.selectionColor,
                                ),
                              ),
                            ),
                          ),
                        // the text selection handles (right)
                        if(_selectionRects.isNotEmpty)
                          Positioned(
                            left: _selectionRects.last.right - 10,
                            top: _selectionRects.last.bottom-10,
                            child: Listener(
                              onPointerDown: (event) => _rightHandleSelected = true,
                              onPointerUp: (event) => _rightHandleSelected = false,
                              child: Container(
                                height: 20,
                                width:  20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1000000)
                                  ),
                                  color: widget.selectionColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom paint to draw rectangles, it is used to draw the text selection,
/// boxes and the cursor rect
class _SelectionPainter extends CustomPainter {
  /// Should the rectangles be filled
  final bool _fill;
  /// The list of rectangles that should be drawn
  final List<Rect> _rects;
  /// The color with which the rectanlges should be painted
  final Paint _paint;


  _SelectionPainter(
    {
      required Color color,
      required List<Rect> rects,
      bool fill = true,
    }
  ) : 
    _rects = rects,
    _fill = fill,
    _paint = Paint()..color = color;


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