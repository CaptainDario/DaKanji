var forbiddenSequences = [
  r"^っ", // forbidden begininngs
  r"$ん", // forbidden endings
  "っっ", // Double small tsu
  "ゃゃ", "ゅゅ", "ょょ", // Double small y-vowels
  "ぁぁ", "ぃぃ", "ぅぅ", "ぇぇ", "ぉぉ",// Double small kana
  "あああ", "いいい", "ううう", "えええ", "おおお" // Triplet kana
];