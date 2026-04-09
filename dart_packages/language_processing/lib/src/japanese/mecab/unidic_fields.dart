/// Represents the zero-based index of UniDic fields within a MeCab feature array.
class UniDicFields {
  /// Part of speech field 1 (most general).
  static const int pos1 = 0;
  
  /// Part of speech field 2.
  static const int pos2 = 1;
  
  /// Part of speech field 3.
  static const int pos3 = 2;
  
  /// Part of speech field 4 (most specific).
  static const int pos4 = 3;

  /// 活用型, conjugation type. Will have a value like 五段-ラ行.
  static const int cType = 4;

  /// 活用形, conjugation shape. Will have a value like 連用形-促音便.
  static const int cForm = 5;

  /// 語彙素読み, lemma reading. The reading of the lemma in katakana.
  static const int lForm = 6;

  /// 語彙素（＋語彙素細分類）. The lemma is a non-inflected "dictionary form" of a word.
  static const int lemma = 7;

  /// 書字形出現形, the word as it appears in text, identical to the surface.
  static const int orth = 8;

  /// 発音形出現形, pronunciation. Similar to kana except long vowels are indicated with a ー (e.g., こーし).
  static const int pron = 9;

  /// 書字形基本形, the uninflected form of the word using its current written form (e.g., 彷徨う).
  static const int orthBase = 10;

  /// 発音形基本形, the pronunciation of the base form.
  static const int pronBase = 11;

  /// 語種, word type. Etymological category: 和, 固, 漢, 外, 混, 記号, 不明.
  static const int goshu = 12;

  /// 語頭変化化型, initial transformation type the word undergoes when combining.
  static const int iType = 13;

  /// 語頭変化形, initial form of the word in context.
  static const int iForm = 14;

  /// 語末変化化型, final transformation type.
  static const int fType = 15;

  /// 語末変化形, final form of the word in context.
  static const int fForm = 16;

  /// 語頭変化結合型, initial change fusion type in counting expressions.
  static const int iConType = 17;

  /// 語末変化結合型, final change fusion type in counting expressions.
  static const int fConType = 18;

  /// Seems to have some overlap with POS.
  static const int type = 19;

  /// 読みがな, the typical representation of a word in kana (e.g., こうし).
  static const int kana = 20;

  /// 仮名形基本形, the typical kana representation of the lemma.
  static const int kanaBase = 21;

  /// 語形出現形, seems to be the same as pron.
  static const int form = 22;

  /// 語形基本形, seems to be the same as pronBase.
  static const int formBase = 23;

  /// Accent type. Number of the mora taking the accent in 標準語 (standard language).
  static const int aType = 24;

  /// Describes how the accent shifts when the word is used in a counter expression.
  static const int aConType = 25;

  /// Presumably accent related but unclear use.
  static const int aModType = 26;

  /// 語彙表ID. A long lemma ID (GUID-like).
  static const int lid = 27;

  /// 語彙素ID. A shorter lemma id, starting from 1.
  static const int lemmaId = 28;
}