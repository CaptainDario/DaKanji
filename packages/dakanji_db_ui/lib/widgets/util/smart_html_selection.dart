import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SmartHtmlSelection extends StatefulWidget {
  final Widget child;
  final Function(String selectedText)? onTextSelected;
  final TextRange Function(String fullSentence, int clickedIndex)? selectionRangeBuilder;
  final Color selectionColor;

  const SmartHtmlSelection({
    super.key,
    required this.child,
    this.onTextSelected,
    this.selectionRangeBuilder,
    this.selectionColor = const Color(0x4D2196F3),
  });

  @override
  State<SmartHtmlSelection> createState() => _SmartHtmlSelectionState();
}

class _SmartHtmlSelectionState extends State<SmartHtmlSelection> {
  final GlobalKey _anchorKey = GlobalKey();
  List<Rect> _selectionRects = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _anchorKey,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (_) => _clearSelection(),
          onTapUp: _handleTap,
          child: widget.child,
        ),
        ..._selectionRects.map((rect) => Positioned(
              top: rect.top,
              left: rect.left,
              width: rect.width,
              height: rect.height,
              child: IgnorePointer(
                child: Container(color: widget.selectionColor),
              ),
            )),
      ],
    );
  }

  void _clearSelection() {
    if (_selectionRects.isNotEmpty) {
      setState(() => _selectionRects = []);
    }
  }

  void _handleTap(TapUpDetails details) {
    final RenderBox? anchorBox = _anchorKey.currentContext?.findRenderObject() as RenderBox?;
    if (anchorBox == null) return;

    final BoxHitTestResult result = BoxHitTestResult();
    final Offset localPosition = anchorBox.globalToLocal(details.globalPosition);

    if (anchorBox.hitTest(result, position: localPosition)) {
      _ParagraphContext? bestContext;
      int maxTokens = -1;

      for (final HitTestEntry entry in result.path) {
        if (entry.target is RenderParagraph) {
          final RenderParagraph candidate = entry.target as RenderParagraph;
          final List<_TextToken> tokens = _tokenizeParagraph(candidate, anchorBox);
          if (tokens.length > maxTokens) {
            maxTokens = tokens.length;
            bestContext = _ParagraphContext(candidate, tokens);
          }
        }
      }

      if (bestContext != null && bestContext.tokens.isNotEmpty) {
        _processSelection(bestContext, localPosition);
      }
    }
  }

  void _processSelection(_ParagraphContext context, Offset localTapPosition) {
    final tokens = context.tokens;
    final String fullSentence = tokens.map((t) => t.text).join();

    int clickedIndex = -1;
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i].rect.inflate(5.0).contains(localTapPosition)) {
        clickedIndex = i;
        break;
      }
    }

    if (clickedIndex != -1) {
      final TextRange range = widget.selectionRangeBuilder?.call(fullSentence, clickedIndex) ??
          _defaultRangeBuilder(fullSentence, clickedIndex);

      final StringBuffer sb = StringBuffer();
      final List<Rect> rawRects = [];

      final int start = max(0, range.start);
      final int end = min(tokens.length, range.end);

      for (int i = start; i < end; i++) {
        sb.write(tokens[i].text);
        rawRects.add(tokens[i].rect);
      }

      // NO CLAMPING / UNIFYING.
      // We pass the raw "Natural" rects directly to the merger.
      
      // Merge adjacent blocks ONLY if they match in height
      final List<Rect> polishedRects = _mergeRectsRespectingHeight(rawRects);

      setState(() {
        _selectionRects = polishedRects;
      });

      widget.onTextSelected?.call(sb.toString());
    }
  }

  TextRange _defaultRangeBuilder(String text, int index) {
    return TextRange(start: max(0, index - 1), end: min(text.length, index + 2));
  }

  // ---------------------------------------------------------------------------
  // MERGE LOGIC: HEIGHT-SENSITIVE
  // ---------------------------------------------------------------------------

  /// Merges adjacent rects, but ONLY if they are the same height.
  /// This creates the "Jagged" effect where the highlight steps up/down
  /// correctly between Ruby and Normal text.
  List<Rect> _mergeRectsRespectingHeight(List<Rect> rects) {
    if (rects.isEmpty) return [];
    
    // Sort Top-Down, Left-Right
    rects.sort((a, b) {
      final double dy = a.top - b.top;
      if (dy.abs() > 5) return dy.toInt(); 
      return (a.left - b.left).toInt();
    });

    final List<Rect> merged = [];
    Rect current = rects.first;

    for (int i = 1; i < rects.length; i++) {
      final Rect next = rects[i];
      
      // 1. Check vertical alignment (Baseline check)
      // Since heights differ, tops won't align. But bottoms usually align.
      bool bottomsAlign = (next.bottom - current.bottom).abs() < 2.0;
      
      // 2. Check touching horizontally
      bool touching = next.left <= current.right + 1.0;

      // 3. STRICT HEIGHT CHECK
      // Only merge if they are visually the same height (e.g. two normal chars).
      // If one is Tall (Ruby) and one is Short (Normal), DO NOT merge.
      bool sameHeight = (next.height - current.height).abs() < 1.0;

      if (bottomsAlign && touching && sameHeight) {
        current = Rect.fromLTRB(
          min(current.left, next.left),
          min(current.top, next.top),
          max(current.right, next.right),
          max(current.bottom, next.bottom)
        );
      } else {
        merged.add(current);
        current = next;
      }
    }
    merged.add(current);
    return merged;
  }

  // ---------------------------------------------------------------------------
  // TOKENIZER & GEOMETRY (Standard)
  // ---------------------------------------------------------------------------

  List<_TextToken> _tokenizeParagraph(RenderParagraph renderParagraph, RenderBox anchorBox) {
    final List<_TextToken> tokens = [];
    final InlineSpan? rootSpan = renderParagraph.text;
    final List<RenderBox> rubyChildren = _getRenderChildren(renderParagraph);
    int rubyIndex = 0;

    if (rootSpan is TextSpan) {
      int textOffset = 0;
      rootSpan.visitChildren((span) {
        if (span is TextSpan && span.text != null) {
          final String text = span.text!;
          for (int i = 0; i < text.length; i++) {
            final List<TextBox> boxes = renderParagraph.getBoxesForSelection(
                TextSelection(baseOffset: textOffset + i, extentOffset: textOffset + i + 1));
            if (boxes.isNotEmpty) {
              tokens.add(_TextToken(
                text[i],
                _toAnchorRect(renderParagraph, boxes.first, anchorBox),
              ));
            }
          }
          textOffset += text.length;
        } else if (span is WidgetSpan) {
          if (rubyIndex < rubyChildren.length) {
            final RenderBox widgetBox = rubyChildren[rubyIndex];
            String extracted = _extractTextGeometrically(widgetBox);
            if (extracted.isEmpty) extracted = " ";
            final List<TextBox> boxes = renderParagraph.getBoxesForSelection(
                TextSelection(baseOffset: textOffset, extentOffset: textOffset + 1));
            if (boxes.isNotEmpty) {
              tokens.add(_TextToken(
                extracted,
                _toAnchorRect(renderParagraph, boxes.first, anchorBox),
                isWidget: true,
              ));
            }
            rubyIndex++;
          }
          textOffset += 1;
        }
        return true;
      });
    }
    return tokens;
  }

  String _extractTextGeometrically(RenderObject root) {
    final List<_GeoNode> nodes = [];
    _collectGeoNodes(root, 0.0, nodes);
    if (nodes.isEmpty) return "";
    nodes.sort((a, b) => b.yOffset.compareTo(a.yOffset));
    final double bottomMostY = nodes.first.yOffset;
    final baseLayer = nodes.where((n) => (n.yOffset - bottomMostY).abs() < 5.0).toList();
    return baseLayer.map((n) => n.text).join();
  }

  void _collectGeoNodes(RenderObject object, double currentY, List<_GeoNode> out) {
    if (object is RenderParagraph) {
      final String text = object.text.toPlainText();
      if (text.isNotEmpty) out.add(_GeoNode(text, currentY));
      return;
    }
    object.visitChildren((child) {
      double childY = currentY;
      if (child is RenderBox) {
        final parentData = child.parentData;
        if (parentData is BoxParentData) childY += parentData.offset.dy;
      }
      _collectGeoNodes(child, childY, out);
    });
  }

  List<RenderBox> _getRenderChildren(RenderParagraph paragraph) {
    final List<RenderBox> children = [];
    paragraph.visitChildren((child) {
      if (child is RenderBox) children.add(child);
    });
    return children;
  }

  Rect _toAnchorRect(RenderParagraph para, TextBox box, RenderBox anchor) {
    final Offset global = para.localToGlobal(Offset(box.left, box.top), ancestor: anchor);
    return Rect.fromLTWH(global.dx, global.dy, box.right - box.left, box.bottom - box.top);
  }
}

class _ParagraphContext {
  final RenderParagraph paragraph;
  final List<_TextToken> tokens;
  _ParagraphContext(this.paragraph, this.tokens);
}

class _TextToken {
  final String text;
  final Rect rect;
  final bool isWidget;
  _TextToken(this.text, this.rect, {this.isWidget = false});
}

class _GeoNode {
  final String text;
  final double yOffset;
  _GeoNode(this.text, this.yOffset);
}