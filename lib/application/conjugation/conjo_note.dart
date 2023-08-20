


/// Class to combine all elements of a conjo_notes.csv row and add
/// descriptions of the values.
/// 
/// The `pos`, `conj`, `neg`, `fml`, and `onum` form a unique key identifying
/// each conjugation
class ConjoNote {

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
  /// A note for this `ConjoNote` maps to `conotes`
  final int note;


  const ConjoNote(
    this.pos,
    this.conj,
    this.neg,
    this.fml,
    this.onum,
    this.note
  ) : super();

  @override
  operator ==(Object other) =>
    other is ConjoNote      &&
    pos  == other.pos  &&
    conj == other.conj &&
    neg  == other.neg  &&
    fml  == other.fml  &&
    onum == other.onum &&
    note == other.note;
  
  @override
  int get hashCode => Object.hashAll([pos, conj, neg, fml, onum, note]);

  int get hasCode => 
    Object.hashAll([
      pos,
      conj,
      neg,
      fml,
      onum,
      note
    ]);
  
}