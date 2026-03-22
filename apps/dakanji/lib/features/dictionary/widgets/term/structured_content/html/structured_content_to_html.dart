import 'dart:convert';

/// Main entry point: Renders a list of Yomitan definitions to a portable HTML string.
/// 
/// [compactMode] If true, and if ALL definitions are simple strings, they will
/// be rendered as a single semicolon-separated line (mimicking Yomitan's compact glossary).
String renderDefinitions(List<dynamic> definitions, {bool compactMode = false}) {
  if (definitions.isEmpty) return '';

  final buffer = StringBuffer();
  final count = definitions.length;

  // --- Compact Mode Handling ---
  final isAllStrings = definitions.every((def) => def is String);
  if (compactMode && isAllStrings) {
    final joinedTexts = definitions.map((def) => _escapeHtml(def.toString())).join('; ');
    
    // Yomitan native compact layout wrappers
    buffer.write('<ol class="definition-list" data-count="$count" style="list-style-type: none; padding-left: 0; margin: 0;">');
    buffer.write('<li class="definition-item"><span class="gloss-content" style="display: block;">$joinedTexts</span></li>');
    buffer.write('</ol>');
    return buffer.toString();
  }

  // --- Standard Layout Handling ---
  final listStyle = count == 1 ? 'none' : 'decimal';
  final padding = count == 1 ? '0' : '1.4em';

  // Yomitan native definition list wrapper
  buffer.write(
      '<ol class="definition-list" data-count="$count" style="list-style-type: $listStyle; padding-left: $padding; margin: 0;">');

  for (var def in definitions) {
    bool suppressBullet = false;
    if (def is Map && def['type'] == 'structured-content') {
      final content = def['content'];
      if (content is Map && ['ul', 'ol', 'table', 'div'].contains(content['tag'])) {
        suppressBullet = true;
      }
    }

    String itemStyle = 'margin-bottom: 0.25em;';
    if (suppressBullet) {
      itemStyle += ' list-style-type: none;';
    }

    buffer.write('<li class="definition-item" style="$itemStyle">');
    // Yomitan strictly uses span with display:block for glossary items
    buffer.write('<span class="gloss-content" style="display: block;">');

    // 1. Raw string definition
    if (def is String) {
      buffer.write(_escapeHtml(def));
    } 
    // 2. Structured Content / Image / Text Object
    else if (def is Map) {
      final type = def['type'];

      if (type == 'structured-content') {
        buffer.write(_renderNode(def['content']));
      } else if (type == 'image') {
        buffer.write(_renderRootImage(def));
      } else if (type == 'text') {
        buffer.write(_escapeHtml(def['text']?.toString() ?? ""));
      }
    } 
    // 3. Deinflection Array: ["term", ["rule1", "rule2"]]
    else if (def is List) {
      if (def.length >= 2 && def[0] is String && def[1] is List) {
        final term = _escapeHtml(def[0].toString());
        final rules = (def[1] as List).map((e) => _escapeHtml(e.toString())).join(', ');
        
        buffer.write('<span class="gloss-sc-deinflection">');
        buffer.write('$term &rarr; <span style="font-size: 0.9em; color: var(--text-color-light);">($rules)</span>');
        buffer.write('</span>');
      } else {
        buffer.write(_escapeHtml(def.toString()));
      }
    }

    buffer.write('</span>');
    buffer.write('</li>');
  }

  buffer.write('</ol>');
  
  String ret = buffer.toString();
  ret = ret.replaceAll("\n", "<br/>");

  return ret;
}

/// Recursively parses the structured content AST and dispatches to specific renderers.
String _renderNode(dynamic node) {
  if (node == null) return '';
  if (node is String) return _escapeHtml(node);
  
  if (node is List) {
    return node.map((child) => _renderNode(child)).join('');
  }

  if (node is Map && node.containsKey('tag')) {
    final String tag = node['tag'];

    if (tag == 'ul' || tag == 'ol') return _renderList(node);
    if (tag == 'a') return _renderLink(node);
    if (tag == 'img') return _renderInlineImage(node);
    if (tag == 'table') {
      return '<div class="gloss-sc-table-container">${_renderElement(node)}</div>';
    }
    if (tag == 'br') return '<br>';

    return _renderElement(node);
  }

  return '';
}

/// Renders generic HTML elements (span, div, table, tbody, etc.) dynamically.
String _renderElement(Map node) {
  final tag = node['tag'];
  final buffer = StringBuffer();

  buffer.write('<$tag class="gloss-sc-$tag"');
  _renderAttributes(node, buffer);
  _renderStyles(node, buffer);
  _renderDataAttributes(node, buffer);

  if (tag == 'details' && node['open'] == true) {
    buffer.write(' open');
  }

  buffer.write('>');

  if (node.containsKey('content')) {
    buffer.write(_renderNode(node['content']));
  }

  buffer.write('</$tag>');
  return buffer.toString();
}

/// Renders ordered/unordered lists.
String _renderList(Map node) {
  final tag = node['tag'];
  final buffer = StringBuffer();
  
  const defaultStyles = 'padding-left: 1.4em; margin: 0;';

  buffer.write('<$tag class="gloss-sc-$tag"');
  _renderAttributes(node, buffer);
  
  if (node.containsKey('style') && node['style'] is Map) {
    String css = _mapToCss(node['style']);
    buffer.write(' style="$defaultStyles $css"');
  } else {
    buffer.write(' style="$defaultStyles"');
  }

  _renderDataAttributes(node, buffer);
  buffer.write('>');

  if (node.containsKey('content')) {
    buffer.write(_renderNode(node['content']));
  }

  buffer.write('</$tag>');
  return buffer.toString();
}

