/// Simple dataclass that combines a kanji and its reading 
class FuriganaPair{

  /// The kanji character(s)
  String kanji;
  /// The reading of `kanji` in kana
  String reading;


  FuriganaPair(this.kanji, this.reading);



  bool isEmpty() => kanji.isEmpty && reading.isEmpty;

  @override
  String toString() => '($kanji, $reading)';

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is FuriganaPair &&
    runtimeType == other.runtimeType &&
    kanji == other.kanji &&
    reading == other.reading;

  @override
  int get hashCode => kanji.hashCode ^ reading.hashCode;
}