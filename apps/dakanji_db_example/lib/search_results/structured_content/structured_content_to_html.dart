const Set<String> _voidElements = {
  'area',
  'base',
  'br',
  'col',
  'embed',
  'hr',
  'img',
  'input',
  'link',
  'meta',
  'param',
  'source',
  'track',
  'wbr',
};

const Map<String, String> _styleNameOverrides = {
  'backgroundColor': 'background-color',
  'backgroundImage': 'background-image',
  'borderColor': 'border-color',
  'borderRadius': 'border-radius',
  'borderStyle': 'border-style',
  'borderWidth': 'border-width',
  'fontStyle': 'font-style',
  'fontWeight': 'font-weight',
  'fontSize': 'font-size',
  'textAlign': 'text-align',
  'textEmphasis': 'text-emphasis',
  'textShadow': 'text-shadow',
  'textDecorationLine': 'text-decoration',
  'textDecorationStyle': 'text-decoration-style',
  'textDecorationColor': 'text-decoration-color',
  'verticalAlign': 'vertical-align',
  'listStyleType': 'list-style-type',
  'whiteSpace': 'white-space',
  'wordBreak': 'word-break',
  'imageRendering': 'image-rendering',
  'clipPath': 'clip-path',
};

const Set<String> _numericEmKeys = {
  'margin',
  'marginTop',
  'marginLeft',
  'marginRight',
  'marginBottom',
  'padding',
  'paddingTop',
  'paddingLeft',
  'paddingRight',
  'paddingBottom',
  'borderRadius',
  'borderWidth',
};

const Set<String> _reservedKeys = {
  'tag',
  'type',
  'style',
  'data',
  'content',
  'lang',
  'title',
  'open',
  'colSpan',
  'rowSpan',
  'class',
};

/// Serialises Yomitan structured-content data into HTML that mirrors
/// Yomitan's DOM layout.
class YomitanParser {
  /// Converts the structured content payload into a Yomitan-like HTML snippet.
  String convert(dynamic structuredContent) {
    final buffer = StringBuffer();
    buffer.write('<span class="structured-content">');
    _appendContent(buffer, structuredContent, null);
    buffer.write('</span>');
    return buffer.toString();
  }

  void _appendContent(StringBuffer buffer, dynamic content, String? language) {
    if (content == null) {
      return;
    }

    if (content is String) {
      if (content.isNotEmpty) {
        buffer.write(_escapeHtml(content));
      }
      return;
    }

    if (content is List) {
      for (final item in content) {
        _appendContent(buffer, item, language);
      }
      return;
    }

    if (content is Map<String, dynamic>) {
      final type = content['type'];
      if (type == 'structured-content') {
        _appendContent(buffer, content['content'], language);
        return;
      }
      if (type == 'text') {
        final text = content['text'];
        if (text is String && text.isNotEmpty) {
          buffer.write(_escapeHtml(text));
        }
        return;
      }
      if (type == 'image') {
        _appendDefinitionImage(buffer, content);
        return;
      }
      if (content.containsKey('tag')) {
        _appendElement(buffer, content, language);
      }
    }
  }

  void _appendElement(
    StringBuffer buffer,
    Map<String, dynamic> element,
    String? inheritedLanguage,
  ) {
    final tag = element['tag'] as String? ?? 'span';

    switch (tag) {
      case 'a':
        _appendLinkElement(buffer, element, inheritedLanguage);
        return;
      case 'table':
        buffer.write('<div class="gloss-sc-table-container">');
        _appendStandardElement(buffer, element, inheritedLanguage);
        buffer.write('</div>');
        return;
      case 'img':
        _appendDefinitionImage(buffer, element);
        return;
      default:
        _appendStandardElement(buffer, element, inheritedLanguage);
        return;
    }
  }

  void _appendLinkElement(
    StringBuffer buffer,
    Map<String, dynamic> element,
    String? inheritedLanguage,
  ) {
    final hrefValue = element['href']?.toString() ?? '';
    final isInternal = hrefValue.startsWith('?');

    final attributes = <String, String>{
      'class': 'gloss-link',
      'data-external': (!isInternal).toString(),
    };
    if (hrefValue.isNotEmpty) {
      attributes['href'] = hrefValue;
    }

    final langValue = element['lang'];
    String? language = inheritedLanguage;
    if (langValue is String && langValue.isNotEmpty) {
      attributes['lang'] = langValue;
      language = langValue;
    }

    buffer
      ..write('<a')
      ..write(_serialiseAttributes(attributes, const {}))
      ..write('>');

    buffer.write('<span class="gloss-link-text">');
    _appendContent(buffer, element['content'], language);
    buffer.write('</span>');

    if (!isInternal) {
      buffer.write(
        '<span class="gloss-link-external-icon icon" data-icon="external-link"></span>',
      );
    }

    buffer.write('</a>');
  }

