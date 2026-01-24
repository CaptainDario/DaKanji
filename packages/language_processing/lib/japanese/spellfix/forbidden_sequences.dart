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
  "あああ", "いいい", "ううう", "えええ", "おおお", // Triplet kana

  // --- TRIPLET VOWELS ---
  // Matches any character ending in 'a' followed by 'aa'
  // Includes: あ, か, さ, ..., が, ぱ, ゃ, etc.
  r"[あかさたなはまやらわがざだばぱゃ]ああ",

  // Matches any character ending in 'i' followed by 'ii'
  r"[いきしちにひみりぎじぢびぴ]いい",

  // Matches any character ending in 'u' followed by 'uu'
  r"[うくすつぬふむゆるぐずづぶぷゅ]うう",

  // Matches any character ending in 'e' followed by 'ee'
  r"[えけせてねへめれげぜでべぺ]ええ",

  // Matches any character ending in 'o' followed by 'oo'
  r"[おこそとのほもよろごぞどぼぽょ]おお",

];