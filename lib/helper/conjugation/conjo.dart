


class Conjo {

  /// A part-of-speech number.  These are defined in kwpos.csv and each number 
  /// corresponds to a keyword like 'v1', 'v5k' 'n', 'vs, adj-i', etc, as
  /// used in wwwjdict, JMdict.xml, etc.
  final int pos;
  /// A conjugation number.  These are defined in conj.csv.
  final int conj;
  /// If false, this row is for the affirmative conjugation form.  If true, for
  /// the negative form.
  final String neg;
  /// If false, this row is for the plain conjugation form. 
  /// If true, for the formal (aka polite) form.
  final String fml;
  /// A disambiguating number (starting from 1) for rows containing variant
  /// okurigana for the same conjugation (e.g., ～なくて and ～ないで).
  final int onum;
  /// The number of characters to remove from the end of a word before adding
  /// okurigana.
  final int stem;
  /// The okurigana text for the conjugated form.
  final String okuri;
  /// Replacement kana text for the verb stem in cases where there is a euphonic
  /// change in the stem (e.g. く -> こ in 来る -> 来ない).
  final String? euphr;
  /// Replacement kanji text when there is a kanji change in the stem. (The only
  /// case of this is for the Potential conjugation form of suru: 為る・する -> 
  /// 出来る・できる).
  final String? euphk;

  const Conjo(
    this.pos,
    this.conj,
    this.neg,
    this.fml,
    this.onum,
    this.stem,
    this.okuri,
    {
      this.euphr,
      this.euphk
    }
  );
}