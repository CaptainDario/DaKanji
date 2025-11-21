const List<String> forbiddenSequences = [
  // forbidden endings
  r"っ$",

  // forbidden beginnings
  r"^ん",
  r"^っ",
  r"^を",
  r"^[ゃゅょ]", 
  r"^[ぁぃぅぇぉ]",

  // impossible sequences
  // You cannot go from a nasal 'n' immediately to a glottal stop 'っ'.
  "んっ",
  // Sokuon (っ) must jump to a consonant (k, s, t, p).
  // It cannot be followed by vowels or 'n'.
  r"っ[あいうえおん]",
  
  // repeated characters
  "んん", // Double n
  "っっ", // Double small tsu
  "ゃゃ", "ゅゅ", "ょょ", // Double small y-vowels
  "ぁぁ", "ぃぃ", "ぅぅ", "ぇぇ", "ぉぉ",// Double small kana
  "あああ", "いいい", "ううう", "えええ", "おおお" // Triplet kana
];