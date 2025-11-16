import 'package:csslib/parser.dart' as css_parser;
import 'package:csslib/visitor.dart' as css_visitor;

/// Converts Yomitan Structured Content JSON into a single HTML string
/// with all styles inlined, for use with flutter_widget_from_html.
class YomitanParser {
  final Map<String, Map<String, String>> _cssRules = {};

  /// Parses an external CSS string and prepares it for style inlining.
  ///
  /// [cssString] A string containing CSS rules.
  void addExternalCss(String cssString) {
    try {
      final styleSheet = css_parser.parse(cssString);
      final visitor = _CssRuleVisitor();
      styleSheet.visit(visitor);
      _cssRules.addAll(visitor.rules);
    } catch (e) {
      print('Error parsing CSS: $e');
    }
  }

  /// Converts a Yomitan structured content object (decoded from JSON)
  /// into an HTML string.
  ///
  /// [scNode] The structured content node, typically a `Map<String, dynamic>`
  ///          or a `List`.
  ///
  /// Returns a portable HTML string with all styles inlined.
  String convert(dynamic scNode) {
    final buffer = StringBuffer();
    _convertNodeToHtml(scNode, buffer);
    return buffer.toString();
  }

  /// Recursive helper to build the HTML string.
  void _convertNodeToHtml(
    dynamic node,
    StringBuffer buffer,
  ) {
    if (node == null) {
      return;
    }

    if (node is String) {
      // Base case: just text. Escape it.
      buffer.write(_escapeHtml(node));
      return;
    }

    if (node is List) {
      // It's a list of children; process each one.
      for (final child in node) {
        _convertNodeToHtml(child, buffer);
      }
      return;
    }

    if (node is Map<String, dynamic>) {
      // It's an HTML element.
      final tag = node['tag'] as String? ?? 'span';
      final attributes = <String, String>{};
      final inlineStyles = <String, String>{};

      // --- 1. Find matching external CSS rules ---
      final matchingRule = _findMatchingCssRule(node);
      if (matchingRule != null) {
        inlineStyles.addAll(matchingRule);
      }

      // --- 2. Add inline styles from the JSON 'style' object ---
      // These will override any external CSS.
      if (node['style'] is Map) {
        (node['style'] as Map).forEach((key, value) {
          // Convert camelCase to kebab-case
          final cssKey =
              key.replaceAllMapped(RegExp(r'[A-Z]'), (m) => '-${m[0]!.toLowerCase()}');
          inlineStyles[cssKey] = value.toString();
        });
      }

      // --- 3. Add other attributes from the JSON. ---
      node.forEach((key, value) {
        if (value == null) return;
        
        switch (key) {
          case 'tag':
          case 'style':
          case 'content':
            // These are handled separately and not added as attributes.
            break;
          case 'data':
            // Convert "data": {"code": "n"} to data-code="n"
            if (value is Map) {
              value.forEach((dataKey, dataValue) {
                // Store the RAW value. Escaping happens at write time.
                attributes['data-$dataKey'] = dataValue.toString();
              });
            }
            break;
          default:
            // Standard attributes like 'title', 'lang', 'href'
            // Store the RAW value. Escaping happens at write time.
            attributes[key] = value.toString();
        }
      });

      // --- HTML Tag Assembly ---
      buffer.write('<$tag');

      // Add collected attributes
      attributes.forEach((key, value) {
        // Apply quotes and escaping here, at the very end.
        buffer.write(' $key="${_escapeHtml(value)}"');
      });

      // Add collected styles
      if (inlineStyles.isNotEmpty) {
        final styleString = inlineStyles.entries
            .map((e) => '${e.key}:${e.value}')
            .join(';');
        // ESCAPE the entire style string to handle quotes in values
        buffer.write(' style="${_escapeHtml(styleString)}"');
      }

      // Get the content for this node
      final content = node['content'];
      if (content == null) {
        // Self-closing tag
        buffer.write('/>');
      } else {
        // Tag with content
        buffer.write('>');
        // Handle special case: <ruby> tag
        // Content is [base, rt, base2, rt2, ...]
        if (tag == 'ruby' && content is List) {
          for (int i = 0; i < content.length; i++) {
            if (i + 1 < content.length &&
                content[i + 1] is Map &&
                content[i + 1]['tag'] == 'rt') {
              // Found a base-rt pair
              // Process base
              _convertNodeToHtml(content[i], buffer);
              // Process rt
              _convertNodeToHtml(content[i + 1], buffer);
              i++; // Skip the 'rt' tag on the next iteration
            } else {
              // Just a base, no 'rt'
              _convertNodeToHtml(content[i], buffer);
            }
          }
        } else {
          // Standard content
          _convertNodeToHtml(content, buffer);
        }
        // Closing tag
        buffer.write('</$tag>');
      }
    }
  }