  void _appendStandardElement(
    StringBuffer buffer,
    Map<String, dynamic> element,
    String? inheritedLanguage,
  ) {
    final tag = element['tag'] as String? ?? 'span';
    final classNames = <String>{'gloss-sc-$tag'};
    final attributes = <String, String>{};
    final booleanAttributes = <String>{};

    final classValue = element['class'];
    if (classValue is String && classValue.trim().isNotEmpty) {
      classNames.addAll(
        classValue.split(RegExp(r'\s+')).where((value) => value.isNotEmpty),
      );
    } else if (classValue is List) {
      for (final item in classValue) {
        if (item is String && item.isNotEmpty) {
          classNames.add(item);
        }
      }
    }

    if (classNames.isNotEmpty) {
      attributes['class'] = classNames.join(' ');
    }

    String? language = inheritedLanguage;
    final langValue = element['lang'];
    if (langValue is String && langValue.isNotEmpty) {
      attributes['lang'] = langValue;
      language = langValue;
    }

    final title = element['title'];
    if (title is String && title.isNotEmpty) {
      attributes['title'] = title;
    }

    if (element['open'] == true) {
      booleanAttributes.add('open');
    }

    final colSpan = element['colSpan'];
    if (colSpan is num) {
      attributes['colspan'] = colSpan.toString();
    }

    final rowSpan = element['rowSpan'];
    if (rowSpan is num) {
      attributes['rowspan'] = rowSpan.toString();
    }

    final data = element['data'];
    if (data is Map) {
      data.forEach((key, value) {
        if (value == null) {
          return;
        }
        attributes[_datasetAttributeName(key.toString())] = value.toString();
      });
    }

    final styleMap = element['style'];
    if (styleMap is Map) {
      final styleValue = _serialiseStyle(styleMap.cast<String, dynamic>());
      if (styleValue.isNotEmpty) {
        attributes['style'] = styleValue;
      }
    }

    element.forEach((key, value) {
      if (value == null) {
        return;
      }
      if (_reservedKeys.contains(key)) {
        return;
      }

      if (value is bool) {
        if (value) {
          booleanAttributes.add(_attributeName(key));
        }
        return;
      }

      attributes[_attributeName(key)] = value.toString();
    });

    buffer
      ..write('<$tag')
      ..write(_serialiseAttributes(attributes, booleanAttributes));

    final content = element['content'];
    final isVoid = _voidElements.contains(tag);

    if (content == null && isVoid) {
      buffer.write('/>');
      return;
    }

    buffer.write('>');
    _appendContent(buffer, content, language);
    buffer.write('</$tag>');
  }

  void _appendDefinitionImage(
    StringBuffer buffer,
    Map<String, dynamic> element,
  ) {
    final path = element['path']?.toString();
    final width = _toDouble(element['width']) ?? 100.0;
    final height = _toDouble(element['height']) ?? 100.0;
    final preferredWidth = _toDouble(element['preferredWidth']);
    final preferredHeight = _toDouble(element['preferredHeight']);
    final title = element['title']?.toString();
    final pixelated = element['pixelated'] == true;
    final imageRendering = element['imageRendering']?.toString();
    final appearance = element['appearance']?.toString();
    final background = element['background'];
    final collapsed = element['collapsed'];
    final collapsible = element['collapsible'];
    final verticalAlign = element['verticalAlign']?.toString();
    final border = element['border']?.toString();
    final borderRadius = element['borderRadius']?.toString();
    final sizeUnits = element['sizeUnits']?.toString();

    final invAspectRatio = () {
      if (preferredWidth != null &&
          preferredHeight != null &&
          preferredWidth != 0) {
        return preferredHeight / preferredWidth;
      }
      if (width != 0) {
        return height / width;
      }
      return 1.0;
    }();

    final usedWidth = () {
      if (preferredWidth != null) {
        return preferredWidth;
      }
      if (preferredHeight != null) {
        return preferredHeight / invAspectRatio;
      }
      return width;
    }();

    final linkAttributes = <String, String>{
      'class': 'gloss-image-link',
      'target': '_blank',
      'rel': 'noreferrer noopener',
      if (path != null) 'href': path,
      if (path != null) 'data-path': path,
      'data-image-load-state': 'not-loaded',
      'data-has-aspect-ratio': 'true',
      'data-image-rendering':
          imageRendering ?? (pixelated ? 'pixelated' : 'auto'),
      'data-appearance': appearance ?? 'auto',
      'data-background': (background is bool ? background : true).toString(),
      'data-collapsed': (collapsed is bool ? collapsed : false).toString(),
      'data-collapsible': (collapsible is bool ? collapsible : true).toString(),
    };

    if (verticalAlign != null) {
      linkAttributes['data-vertical-align'] = verticalAlign;
    }

    if (sizeUnits != null &&
        (preferredWidth != null || preferredHeight != null)) {
      linkAttributes['data-size-units'] = sizeUnits;
    }

    buffer
      ..write('<a')
      ..write(_serialiseAttributes(linkAttributes, const {}))
      ..write('>');

    final containerStyle = <String, String>{
      'width': '${_formatDouble(usedWidth)}em',
    };
    if (border != null && border.isNotEmpty) {
      containerStyle['border'] = border;
    }
    if (borderRadius != null && borderRadius.isNotEmpty) {
      containerStyle['border-radius'] = borderRadius;
    }

    buffer
      ..write('<span class="gloss-image-container"')
      ..write(
        _serialiseAttributes({
          if (containerStyle.isNotEmpty)
            'style': containerStyle.entries
                .map((entry) => '${entry.key}:${entry.value}')
                .join(';'),
          if (title != null && title.isNotEmpty) 'title': title,
        }, const {}),
      )
      ..write('>');

    final paddingTop = invAspectRatio * 100;
    buffer
      ..write(
        '<span class="gloss-image-sizer" style="padding-top:${_formatDouble(paddingTop)}%"></span>',
      )
      ..write('<span class="gloss-image-background"></span>')
      ..write('<span class="gloss-image-container-overlay"></span>');

    final imgAttributes = <String, String>{
      'class': 'gloss-image',
      'style': 'width:100%;height:100%;',
      'width': _formatDouble(usedWidth),
      'height': _formatDouble(usedWidth * invAspectRatio),
    };
    if (path != null) {
      imgAttributes['src'] = path;
    }
    if (title != null && title.isNotEmpty) {
      imgAttributes['alt'] = title;
    }

    buffer
      ..write('<img')
      ..write(_serialiseAttributes(imgAttributes, const {}))
      ..write('/>');

    buffer.write('</span>');
    buffer.write('<span class="gloss-image-link-text">Image</span>');
    buffer.write('</a>');
  }

