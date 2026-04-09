class TermReadingPair {

  String term;
  String reading;

  TermReadingPair(this.term, this.reading);

  bool isEmpty() => term.isEmpty && reading.isEmpty;

  @override
  String toString() => '($term, $reading)';

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is TermReadingPair &&
    runtimeType == other.runtimeType &&
    term == other.term &&
    reading == other.reading;

  @override
  int get hashCode => term.hashCode ^ reading.hashCode;
}