

class ParseResult {

  List<String?> segments;
  List<String?> tokens;
  List<String?> readings;
  List<List<String?>> pos;

  ParseResult({
    this.segments = const [],
    this.tokens = const [],
    this.readings = const [],
    this.pos = const []
  });

}