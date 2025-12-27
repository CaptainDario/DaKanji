/// Holds the specific data parsed from the definition list.
class ParsedDefinitions {
  final List<String> definitions;
  final List<String> posTags;
  final List<ExampleSentence> examples;
  final List<TermForm> forms;
  final List<String> references;

  ParsedDefinitions({
    this.definitions = const [],
    this.posTags = const [],
    this.examples = const [],
    this.forms = const [],
    this.references = const [],
  });

  @override
  String toString() {
    return 'POS: $posTags\n'
           'Defs: $definitions\n'
           'Examples: $examples\n'
           'Forms: $forms\n'
           'References: $references';
  }

  @override
  bool operator ==(Object other) =>
      other is ParsedDefinitions &&
      _listEquals(other.definitions, definitions) &&
      _listEquals(other.posTags, posTags) &&
      _listEquals(other.examples, examples) &&
      _listEquals(other.forms, forms) &&
      _listEquals(other.references, references);
}


class ExampleSentence {
  final String content;
  final String translation;

  ExampleSentence(this.content, this.translation);

  @override
  String toString() => '$content ($translation)';

  @override
  bool operator ==(Object other) =>
      other is ExampleSentence &&
      content == other.content &&
      translation == other.translation;

  @override
  int get hashCode => content.hashCode ^ translation.hashCode;
}

class TermForm {
  final String kanji;
  final String reading;
  final String status;

  TermForm(this.kanji, this.reading, this.status);

  @override
  String toString() => '$kanji [$reading] ($status)';

  @override
  bool operator ==(Object other) =>
      other is TermForm &&
      kanji == other.kanji &&
      reading == other.reading &&
      status == other.status;

  @override
  int get hashCode => kanji.hashCode ^ reading.hashCode ^ status.hashCode;
}

// Helper for list comparison
bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
