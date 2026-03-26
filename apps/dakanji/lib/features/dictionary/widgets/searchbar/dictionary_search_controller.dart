import 'package:flutter/material.dart';

class DictionarySearchController extends SearchController {
  // 1. Tags: Matches # or $ and any non-space characters following them.
  // The \S* ensures that as soon as a space is typed, the grey stops.
  static final RegExp tagRegex = RegExp(r"[#$]\S*");

  // 2. TRD Parameters: t, r, and d grouped together.
  static final RegExp trdParamRegex = RegExp(r"[?&][trd]=", caseSensitive: false);

  // 3. Query Parameter: query kept separate.
  static final RegExp queryParamRegex = RegExp(r"[?&]query=", caseSensitive: false);

  // 4. GLOB Wildcards: *, ?, and bracket expressions.
  static final RegExp globRegex = RegExp(r"\*|\?|\[[^\]]*\]?");

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    List<InlineSpan> children = [];

    // Combine the patterns. 
    // IMPORTANT: Params must be matched BEFORE GLOBs so that the 
    // '?' in '?t=' isn't accidentally treated as a GLOB wildcard.
    final combinedRegex = RegExp(
      [
        trdParamRegex.pattern,
        queryParamRegex.pattern,
        tagRegex.pattern,
        globRegex.pattern,
      ].join('|'),
      caseSensitive: false,
    );

    text.splitMapJoin(
      combinedRegex,
      onMatch: (Match match) {
        // Special syntax found -> make it grey
        return _addSpan(
          children,
          match[0]!,
          style?.copyWith(color: Colors.grey, fontWeight: FontWeight.normal),
        );
      },
      onNonMatch: (String text) {
        // Normal text (including spaces) -> default style
        return _addSpan(children, text, style);
      },
    );

    return TextSpan(style: style, children: children);
  }

  String _addSpan(List<InlineSpan> children, String text, TextStyle? style) {
    children.add(TextSpan(text: text, style: style));
    return "";
  }
}