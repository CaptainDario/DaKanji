class ParsedDictionaryEntry {
  final String headword;
  final String reading;
  final List<String> definitions;
  final List<String> posTags;
  final List<ExampleSentence> examples;
  final List<TermForm> forms;
  final String? reference;

  ParsedDictionaryEntry({
    required this.headword,
    required this.reading,
    this.definitions = const [],
    this.posTags = const [],
    this.examples = const [],
    this.forms = const [],
    this.reference,
  });

  @override
  String toString() {
    if (reference != null) {
      return 'Entry: $headword ($reading) ⟶ Redirect: $reference';
    }
    return 'Entry: $headword ($reading)\n'
           'POS: $posTags\n'
           'Defs: $definitions\n'
           'Forms: $forms\n'
           'Examples: $examples';
  }

  // Equality overrides for testing
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParsedDictionaryEntry &&
          runtimeType == other.runtimeType &&
          headword == other.headword &&
          reading == other.reading &&
          _listEquals(definitions, other.definitions) &&
          _listEquals(posTags, other.posTags) &&
          _listEquals(examples, other.examples) &&
          _listEquals(forms, other.forms) &&
          reference == other.reference;

  @override
  int get hashCode =>
      headword.hashCode ^
      reading.hashCode ^
      definitions.hashCode ^
      reference.hashCode;
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
