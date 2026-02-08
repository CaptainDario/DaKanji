import 'package:language_processing/src/deconjugation_result.dart';
import 'package:language_processing/src/japanese/japanese_string_operations.dart';
import 'package:language_processing/src/japanese/normalize/normalize.dart' as jp_norm;
import 'package:language_processing/src/japanese/segmentation/segment.dart' as jp_seg;
import 'package:language_processing/src/japanese/sentence_finding.dart';
import 'package:language_processing/src/japanese/spellfix/forbidden_sequences.dart';
import 'package:language_processing/src/japanese/spellfix/spellfix.dart' as jp_spell;
import 'package:language_processing/src/japanese/spellfix/substitutions.dart';
import 'package:language_processing/src/japanese/term_reading_pair/furigana_matching.dart';
import 'package:language_processing/src/japanese/yomitan_deconjugation/deconjugate.dart' as jp_dec;
import 'package:language_processing/src/language_processor.dart';
import 'package:language_processing/src/language_processor_options.dart';
import 'package:language_processing/src/term_reading_pair.dart';
import 'package:mecab_for_dart/mecab_dart.dart';



class JapaneseProcessor extends LanguageProcessor{

  /// State from which a new mecab instance can be created
  /// Note: if this is set to null some methods will throw an exception
  MecabTransferableState? mecabTransferableState;
    
  Mecab? _mecab;

  jp_dec.JapaneseDeconjugator deconjugator = jp_dec.JapaneseDeconjugator();

  Mecab get mecab {
    if (!_initialized || _mecab == null) {
      throw StateError("Mecab is not initialized. Call init() first.");
    }
    return _mecab!;
  }

  bool _initialized = false;
  
  JapaneseProcessor({
    this.mecabTransferableState
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'japanese', // <--- CRITICAL: Identifies this class
      'transferableMecab': _mecab?.transferableState.toJson() ?? mecabTransferableState?.toJson(),
    };
  }

  JapaneseProcessor.fromJson(Map<String, dynamic> json) {
    if (json['transferableMecab'] != null) {
      mecabTransferableState = MecabTransferableState.fromJson(json['transferableMecab']);
    }
  }

  @override
  Future<void> init() async {
    if(mecabTransferableState != null){
      _mecab = await Mecab().fromTransferableState(mecabTransferableState!);
    }
    _initialized = true;
  }

  @override
  Future<void> close() async {
    if (_mecab != null) _mecab!.destroy();

    _initialized = false;
  }
  
  /// Normalizes aterm by:
  /// 1. Converting full-width Romaji to half-width.
  /// 2. Converting half-width Kana to full-width.
  /// 3. Converting Katakana to Hiragana.
  /// 4. Optionally converting Romaji to Hiragana.
  /// 
  /// Options:
  /// - convertRomajiToHiragana: bool (default: false)
  @override
  List<String> normalize(String term, ProcessorOptions options) {

    return jp_norm.normalize(
      term,
      convertRomajiToHiragana: options.japaneseNormalizationConvertsRomajiToHiragana
    );
  }

  @override
  List<String> normalizeAll(List<String> terms, ProcessorOptions options) {

    return jp_norm.normalizeAll(
      terms,
      convertRomajiToHiragana: options.japaneseNormalizationConvertsRomajiToHiragana
    );
  }

  @override
  Set<DeconjugationResult> deconjugate(String term) 
    => deconjugator.deconjugate(term);

  @override
  List<Set<DeconjugationResult>> deconjugateAll(List<String> terms)
    => deconjugator.deconjugateAll(terms);

  @override
  String? segment(String text) => jp_seg.segment(text, mecab);

  @override
  String getReadings(String sentence) {

    List<TokenNode> parsed = mecab.parse(sentence);
    String tokenized = "";
    for (int i = 0; i < parsed.length; i++) {
      if(parsed[i].features.isEmpty) continue;

      tokenized += "${parsed[i].features[10]} ";
    }

    return tokenized;

  }

  @override
  List<String> generateSpellingVariations({
    required String word,
    required int n,
    required int maxCost,
    int substitutionPenalty = 0,
    List<(String, String, int)> rules = spellfixRules,
    List<String> forbiddenSequences = forbiddenSequences,
  }) {
    return jp_spell.generateSpellingVariations(
      word: word,
      n: n,
      maxCost: maxCost,
      substitutionPenalty: substitutionPenalty,
      rules: rules,
      forbiddenSequences: forbiddenSequences
    );
  }

  @override
  bool isIdeographic(String text) => kanjiRegex.hasMatch(text);

  @override
  List<TermReadingPair> getTermReadingPairs(
    String term, String reading, ProcessorOptions options) 
      => matchFurigana(
        term, reading,
        convertToKatakana: options.japaneseGetTermReadingPairsConvertToKatakanaForFurigana
      );

  @override
  List<String> findSentences(String text) => findSentencesRegexp(text);
  

}