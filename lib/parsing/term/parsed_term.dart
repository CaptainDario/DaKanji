import 'package:dakanji_db/parsing/term/term_parsing_method.dart';

/// A class to hold the extracted definition text and the method used to parse it.
class ParsedTerm {
  final String text;
  final TermParsingMethod method;

  ParsedTerm(this.text, this.method);

  @override
  String toString() {
    return 'Definition: "$text" (Method: $method)';
  }
}