  String _serialiseStyle(Map<String, dynamic> style) {
    final entries = <String>[];
    style.forEach((key, value) {
      if (value == null) {
        return;
      }
      final cssName = _styleNameOverrides[key] ?? _attributeName(key);
      final cssValue = _styleValueToString(key, value);
      if (cssValue.isNotEmpty) {
        entries.add('$cssName:$cssValue');
      }
    });
    return entries.join(';');
  }

  String _attributeName(String key) {
    if (key.isEmpty) {
      return key;
    }
    switch (key) {
      case 'colSpan':
        return 'colspan';
      case 'rowSpan':
        return 'rowspan';
      default:
        return _toKebabCase(key);
    }
  }

  String _datasetAttributeName(String key) {
    final normalised = key.isEmpty ? '' : _toKebabCase(key);
    return normalised.isEmpty ? 'data-sc' : 'data-sc-$normalised';
  }

  String _serialiseAttributes(
    Map<String, String> attributes,
    Set<String> booleanAttributes,
  ) {
    final buffer = StringBuffer();
    attributes.forEach((key, value) {
      if (value.isEmpty) {
        return;
      }
      buffer
        ..write(' ')
        ..write(key)
        ..write('="')
        ..write(_escapeAttribute(value))
        ..write('"');
    });

    for (final attribute in booleanAttributes) {
      buffer
        ..write(' ')
        ..write(attribute);
    }

    return buffer.toString();
  }

  String _styleValueToString(String key, dynamic value) {
    if (value == null) {
      return '';
    }

    if (value is List) {
      return value
          .map((item) => _styleValueToString(key, item))
          .where((part) => part.isNotEmpty)
          .join(' ');
    }

    if (value is num) {
      if (_numericEmKeys.contains(key)) {
        return '${_formatDouble(value)}em';
      }
      return _formatDouble(value);
    }

    return value.toString();
  }

  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }

  String _escapeAttribute(String text) {
    return _escapeHtml(text).replaceAll('"', '&quot;').replaceAll("'", '&#39;');
  }

  double? _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  String _formatDouble(num value) {
    var string = value.toStringAsFixed(6);
    string = string.replaceFirst(RegExp(r'0+$'), '');
    if (string.endsWith('.')) {
      string = string.substring(0, string.length - 1);
    }
    if (string.isEmpty) {
      return '0';
    }
    return string;
  }

  String _toKebabCase(String value) {
    if (value.isEmpty) {
      return value;
    }
    final buffer = StringBuffer();
    for (var i = 0; i < value.length; i++) {
      final char = value[i];
      if (_isUpperCaseLetter(char)) {
        if (i > 0 && !_isSeparator(value[i - 1])) {
          buffer.write('-');
        }
        buffer.write(char.toLowerCase());
      } else if (_isSeparator(char)) {
        if (buffer.isNotEmpty && !buffer.toString().endsWith('-')) {
          buffer.write('-');
        }
      } else {
        buffer.write(char);
      }
    }
    var result = buffer.toString();
    result = result.replaceAll(RegExp(r'-{2,}'), '-');
    if (result.endsWith('-')) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  bool _isUpperCaseLetter(String char) {
    return char.toUpperCase() == char && char.toLowerCase() != char;
  }

  bool _isSeparator(String char) {
    return char == '-' || char == '_' || char == ' ';
  }
}