/// Renders anchor tags
String _renderLink(Map node) {
  final buffer = StringBuffer();
  final href = node['href']?.toString() ?? '';
  final isInternal = href.startsWith('?');

  buffer.write('<a class="gloss-link"');
  _renderAttributes(node, buffer);
  buffer.write(' data-sc-external="${!isInternal}"');
  _renderStyles(node, buffer);
  buffer.write('>');

  buffer.write('<span class="gloss-link-text">');
  if (node.containsKey('content')) {
    buffer.write(_renderNode(node['content']));
  }
  buffer.write('</span>');

  if (!isInternal) {
    buffer.write('<span class="gloss-link-external-icon icon" style="font-size:0.8em; margin-left:0.2em;">&#x2197;</span>');
  }

  buffer.write('</a>');
  return buffer.toString();
}

/// Renders top-level images
String _renderRootImage(Map node) {
  final sb = StringBuffer();
  final hasDescription = node.containsKey('description') &&
      node['description'] != null &&
      node['description'].toString().isNotEmpty;

  if (hasDescription) sb.write('<figure style="margin:0; display:inline-block;">');

  sb.write(_renderInlineImage(node));

  if (hasDescription) {
    sb.write('<figcaption class="gloss-image-description" style="font-size:0.9em; color:#666;">');
    sb.write(_escapeHtml(node['description']));
    sb.write('</figcaption>');
  }

  if (hasDescription) sb.write('</figure>');
  return sb.toString();
}

/// Renders inline images.
String _renderInlineImage(Map node) {
  final buffer = StringBuffer();
  
  final width = node['preferredWidth'] ?? node['width'];
  final height = node['preferredHeight'] ?? node['height'];
  final sizeUnits = node['sizeUnits'] ?? 'px';

  buffer.write('<img class="gloss-image"');

  if (node.containsKey('path')) {
    buffer.write(' src="${_escapeAttribute(node['path'])}"');
  }

  Map<String, dynamic> styles = {};
  if (node.containsKey('style') && node['style'] is Map) {
    styles.addAll(Map<String, dynamic>.from(node['style']));
  }

  if (sizeUnits == 'em') {
    if (width != null) styles['width'] = '${width}em';
    if (height != null) styles['height'] = '${height}em';
  } else {
    if (width != null) buffer.write(' width="$width"');
    if (height != null) buffer.write(' height="$height"');
  }

  String altText = node['alt'] ?? node['description'] ?? '';
  if (altText.isNotEmpty) buffer.write(' alt="${_escapeAttribute(altText)}"');

  if (node.containsKey('verticalAlign')) styles['vertical-align'] = node['verticalAlign'];
  if (node['pixelated'] == true || node['imageRendering'] == 'pixelated') styles['image-rendering'] = 'pixelated';
  if (node['appearance'] == 'monochrome') styles['filter'] = 'grayscale(100%)';

  if (styles.isNotEmpty) {
     buffer.write(' style="${_mapToCss(styles)}"');
  }

  if (node['collapsed'] == true) buffer.write(' data-sc-collapsed="true"');
  if (node['collapsible'] == true) buffer.write(' data-sc-collapsible="true"');

  buffer.write(' />');
  return buffer.toString();
}

// --- Attribute Helpers ---

void _renderAttributes(Map node, StringBuffer buffer) {
  const attrMap = {
    'href': 'href',
    'title': 'title',
    'lang': 'lang',
    'rowSpan': 'rowspan',
    'colSpan': 'colspan',
    'cellPadding': 'cellpadding',
    'cellSpacing': 'cellspacing',
    'border': 'border',
  };

  attrMap.forEach((jsonKey, htmlAttr) {
    if (node.containsKey(jsonKey)) {
      buffer.write(' $htmlAttr="${_escapeAttribute(node[jsonKey].toString())}"');
    }
  });
}

void _renderStyles(Map node, StringBuffer buffer) {
  if (node.containsKey('style') && node['style'] is Map) {
    String css = _mapToCss(node['style']);
    if (css.isNotEmpty) {
      buffer.write(' style="$css"');
    }
  }
}

void _renderDataAttributes(Map node, StringBuffer buffer) {
  if (node.containsKey('data') && node['data'] is Map) {
    (node['data'] as Map).forEach((k, v) {
      // Yomitan converts camelCase JSON dataset keys to kebab-case HTML dataset attributes.
      final kebabKey = _camelToKebab(k.toString());
      buffer.write(' data-sc-$kebabKey="${_escapeAttribute(v.toString())}"');
    });
  }
}

/// Maps Yomitan's camelCase style properties to standard kebab-case CSS.
String _mapToCss(Map styleMap) {
  if (styleMap.isEmpty) return '';

  final buffer = StringBuffer();
  styleMap.forEach((key, value) {
    if (value != null) {
      final cssKey = _camelToKebab(key); String cssValue = value.toString();

      if (value is List) {
        cssValue = value.join(' ');
      }
      else if (value is num) {
        if (['marginTop', 'marginRight', 'marginBottom', 'marginLeft', 'fontSize'].contains(key)) {
          cssValue = '${value}em';
        }
      }

      buffer.write('$cssKey:$cssValue;');
    }
  });
  return buffer.toString();
}

String _camelToKebab(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
    return '-${match.group(0)!.toLowerCase()}';
  });
}

String _escapeHtml(String text) {
  return const HtmlEscape(HtmlEscapeMode.element).convert(text);
}

String _escapeAttribute(String text) {
  return const HtmlEscape(HtmlEscapeMode.attribute).convert(text);
}