  /// Finds the first matching CSS rule for a given node.
  /// NOTE: This is a simplified matcher and only supports
  /// tag[data-attr='value'] selectors.
  Map<String, String>? _findMatchingCssRule(Map<String, dynamic> node) {
    final tag = node['tag'] as String? ?? 'span';

    for (final selector in _cssRules.keys) {
      // Simple case: tag only
      if (selector == tag) {
        return _cssRules[selector];
      }

      // Case: tag[data-attr='value']
      // Example: ul[data-sc-content='glossary']
      if (selector.startsWith('$tag[') && selector.endsWith(']')) {
        final attrMatch = RegExp(r"\[data-([^=]+)='([^']+)'\]").firstMatch(selector);
        if (attrMatch != null) {
          final attrName = attrMatch.group(1); // e.g., "sc-content"
          final attrValue = attrMatch.group(2); // e.g., "glossary"

          if (attrName == null || attrValue == null) continue;

          // Check against the node's data attributes
          if (node['data'] is Map) {
            final data = node['data'] as Map;
            
            // Check for "sc-content"
            bool found = data[attrName] == attrValue;

            // Check for "content" (Yomitan's 'sc-' prefix)
            if (!found && attrName.startsWith('sc-')) {
              final shortAttrName = attrName.substring(3); // "content"
              found = data[shortAttrName] == attrValue;
            }

            if (found) {
              return _cssRules[selector];
            }
          }
        }
      }
    }
    return null;
  }

  /// Simple HTML escaper for attributes and text content.
  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }
}

/// A visitor for the csslib AST to extract simple rules.
class _CssRuleVisitor extends css_visitor.Visitor {
  /// Stores rules as `{"selector": {"property": "value"}}`
  final Map<String, Map<String, String>> rules = {};
  Map<String, String> _currentDeclarations = {};
  String _currentSelector = '';

  @override
  void visitRuleSet(css_visitor.RuleSet node) {
    // Reset declarations for this new ruleset
    _currentDeclarations = {};
    _currentSelector = node.selectorGroup?.selectors
            ?.map((s) => s.span?.text ?? '')
            .join(', ') ??
        '';

    // Visit declarations (properties and values)
    node.declarationGroup?.visit(this);

    if (_currentSelector.isNotEmpty && _currentDeclarations.isNotEmpty) {
      rules[_currentSelector] = _currentDeclarations;
    }
  }

  @override
  void visitDeclaration(css_visitor.Declaration node) {
    final property = node.property;
    final expression = node.expression;
    if (expression == null) return;

    // *** THIS IS THE CORRECT FIX ***
    // Check if it's an Expressions object (a list of terms)
    if (expression is css_parser.Expressions) {
      // Manually join the text of all terms in the expression.
      // This will correctly build "#ffff00" from its component terms.
      final value =
          expression.expressions.map((e) => e.span?.text ?? '').join();

      if (value.isNotEmpty) {
        _currentDeclarations[property] = value;
      }
    } else if (expression.span?.text != null) {
      // Fallback for simple expressions
      _currentDeclarations[property] = expression.span!.text;
    }
  }
}